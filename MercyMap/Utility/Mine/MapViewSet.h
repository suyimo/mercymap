//
//  MapViewSet.h
//  MercyMap
//
//  Created by sunshaoxun on 16/5/25.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MapEntity.h"

@interface MapViewSet : NSObject<AMapLocationManagerDelegate,MAMapViewDelegate,MKMapViewDelegate>
{
    AMapLocationManager *locationManager;
    NSMutableArray *MapdataArray;
    UIViewController *comeView;
    int fag;

}
@property (nonatomic) CLLocationCoordinate2D Mapcoordinate;

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

-(void)setLocationView:(MAMapView *)mapview selfView:(UIViewController *)selfView dataArray:(NSMutableArray *)dataArray;

-(void)setcity;

-(void)rightBtnClick:(CLLocationCoordinate2D)mapCoordinate view:(UIViewController *)BackView fag:(int)fag1;
@end
