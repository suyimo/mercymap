//
//  StarInfornationTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/19.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarInfornationTableViewController.h"
#import "StarUserFTableViewCell.h"
#import "LoginService.h"
#import "Single.h"
#import "StarFirstViewController.h"
#import "LogViewController.h"
#import "UIImage+Addition.h"
#import "CityTableViewCell.h"
#import "CityTableViewController.h"
@interface StarInfornationTableViewController ()<ImageDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    LoginService *Service;
    Single *single;
    NSMutableDictionary *dic;
    
}
@end

@implementation StarInfornationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    Service = [[LoginService alloc]init];
    single =[Single Send];
    self.title =@"个人设置";
    
    dic =[[NSMutableDictionary alloc]initWithCapacity:0];
    [self getInforNation];
    
    
    UINib *nib = [UINib nibWithNibName:@"StarUserFTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"StarUserID"];
    
    UINib *nib2 =[UINib nibWithNibName:@"CityTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"CityID"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)HeadImagePicture
{
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"头像选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    BOOL isCamera =[UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing =YES;
    imagePicker.modalTransitionStyle =UIModalTransitionStyleCoverVertical;

    
    if (isCamera)
    {
     UIAlertAction *CameraAction =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
            
       [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alterController addAction:CameraAction];
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [self presentViewController:alterController animated:YES completion:nil];
    }
    else
    {
        UIAlertAction *PhotoAction =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         
                                         imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
                                         [self presentViewController:imagePicker animated:YES completion:nil];
                                         
                                     }];
        
        UIAlertAction *canceAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alterController addAction:PhotoAction];
        [alterController addAction:canceAction];
        [self presentViewController:alterController animated:YES completion:nil];
    }
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage  *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage  *resizedImage = [UIImage scaleToSize:image size:CGSizeMake(480,480)];
    NSString *fileName =[NSString stringWithFormat:@"%d_HeadImage.jpg",single.ID];
    
    NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?token=%@",URLM,single.Token];
    
    [Service sendImage:url Sizeimage:resizedImage iamgeName:fileName Token:single.Token success:^(NSArray *successBlock)
     {
         NSString *str =successBlock[0];
         
         NSLog(@"image:%@",str);
         
         [Service fixUserMessage:single.ID Token:single.Token Parameters:str Code:@"HeadImg" successBlock:^(NSDictionary *model)
          {
              
              [picker dismissViewControllerAnimated:YES completion:nil];
              
          } Failuer:^(NSString *error) {
              
          }];
    } error:^(NSString *errorBlock) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
 }


-(void)fixheadIfon:(NSString *)str
{
    
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)getInforNation
{
    
    [Service getUser:single.ID Token:single.Token successBlock:^(NSDictionary *model) {
        
            [dic removeAllObjects];
            [dic setDictionary:model];
            
            [self.tableView reloadData];
            
        } Failuer:^(NSString *error) {
            NSLog(@"Wrong");
            
        }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
   return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    
    if (section ==0) {
        return 3;
    };
    return 2;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 66;
        }
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
   
   if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            StarUserFTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:@"StarUserID" forIndexPath:indexPath];
           
            
            FCell.delegate =self;
            [FCell initWithUserFirstCell:@"" cellName:@"头像" textName:dic[@"HeadImg"] indexpath:1];
            
            cell =FCell;
        }
        if (indexPath.row ==1)
        {    StarUserFTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:@"StarUserID" forIndexPath:indexPath];

            
            [FCell initWithUserFirstCell:nil cellName:@"昵称" textName:dic[@"NickName"]  indexpath:0];
            cell =FCell;

            
        }
        if (indexPath.row==2)
        {
            CityTableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"CityID"forIndexPath:indexPath];

            
            if ([dic[@"Province"]isKindOfClass:[NSNull class]])
            {
                cityCell.cityNameLable.text=@"我的地址";
                cityCell.citiesNameLable.hidden =YES;
                
            }
            else
            {
                cityCell.citiesNameLable.hidden =NO;
                cityCell.cityNameLable.text=[NSString stringWithFormat:@"%@",@"我的地址"];
                cityCell.citiesNameLable.text =[NSString stringWithFormat:@"%@ %@",dic[@"Province"],dic[@"City"]];
            }
            cell=cityCell;
        }

    }
    
    
    if (indexPath.section ==1)
    {
        StarUserFTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:@"StarUserID" forIndexPath:indexPath];

        if (indexPath.row ==0)
        {
            
            [FCell initWithUserFirstCell:nil cellName:@"性别" textName:dic[@"Sex"] indexpath:2];
        }
        if (indexPath.row==1)
        {
            
            [FCell initWithUserFirstCell:nil cellName:@"个性签名" textName:dic[@"Idiograph"] indexpath:0];
        }
        cell =FCell;
    }
    
    return cell;
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.tableView reloadData];
//}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row ==0) {
            
        }
        if (indexPath.row ==1) {
            
            StarFirstViewController *FirstVC = [[StarFirstViewController alloc]initWithNibName:@"StarFirstViewController" bundle:nil];
            FirstVC.tag=0;
            [self.navigationController pushViewController:FirstVC animated:YES];
        
        }
        
        if (indexPath.row ==2) {
            
            CityTableViewController *CityVC = [[CityTableViewController alloc]initWithNibName:@"CityTableViewController" bundle:nil];
            [self.navigationController pushViewController:CityVC animated:YES];
            
            CityVC.ReturnBlock =^(NSString *str)
            {
                [self getInforNation];
                [self.tableView reloadData];
                
                
            };
        }
    }
    else{
        if (indexPath.row ==0) {
            
            [self AlterViewController];
            
        }
        if (indexPath.row==1) {
            
            StarFirstViewController *FirstVC = [[StarFirstViewController alloc]initWithNibName:@"StarFirstViewController" bundle:nil];
            FirstVC.tag =1;
            
            [self.navigationController pushViewController:FirstVC animated:YES];
             
        }
    }
}



-(void)AlterViewController
{
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"性别选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *boyAc =[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
       [Service fixUserMessage:single.ID Token:single.Token Parameters:@"Boy" Code:@"Sex" successBlock:^(NSDictionary *model) {
           
           [self getInforNation];
           
           [self.tableView reloadData];
           
       }
      Failuer:^(NSString *error) {
           
       }];

        
    }];
    
   UIAlertAction  *girlAc = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
       [Service fixUserMessage:single.ID Token:single.Token Parameters:@"Girl" Code:@"Sex" successBlock:^(NSDictionary *model)
        {
            [self getInforNation];
           
           [self.tableView reloadData];
           
           
       } Failuer:^(NSString *error) {
           
       }];

       
       }];
    
    [alterController addAction:boyAc];
    [alterController addAction:girlAc];
    [self presentViewController:alterController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getInforNation];
    [self.tableView reloadData];
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
