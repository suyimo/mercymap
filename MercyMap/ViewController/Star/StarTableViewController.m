//
//  StarTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarTableViewController.h"
#import "StarTableViewCell.h"
#import "StarSecondTableViewCell.h"
#import "StarInfornationTableViewController.h"
#import "WalkRouteTableViewController.h"
#import "LightKindTableViewController.h"
#import "LogViewController.h"
#import "LoginService.h"
#import "AppDelegate.h"
#import "ButtonAdd.h"
#import "Single.h"
#import "YCXMenu.h"
#import "AboutUSViewController.h"
#import "MercyInfoTableViewController.h"

@interface StarTableViewController ()
{
    LoginService *Service;
    Single *single;
    NSMutableDictionary *dic;
}
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation StarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Service =[[LoginService alloc]init];
    dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    single =[Single Send];
    
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.5];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [rightBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(addSet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =rightItem;
//    [self getInforNation];

    
}


-(NSMutableArray *)items {
    if(!_items) {
        _items = [NSMutableArray array];
        _items = [@[
                    
                    [YCXMenuItem menuItem:@" 关于我们"
                                    image:[UIImage imageNamed:@"home_iconfont-saoyisao"]
                                      tag:101
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@" 使用说明"
                                    image:[UIImage imageNamed:@"home_iconfont-dingdan"]
                                      tag:102
                                 userInfo:@{@"title":@"Menu"}],
                    
                    [YCXMenuItem menuItem:@" 最新版本"
                                    image:[UIImage imageNamed:@"home_iconfont-saoyisao"]
                                      tag:103
                                 userInfo:@{@"title":@"Menu"}],
                    
                    [YCXMenuItem menuItem:@" 退出"
                                    image:[UIImage imageNamed:@"home_iconfont-saoyisao"]
                                      tag:100
                                 userInfo:@{@"title":@"Menu"}],
                    
                   ] mutableCopy];
        
    }
    return _items;
}


-(void)addSet
{
    [YCXMenu setTintColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:0.5]];
    
    if ([YCXMenu isShow]){
        
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width-20,64,0,0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            if (item.tag == 100) {
                
                [self jump];
            }
            if(item.tag ==101)
            {
               MercyInfoTableViewController *ABVC =[[MercyInfoTableViewController alloc]initWithNibName:@"MercyInfoTableViewController" bundle:nil];
                ABVC.Mfag =1;
                [self.navigationController pushViewController:ABVC animated:YES];
                
            }
            if (item.tag ==102) {
                
                MercyInfoTableViewController *ABVC =[[MercyInfoTableViewController alloc]initWithNibName:@"MercyInfoTableViewController" bundle:nil];
                                ABVC.Mfag =2;
                [self.navigationController pushViewController:ABVC animated:YES];
                
                
                
            }
            if (item.tag==103) {
                
                MercyInfoTableViewController *ABVC =[[MercyInfoTableViewController alloc]initWithNibName:@"MercyInfoTableViewController" bundle:nil];
                ABVC.Mfag =3;
                [self.navigationController pushViewController:ABVC animated:YES];
                
                
                
            }
        }];
    }
    


}


-(void)jump
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"ID"];
    [defaults removeObjectForKey:@"Password"];
    [defaults removeObjectForKey:@"MobileNum"];
    [defaults removeObjectForKey:@"Token"];
    [defaults removeObjectForKey:@"UserLogin"];
    [defaults removeObjectForKey:@"newUser"];
    [defaults removeObjectForKey:@"NickName"];
    
    LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
    
    [logVC setHidesBottomBarWhenPushed:YES];
    
    logVC.fagB =1;
    
    [self.navigationController pushViewController:logVC animated:YES];
    
}

-(void)getInforNation
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
    {
        
        
        
        [Service getUser:single.ID Token:single.Token successBlock:^(NSDictionary *model) {
            
            [dic setDictionary:model];
            [self.tableView reloadData];
            
        }
        Failuer:^(NSString *error) {
            
            NSLog(@"Wrong");
            
        }];
 
    }
    else
    {
       
           NSString *str =[NSString stringWithFormat:@"游客%d",single.ID];
            
            NSString *str1 =[NSString stringWithFormat:@"日行一善"];
            NSDictionary *dic1 =@{@"NickName":str,@"Idiograph":str1,@"HeadImg":[NSNull null]};
            [dic addEntriesFromDictionary:dic1];
    }
  
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if (section ==1) {
        return 1;
    }
      else
        return 1;
        
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
    }
    else
        return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =nil;
    if (indexPath.section ==0)
    {
      
        StarTableViewCell *Starcell = [tableView dequeueReusableCellWithIdentifier:@"Star" forIndexPath:indexPath];
        
        Starcell.userNameLable.text =[NSString stringWithFormat:@"%@",dic[@"NickName"]];
        
        if (single.nickname==nil) {
            
           Starcell.introduceselfLable.text=[NSString stringWithFormat:@"%@",dic[@"Idiograph"]];
        }
        else{
            Starcell.introduceselfLable.hidden =YES;
        }
        
        if (![dic[@"HeadImg"]isKindOfClass:[NSNull class]])
        {
            NSString *imageStr ;
            if (single.nickname==nil) {
                
              imageStr=[NSString stringWithFormat:@"%@%@",pictureUrl,dic[@"HeadImg"]];

            }
            else
            {
                imageStr = dic[@"HeadImg"];
            }
            
            NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            
          NSURL *imageUrl =[NSURL URLWithString:Imgstr];
         [Starcell.headImageView sd_setImageWithURL:imageUrl];
            
        }
        else
        {
            Starcell.headImageView.image =[UIImage imageNamed:@"youke.jpg"];

        }
        cell=Starcell;
       
    }
    
if (indexPath.section ==1)
    {
         StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        
//        if (indexPath.row==0)
//        {
//             secondCell.secondImageView.image =[UIImage imageNamed:@"map"];
//             secondCell.secondNameLable.text =[NSString stringWithFormat:@"足迹"];
//        }
//        else
//        {
            secondCell.secondImageView.image =[UIImage imageNamed:@"look"];
            
            secondCell.secondNameLable.text =[NSString stringWithFormat:@"我的关注"];
//        }
       
        cell = secondCell;

    }
    if (indexPath.section ==2)
    {
         StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        
        secondCell.secondImageView.image =[UIImage imageNamed:@"renzheng"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"用户认证"];
        cell = secondCell;

    }
   
    if ( indexPath.section ==3)
    {
         StarSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondC"forIndexPath:indexPath];
        
        secondCell.secondImageView.image =[UIImage imageNamed:@"tongzhi"];
        secondCell.secondNameLable.text =[NSString stringWithFormat:@"通知"];
        
         cell = secondCell;
    }
   
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {   if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){

        StarInfornationTableViewController *inforVC = [[StarInfornationTableViewController alloc]initWithNibName:@"StarInfornationTableViewController" bundle:nil];
        [self.navigationController pushViewController:inforVC animated:YES];
    }
    else
    {
        [self alterController];
    }
    }
    
    
    if ( indexPath.section ==1) {
        
//        if (indexPath.row==0) {
//            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
//            {
//            
//            WalkRouteTableViewController *walkVC = [[WalkRouteTableViewController alloc]initWithNibName:@"WalkRouteTableViewController" bundle:nil];
//            [self.navigationController pushViewController:walkVC animated:YES];
//            }
//            else
//            {
//                [self alterController];
//            }
//        }
//        
//        else
//        {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
             {
            
            LightKindTableViewController *lightVC = [self.storyboard instantiateViewControllerWithIdentifier:@"kindS"];
            lightVC.fag1 = 0;
            
            [self.navigationController pushViewController:lightVC animated:YES];
          }
             else
             {
                 [self alterController];
             }
//        }
        
    }
    
    if (indexPath.section ==2) {
        
             LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
            //隐藏tabbar
            [logVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:logVC animated:YES];
    }
    
    if (indexPath.section ==3)
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
        {
           
            AboutUSViewController *ABVC =[[AboutUSViewController alloc]initWithNibName:@"AboutUSViewController" bundle:nil];
            ABVC.Mfag =1;
            [self.navigationController pushViewController:ABVC animated:YES];
            

        }
        else
        {
            [self alterController];
        }
        
    }
    
    
}




-(void)alterController
{
    UIAlertController *alterController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请到用户认证登录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *OK =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        LogViewController *logVC =[[LogViewController alloc]initWithNibName:@"LogViewController" bundle:nil];
        
        [logVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:logVC animated:YES];
    }];
    
    [alterController addAction:OK];
    [self presentViewController:alterController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getInforNation];
//    [self.tableView reloadData];
}

@end
