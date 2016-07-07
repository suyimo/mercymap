//
//  MercyInfoTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/7/4.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "MercyInfoTableViewController.h"
#import "MercyInfoTableViewCell.h"
#import "BaseHttpRequest.h"
@interface MercyInfoTableViewController ()
{
    NSMutableArray *dataArray;
}

@end

@implementation MercyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray =[[NSMutableArray alloc]initWithCapacity:0];
    
     UINib *nib = [UINib nibWithNibName:@"MercyInfoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Minfocell"];
    
    
    [self settitle];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
    
    
}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)settitle
{
    if (_Mfag ==1) {
         self.title =@"关于我们";
    }
    else if(_Mfag ==2)
    {
        self.title =@"使用说明";
    }
    else{
        self.title =@"最新版本";
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getMercyInfo:(int)fag{
    
    
    BaseHttpRequest *serVice  =[[BaseHttpRequest alloc]init];
    NSString *url =[NSString stringWithFormat:@"%@api/Common/MercymapConfig",URLM];
    
    [serVice sendRequestHttp:url parameters:nil Success:^(NSDictionary *dicData) {
        if (fag==1)
        {
            [dataArray addObject: dicData[@"MercyMapConfig"][@"AboutUS"]];
        }
        else if (fag==2)
        {
            [dataArray addObject:dicData[@"MercyMapConfig"][@"DirectionsForuse"]];
            
        }
        else if (fag==3)
        {
            [dataArray addObject:[NSString stringWithFormat:@"当前版本： %@",dicData[@"MercyMapConfig"][@"VersionNumber"]]];
        }
        [self.tableView reloadData];

    } Failuer:^(NSString *errorInfo) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return dataArray.count;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getMercyInfo:self.Mfag];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentHight=0.0f;
    
    if (![dataArray[indexPath.row] isKindOfClass:[NSNull class]])
    {
     NSString *contentStr = [NSString stringWithFormat:@"%@",dataArray[indexPath.row]];
     CGSize size1 = [contentStr calculateSize:CGSizeMake(self.view.frame.size.width-10, FLT_MAX) font:[UIFont systemFontOfSize:16]];
    contentHight =size1.height+35;
    }
   return contentHight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MercyInfoTableViewCell *infocell =[tableView dequeueReusableCellWithIdentifier:@"Minfocell"forIndexPath:indexPath];
    
     [infocell setcontentLable:dataArray];
     return infocell;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
