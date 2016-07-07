//
//  MapViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/29.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MapViewController.h"
#import<MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MapViewSet.h"
#import "LoginService.h"


//#import "AMapLocationKit.h"
@interface MapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
{
    MAMapView *_mapView;
    MapViewSet *mapViewSet;
    LoginService *SerVice;
    NSMutableArray *finallyArray;
    
}
//@property(nonatomic,strong) MAMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     mapViewSet =[[MapViewSet alloc]init];
    _mapView =[[MAMapView alloc]init];
    _mapView.delegate =self;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:1.0];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.6];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    SerVice =[[LoginService alloc]init];
    finallyArray =[[NSMutableArray alloc]initWithCapacity:0];

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];



}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [SerVice getLightListInfonation:0 Pagesize:50 successBlock:^(NSArray *modelArray)
    {
    
    [finallyArray removeAllObjects];
        
    [finallyArray addObjectsFromArray:modelArray];
        
    [mapViewSet setLocationView:_mapView selfView:self dataArray:finallyArray];

        
    } Failuer:^(NSString *error) {
        
    }];
    
}





@end
