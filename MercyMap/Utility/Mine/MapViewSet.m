//
//  MapViewSet.m
//  MercyMap
//
//  Created by sunshaoxun on 16/5/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
#import "MapViewSet.h"
#import "MapViewModel.h"
#import<MAMapKit/MAMapKit.h>

@implementation MapViewSet

-(void)setLocationView:(MAMapView *)mapview selfView:(UIViewController*)selfView dataArray:(NSMutableArray *)dataArray
{
    [MAMapServices sharedServices].apiKey = @"8c136b29c6b5808b60128bf548dff050";
    comeView =selfView;
    
    mapview.delegate = self;
    mapview.mapType = MAMapTypeStandard;
    mapview = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(selfView.view.bounds), CGRectGetHeight(selfView.view.bounds))];
    
    mapview.showsUserLocation = YES;
    mapview.userTrackingMode = MAUserTrackingModeFollow;
    
    //地图比例
    [mapview setZoomLevel:16.1 animated:YES];
    
    for(int i =0;i<dataArray.count;i++)
    {
        if (![dataArray[i][@"ShopGPS"]isKindOfClass:[NSNull class]])
        {
            mapview.delegate = self;
            MapViewModel *annotation = [[MapViewModel alloc] init];

            NSString *str =dataArray[i][@"ShopGPS"];
            NSArray *array = [str componentsSeparatedByString:@","];
            
            annotation.title =dataArray[i][@"ShopName"];
            annotation.subtitle =dataArray[i][@"ShopAddr"];
            annotation.image = [UIImage imageNamed:@"locationA"];
            
            float latitude = [array[0] floatValue];
            float longitude =[array[1] floatValue];
            annotation.coordinate =CLLocationCoordinate2DMake(latitude ,longitude);
            
            [mapview addAnnotation:annotation];
        }
        
    }
    
    [selfView.view addSubview:mapview];

}




-(void)setcity
{
    [AMapLocationServices sharedServices].apiKey= @"8c136b29c6b5808b60128bf548dff050";
    
    [self initCompleteBlock];
    
    locationManager = [[AMapLocationManager alloc] init];
    [locationManager setLocationTimeout:2];
    [locationManager setReGeocodeTimeout:2];
    
    locationManager.delegate = self;
    [locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [locationManager setPausesLocationUpdatesAutomatically:YES];
    
//    [locationManager setAllowsBackgroundLocationUpdates:YES];
    
}


- (void)initCompleteBlock
{
    __weak MapViewSet *MSelf = self;

    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                [MSelf setcity];
            }
        }
        
        if (location)
        {
            if (regeocode)
            {
                
                if (![regeocode.city isKindOfClass:[NSNull class]])
                {
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults removeObjectForKey:@"LocationCityName"];
                    [defaults removeObjectForKey:@"LoccationAdress"];
                    [defaults removeObjectForKey:@"Address"];
                    
                    NSString *locationAddress = [NSString stringWithFormat:@"%f,%f",location.coordinate.longitude,location.coordinate.latitude];
                    
                    
                    [defaults setObject:locationAddress forKey:@"LocationAdress"];
                    
                    [defaults setObject:regeocode.province forKey:@"LocationCityName"];
                    
                    [defaults setObject:[NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.number] forKey:@"Address"];
                }
                
                else
                {
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults removeObjectForKey:@"LocationCityName"];
                    [defaults setObject:regeocode.city forKey:@"LocationCityName"];
                    
                    [defaults removeObjectForKey:@"LoccationAdress"];
                    NSString *locationAddress = [NSString stringWithFormat:@"%f,%f",location.coordinate.longitude,location.coordinate.latitude];
                    [defaults setObject:locationAddress forKey:@"LocationAdress"];

                }
                
                
            }
            else
            {
//                [wSelf.Lightcity setText:[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]];
            }
        }
  
    };
}




- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MapViewModel class]])
    {
    
     static NSString *animatedAnnotationIdentifier = @"AnimatedAnnotationIdentifier";
        
     MAPinAnnotationView  *annotationView = (MAPinAnnotationView  *)[mapView dequeueReusableAnnotationViewWithIdentifier:animatedAnnotationIdentifier];
        
        if (annotationView == nil)
        {
            
            annotationView = [[MAPinAnnotationView  alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:animatedAnnotationIdentifier];
            
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Go"]];
//            
//            annotationView.leftCalloutAccessoryView =imageView;
            UIButton *rightButton   =   [UIButton buttonWithType:UIButtonTypeCustom];
            rightButton.frame       =   CGRectMake(0, 0, 32, 32);

            [rightButton setImage:[UIImage imageNamed:@"Go"] forState:UIControlStateNormal];
            rightButton.layer.borderColor = [UIColor blackColor].CGColor;
            rightButton.showsTouchWhenHighlighted   =   YES;
            
            [rightButton addTarget:self action:@selector(rightBtnClick:view:fag:) forControlEvents:UIControlEventTouchUpInside];
            fag =1;
            
            annotationView.rightCalloutAccessoryView = rightButton;
            
            annotationView.animatesDrop     = NO;
            annotationView.canShowCallout   = YES;
            
            
        }
        /**
         *  有可能从缓冲池里出来
         */
        annotationView.annotation=annotation;
        annotationView.image=((MapViewModel *)annotation).image;//设置大头针视图的图片
        

        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    _Mapcoordinate =view.annotation.coordinate;

}


-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    
}



-(void)rightBtnClick:(CLLocationCoordinate2D)mapCoordinate view:(UIViewController *)BackView fag:(int)fag1
{
    if (fag==1)
    {
        mapCoordinate = _Mapcoordinate;
        BackView =comeView;
        
//        fag =0;
    }
    else
    {
        
//        NSLog(@"gg");
        
    }
    
    
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"地图选择" message:@"支持苹果、百度、高德地图" preferredStyle:UIAlertControllerStyleActionSheet];
    
    MapdataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self checkInstallMapApps];
    
    for (int i=0; i< MapdataArray.count; i++) {
        
        UIAlertAction *MapAc =[UIAlertAction actionWithTitle:MapdataArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
          
            if ([MapdataArray[i]isEqualToString:@"苹果地图"])
            {
                [self navAppleMap:mapCoordinate];
                
            }
            if ([MapdataArray[i]isEqualToString:@"高德地图"])
            {
//            
//             NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"mercyMap:wispeed",mapCoordinate.latitude,mapCoordinate.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSString *urlString =[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"mercyMap:wispeed",mapCoordinate.latitude,mapCoordinate.longitude];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

                
            }
            
            if ([MapdataArray[i]isEqualToString:@"百度地图"])
            {
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",_Mapcoordinate.latitude,_Mapcoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

            }
            
            
        }];
        
        [alterController addAction:MapAc];
        
    }
    
    UIAlertAction *canceAC =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler: nil];
    
    [alterController addAction:canceAC];
    
  [BackView presentViewController:alterController animated:YES completion:nil];
    
}



- (NSArray *)checkInstallMapApps
{
    
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0){
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }
        }
    }
    
    MapdataArray = appListArr;
    return MapdataArray;
}

- (void)navAppleMap:(CLLocationCoordinate2D)mapCoordinate
{
    
//    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.destinationCoordinate2D];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:mapCoordinate addressDictionary:nil]];
    
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
}


@end
