//
//  LightTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/7.
//  Copyright © 2016年 Wispeed. All rights reserved.
//
#import "AppDelegate.h"
#import "LightTableViewController.h"
#import "LightHeadTableViewCell.h"
#import "LightListTableViewCell.h"
#import "LightKindTableViewCell.h"
#import "LightKindTableViewCell.h"
#import "LightKindTableViewController.h"
#import "LightListTableViewController.h"
#import "ButtonAdd.h"
#import "LoginService.h"
#import "MJRefresh.h"
#import "CityTableViewController.h"
//#import "CreateLightFirstViewController.h"
#import "MapViewSet.h"
#import "YCXMenu.h"
#import "CreateTableViewController.h"
@interface LightTableViewController ()<sendDelegate,singleTapsDelegate,UITextViewDelegate>
{
//    UIView *setView;
    UIButton *cityBtn;
    int fag;
//    MJRefreshAutoNormalFooter *footer;
    LoginService *SerVice;
    int pageNum;
    NSMutableArray *finallyArray;
    MapViewSet *mapviewSet;

}

@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation LightTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
     self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:24/255.0 green:147/255.0 blue:30/255.0 alpha:1.0];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.6];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    SerVice =[[LoginService alloc]init];
    mapviewSet =[[MapViewSet alloc]init];
    
    finallyArray = [[NSMutableArray alloc]initWithCapacity:0];
    pageNum =0;
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem ;
    
//    setView = [[UIView alloc]initWithFrame:CGRectMake(MainScreen.size.width-80, 0, 0, 0)];
//    UIWindow *window =[UIApplication sharedApplication].keyWindow;

    self.tableView.showsVerticalScrollIndicator = NO;
    [self LightList];
    [self citySet];

    

    //刷新
    self.tableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self LightList];
//            [self.tableView reloadData];

        });
    }];

    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
            pageNum =0;
            [self LightList];


//            [self performSelector:@selector(LightList) withObject:self afterDelay:0];
//        });
    }];
    
    
    self.tableView.footer.hidden =YES;
    
    
}



-(void)LightList
{
   
    [SerVice getLightListInfonation:pageNum Pagesize:5 successBlock:^(NSArray *modelArray) {
        
        if (pageNum ==0) {
            
            [finallyArray removeAllObjects];
            
        }
        pageNum ++;
        [finallyArray addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];

        if (modelArray.count==0) {
            
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

      
    }Failuer:^(NSString *error) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力!";
        [hud hide: YES afterDelay: 2];
        
    }];

}



-(void)citySet
{
    UIView *CityChooseV = [[UIView alloc]initWithFrame:CGRectMake(-10, 0, 90, 30)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(30,6, 18, 18)];
    
    cityBtn =[[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 60, 25)];
    cityBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    
    

    cityBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    imageV.image = [UIImage imageNamed:@"jiantou"];
    
    NSString *str =[[NSUserDefaults standardUserDefaults]objectForKey:@"CityName"];
    
    if (str==nil)
    {
        NSString *Lstr =[[NSUserDefaults standardUserDefaults]objectForKey:@"LocationCityName"];

        
        [cityBtn setTitle:Lstr forState:UIControlStateNormal];
    }
    else
    {
        [cityBtn setTitle:str forState:UIControlStateNormal];

    }
    
    
    [cityBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(cityChoose) forControlEvents:UIControlEventTouchUpInside];
    
    [CityChooseV addSubview:cityBtn];
    [CityChooseV addSubview:imageV];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:CityChooseV];
    self.navigationItem.leftBarButtonItem = leftItem;
}


-(void)LocationCity
{
    
    
    
}


-(void)cityChoose
{
    
    CityTableViewController *CityVC = [[CityTableViewController alloc]initWithNibName:@"CityTableViewController" bundle:nil];
    CityVC.fag =1;
    
    [self.navigationController pushViewController:CityVC animated:YES];
    
    CityVC.ReturnBlock =^(NSString *str)
    {
        [cityBtn setTitle:str forState:UIControlStateNormal];
        [cityBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];

    };
    
}



-(void)setView
{

 [self.navigationController pushViewController:[[CreateTableViewController alloc]initWithNibName:@"CreateTableViewController" bundle:nil]animated:YES];

}

-(void)createLight
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        
//        CreateLightFirstViewController *CLV = [[CreateLightFirstViewController alloc]initWithNibName:@"CreateLightFirstViewController" bundle:nil];
        
//        [self.navigationController pushViewController:CLV animated:YES];
    }
   
    else
    {
        ButtonAdd *alterBtn =[[ButtonAdd alloc]init];
        
        [alterBtn AlterView:self];
    }
}


-(void)sendFag:(int)fag1
{
    LightKindTableViewController *kindVC = [self.storyboard instantiateViewControllerWithIdentifier:@"kindS"];
    kindVC.fag1 = fag1;

    [self.navigationController pushViewController:kindVC animated:YES];


}

-(void)singleTaps:(int)ID
{
    LightListTableViewController *ListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LightS"];
    ListVC.ID=ID;
    [ListVC setHidesBottomBarWhenPushed:YES];

    [self.navigationController pushViewController:ListVC animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if (section==2)
     {
         
        return finallyArray.count;
    }
    else
        return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 200;
        
    }
    else
        return 80;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =nil;
    
    if ( indexPath.section ==0)
    {
        LightHeadTableViewCell *headCell =[tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
//        [headCell reloadInputViews];
        
         headCell.delegate=self;
         cell =headCell;
    }
    
    else if (indexPath.section ==1)
    {
        LightKindTableViewCell *kindCell =[tableView dequeueReusableCellWithIdentifier:@"kindCell"forIndexPath:indexPath];
        kindCell.delegate =self;
        
        cell = kindCell;
        
    }
    
    else
    {
        LightListTableViewCell *listCell =[tableView dequeueReusableCellWithIdentifier:@"listCell"forIndexPath:indexPath];
        
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self.tableView setSeparatorColor:[UIColor grayColor]];
        
        listCell.LightNameLable.text =finallyArray[indexPath.row][@"ShopName"];
        listCell.LightintroduceLable.text =finallyArray[indexPath.row][@"ShopStory"];
        listCell.dianzanLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"LikedCount"] intValue]];
        listCell.commentLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"CommentCount"]intValue]];
        
//        NSLog(@"%ld",(long)indexPath.row);
        NSString *str =[NSString stringWithFormat:@"%@",finallyArray[indexPath.row][@"ShopMainImg"]];
        NSString *Imgstr =[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pictureUrl,Imgstr]];
        
        [listCell.LightImageView sd_setImageWithURL:imageUrl];
        cell = listCell;
     
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section==2)
    {
        LightListTableViewController *ListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LightS"];
        [ListVC setHidesBottomBarWhenPushed:YES];
         ListVC.ID=[finallyArray[indexPath.row][@"ID"]intValue];
        
        [self.navigationController pushViewController:ListVC animated:YES];
  
    }
   else
    {
      NSLog(@"gg");
    }
    
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*
 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    CityTableViewController *cityVC =segue.destinationViewController;
    [cityVC returnCity:^(NSString *Cstr) {
        
        [cityBtn setTitle:Cstr forState:UIControlStateNormal];

        
    }];


}
*/

@end
