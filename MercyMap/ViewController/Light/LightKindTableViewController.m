//
//  LightKindTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightKindTableViewController.h"
#import "LoginService.h"
#import "LightListKindTableViewCell.h"
#import "LightListTableViewController.h"
#import "MJRefresh.h"
#import "Single.h"
@interface LightKindTableViewController ()
{
    LoginService *SerVice;
    int pageNum;
    NSMutableArray *finallyArray;
    
    
}
@end

@implementation LightKindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SerVice = [[LoginService alloc]init];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    finallyArray = [[NSMutableArray alloc]initWithCapacity:0];
    pageNum =0;
    [self kindChooseMore];
    
    self.tableView.footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(kindChooseMore) withObject:self afterDelay:1];
        
    }];
    
   self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        pageNum =0;
       [self kindChooseMore];
       
   }];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)kindChooseMore
{
    if (_fag1 ==0) {
        Single *single =[Single Send];
        self.title =@"我的关注";
        
        [SerVice CollectionInfo:single.ID FocusType:1 Token:single.Token PageSize:20 PageIndex:pageNum SuccesBlock:^(NSArray *modelArray) {
            
            pageNum ++;
            [finallyArray addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            
            [self.tableView.footer endRefreshing];
            [self.tableView.header endRefreshing];
            if (modelArray.count==0) {
                [self.tableView.footer endRefreshingWithNoMoreData];
            }
            

        } FailuerBlock:^(NSString *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];

            
        }];
        
        
        
    }
    
    else
    {
     [SerVice getLightKindInfornation:self.fag1 PageIndex:pageNum PageSize:20 successBlock:^(NSArray *modelArray)
    {
       
        
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
        
    }
  Failuer:^(NSString *error)
    {
        [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
         
       
   }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return finallyArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LightListKindTableViewCell *ListCell = [tableView dequeueReusableCellWithIdentifier:@"LightCell"forIndexPath:indexPath];

    ListCell.LightNameLable.text =finallyArray[indexPath.row][@"ShopName"];
    ListCell.LightIntroduceLable.text =finallyArray[indexPath.row][@"ShopStory"];

    ListCell.dianzanLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"LikedCount"] intValue]];
    ListCell.pinglunLable.text =[NSString stringWithFormat:@"%d",[finallyArray[indexPath.row][@"CommentCount"]intValue]];
    
    NSString *str =[NSString stringWithFormat:@"%@",finallyArray[indexPath.row][@"ShopMainImg"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pictureUrl,str]];
    
    [ListCell.LightHeadImageLable sd_setImageWithURL:url];
    
    return ListCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   LightListTableViewController *ListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LightS"];
    if (_fag1 ==0) {
        
        ListVC.ID =[finallyArray[indexPath.row][@"ShopID"]intValue];
        
    }
    else{
    ListVC.ID=[finallyArray[indexPath.row][@"ID"]intValue];
    }
    [ListVC setHidesBottomBarWhenPushed:YES];
    

    [self.navigationController pushViewController:ListVC animated:YES];
    
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
