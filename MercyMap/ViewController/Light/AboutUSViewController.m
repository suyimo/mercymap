//
//  AboutUSViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/13.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "AboutUSViewController.h"
#import "BaseHttpRequest.h"
@interface AboutUSViewController ()
{
    NSMutableArray *dataArray ;
}
@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    dataArray=[NSMutableArray arrayWithCapacity:0];
    self.title =@"通知";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    [self setinfo];

}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//-(void)getMercyInfo:(int)fag{
//    
//
//    BaseHttpRequest *serVice  =[[BaseHttpRequest alloc]init];
//    NSString *url =[NSString stringWithFormat:@"%@api/Common/MercymapConfig",URLM];
//    
//    [serVice sendRequestHttp:url parameters:nil Success:^(NSDictionary *dicData) {
//        if (fag==1)
//        {
//            [dataArray addObject: dicData[@"MercyMapConfig"][@"AboutUS"]];
//        }
//        else if (fag==2)
//        {
//            [dataArray addObject:dicData[@"MercyMapConfig"][@"DirectionsForuse"]];
//
//        }
//        else if (fag==3)
//        {
//            [dataArray addObject:dicData[@"MercyMapConfig"][@"VersionNumber"]];
//        }
//        
//        
//        [self setinfo];
//
//    } Failuer:^(NSString *errorInfo) {
//        
//    }];
//
//}
//
//
-(void)setinfo
{
    self.aboutInfoLable.text =@"暂无消息";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
