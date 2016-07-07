//
//  CityTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/28.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CityTableViewController.h"
#import "CityTableViewCell.h"
#import "StarInfornationTableViewController.h"
#import "LoginService.h"
#import "Single.h"
@interface CityTableViewController ()
{
    NSDictionary *dataDic;
    NSArray *dataArray;
    LoginService *service;
    Single *single;
    NSString *Citystr;
    
    int _openSection;//当前展开的区
}
@end

@implementation CityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"cityData" ofType:@"plist"];
    self.tableView.showsVerticalScrollIndicator = NO;

    dataDic =[[NSDictionary alloc]initWithContentsOfFile:path];
    dataArray =[dataDic allKeys];
    
    UINib *nib = [UINib nibWithNibName:@"CityTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CityID"];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

    service =[[LoginService alloc]init];
    single  =[Single Send];
    
}
-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataDic.count+1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    
    return 20;
}

- (NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *string ;
    NSLog(@"%ld",(long)section);
    if (section==0)
    {
        string =@"";
    }
    else
    {
        
        NSString *str = [dataArray objectAtIndex:section-1];
        string =str;
    }
    
    return string;
}

//自定义区头(返回区头高度)
//- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //创建一个UIView
//    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 0, 320, 20)];
//    view.backgroundColor = [UIColor grayColor];
//
//
//    //创建一个label
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    label.text = [dataArray objectAtIndex:section];
//    label.font = [UIFont boldSystemFontOfSize:18];
//    label.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:label];
//
//
//
//    //创建一个button
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0, 0, 40, 20);
////    button.backgroundColor = [UIColor grayColor];
//    [button setBackgroundImage:[UIImage imageNamed:@"jiantou.png"] forState:UIControlStateNormal];
//    button.tag = section;
//    [button addTarget:self action:@selector(buttonClcik:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:button];
//    if (section == _openSection) {
//        button.transform = CGAffineTransformMakeRotation(M_PI_2);
//    }
//
//    return view;
//}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger CC;
    //    NSInteger a= dataDic.count;
    //   for (int i=0; i<a; i++) {
    //   if (section==i)
    //      {
    //          NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",dataArray[i]]];
    //
    ////        if(section == _openSection)
    ////        {
    ////            return dateArray.count;
    ////        }
    ////        else
    ////        {
    ////            return 0;
    ////        }
    ////
    //            return dateArray.count;
    //     }
    //  }
    if (section==0)
    {
        CC=1;
    }
    else
    {
        
        NSString *str = [dataArray objectAtIndex:section-1];
        NSLog(@"%@",str);
        //        NSArray *dateArray = [dataDic objectForKey:[NSString stringWithFormat:@"%@",dateArray[section-1]]];
        NSArray *dateArray =[dataDic objectForKey:str];
        
        
        //        return dateArray.count;
        CC =dateArray.count;
    }
    
    return CC;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    
    CityTableViewCell *cityVC =[tableView dequeueReusableCellWithIdentifier:@"CityID" forIndexPath:indexPath];
    
    //    cell.textLabel.text = [[_detailArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section==0)
    {
        cityVC.cityNameLable.text=@"当前位置";
        cityVC.citiesNameLable.hidden =YES;
        cell=cityVC;
    }
    else
    {
        
        
        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",dataArray[indexPath.section-1]]];
        NSString *str = [dateArray objectAtIndex:indexPath.row];
        
        cityVC.citiesNameLable.hidden =YES;
        cityVC.cityNameLable.text=str;
        cell= cityVC;
        
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_fag==1)
    {
       [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CityName"];
        NSString *str1 =dataArray[indexPath.section-1];

        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",str1]];
        
        NSString *str =[dateArray objectAtIndex:indexPath.row];

        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:str forKey:@"CityName"];
        Citystr = str;
        
        self.ReturnBlock(Citystr);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
   else if (_fag==2)
    {
       
        NSString *str1 =dataArray[indexPath.section-1];
        
        NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",str1]];
        
        NSString *str =[dateArray objectAtIndex:indexPath.row];
        Citystr = str;
        
        self.ReturnBlock(Citystr);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
   
    else
    {
      
    
    NSArray *dateArray=[dataDic objectForKey:[NSString stringWithFormat:@"%@",dataArray[indexPath.section-1]]];
    
    NSString *str1 =dataArray[indexPath.section-1];
    NSString *str =[dateArray objectAtIndex:indexPath.row];
    NSString *cityStr =[NSString stringWithFormat:@"%@ %@",str1,str];
   
    
    [service fixUserCity:single.ID Token:single.Token Province:str1 City:str successBlock:^(NSDictionary *model) {
        
//        StarInfornationTableViewController *InfoVC =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//        [self.navigationController popToViewController:InfoVC animated:YES];
        if ([model[@"Flag"]isEqualToString:@"S"])
        {
            self.ReturnBlock(cityStr);
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }

        
        
    } Failuer:^(NSString *error) {
        
    }];
    
  }
    
}





//- (void)buttonClcik:(UIButton* )button
//{
//
//    _openSection = button.tag;
//    [self.tableView reloadData];
//}

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
