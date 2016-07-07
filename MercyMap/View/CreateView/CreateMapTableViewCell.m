//
//  CreateMapTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/22.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreateMapTableViewCell.h"
#import "ButtonAdd.h"



@interface CreateMapTableViewCell ()<UITextFieldDelegate>
{
    
}

@end

@implementation CreateMapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [MAMapServices sharedServices].apiKey = @"8c136b29c6b5808b60128bf548dff050";
    [AMapSearchServices sharedServices].apiKey = @"8c136b29c6b5808b60128bf548dff050";
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    

    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.createmapView.bounds), CGRectGetHeight(self.createmapView.bounds))];
    
    _mapView.delegate =self;
    
    _mapView.mapType = MAMapTypeStandard;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    [_mapView setZoomLevel:16.1 animated:YES];
    
    self.createmapTextfield.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Address"];
    
    [self.createmapView addSubview:_mapView];
    
    self.createmapTextfield.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];
    
}


- (IBAction)searchBtnClick:(id)sender {
    
    ButtonAdd *length = [[ButtonAdd alloc]init];
    
    if ([length checkInput:_createmapTextfield.text])
        
    {
        [CommoneTools alertOnView:self content:@"请填写完整"];
    }
    else
    {
        [self getLocation];
    }


}


-(void)getLocation
{
    
    //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords =_createmapTextfield.text;
    //    request.city =self.Lightcity.text;
    
    //关键字搜索
    [_search AMapPOIKeywordsSearch: request];
    
}


- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    AMapPOI *p =[response.pois firstObject];
    
    self.location=p.location;
    
    _mapView.delegate =self;
    
    pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.title =_createmapTextfield.text;
    pointAnnotation.coordinate =CLLocationCoordinate2DMake(p.location.latitude,p.location.longitude);
    
    self.Mlocation =[NSString stringWithFormat:@"%f,%f",p.location.latitude,p.location.longitude];
    
    [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
    [_mapView addAnnotation:pointAnnotation];
    
}


-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        annotationView.canShowCallout= YES;    //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;     //设置标注动画显示，默认为NO
        annotationView.draggable = YES;       //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    return nil;
    
}


-(void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    
    if (newState == MAAnnotationViewDragStateEnding)
    {
        //        _isSearchFromDragging = YES;
        //        self.annotation = view.annotation;

        CLLocationCoordinate2D coordinate = view.annotation.coordinate;
        
        [self searchReGeocodeWithCoordinate:coordinate];
    }
    
}



- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [_search AMapReGoecodeSearch:regeo];
}

//逆地理编码回调

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil )
    {
        //        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
        
        pointAnnotation.coordinate =CLLocationCoordinate2DMake(request.location.latitude,request.location.longitude);
        pointAnnotation.title = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        
        self.createmapTextfield.text = pointAnnotation.title;
        self.Mlocation =[NSString stringWithFormat:@"%f,%f",request.location.latitude,request.location.longitude];
        [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
        [_mapView addAnnotation:pointAnnotation];
        
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
@end
