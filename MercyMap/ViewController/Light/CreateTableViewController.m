//
//  CreateTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "CreateTableViewController.h"
#import "CreateMapTableViewCell.h"
#import "ZLThumbnailViewController.h"
#import "ZLShowBigImgViewController.h"
#import "CreatePhotoTableViewCell.h"
#import "CreateInfoTableViewCell.h"
#import "ButtonAdd.h"
#import "Single.h"
#import "LoginService.h"
@interface CreateTableViewController ()<sendphotosDelegate,UITextFieldDelegate,ImageSendDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CreateInfoTableViewCell *Createinfocell;
    CreateMapTableViewCell *Createmapcell;
}

@property(nonatomic,strong)NSString *CategoryText;
@property(nonatomic,strong)NSString *ItemsText;
@property(nonatomic,strong)NSString *timeText;
@property(nonatomic,strong)NSString *telephoneText;

@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arraySelectPhotos = [NSMutableArray array];
    photosArray=[[NSMutableArray alloc]initWithCapacity:0];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    
//    UINib *nib = [UINib nibWithNibName:@"CreateMapTableViewCell" bundle:nil];
//    UINib *nib2 = [UINib nibWithNibName:@"CreatePhotoTableViewCell" bundle:nil];
//    UINib *nib3 =[UINib nibWithNibName:@"CreateInfoTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"Mapcell"];
//    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"Phonecell"];
//    [self.tableView registerNib:nib3 forCellReuseIdentifier:@"Infocell"];

    
    self.edge = ^(NSIndexPath *indexPath){
        if (indexPath.section == 0) {
            return UIEdgeInsetsMake(0, kSCREENWIDTH, 0, 0);
        }else{
            return UIEdgeInsetsMake(0, 17, 0, 0);
        }
    };
    
    [self.tableView registerNib:@[@"CreateMapTableViewCell",@"CreatePhotoTableViewCell",@"CreateInfoTableViewCell"]];
    
    [self initNavBtn];
   
}

- (void)initNavBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];
}

-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)navRightBtnClick
{
    Single  *single =[Single Send];
    LoginService *serVice =[[LoginService alloc]init];
    
    NSString *url =[NSString stringWithFormat:@"%@api/Common/FormPictureUpload?token=%@",URLM,single.Token];
    
    ButtonAdd *length = [[ButtonAdd alloc]init];
    if ([length checkInput:_telephoneText]||[length checkInput:Createmapcell.createmapTextfield.text]||[length checkInput:_timeText]||[length checkInput:storyText]||[length checkInput:_telephoneText]||[length checkInput:Createmapcell.Mlocation]) {
        
    }
    else{
    [serVice sendImageurl:url imageArray:photosArray Token:single.Token success:^(NSArray *successBlock)
     {
         if (successBlock.count==0)
         {
             [CommoneTools alertOnView:self.view content:@"上传失败"];
         }
         else
         {
             
             NSMutableArray *imageDataArray =[[NSMutableArray alloc]init];
             [imageDataArray addObjectsFromArray:successBlock];
             
            [serVice CreateLight:_ItemsText ShopCategoryID:_fag ShopMainImg:successBlock[0] ShopAddr:Createmapcell.createmapTextfield.text ShopHours:_timeText ShopStory:storyText ShopImageArray:imageDataArray Token:single.Token ShopMobileNum:_telephoneText ShopGPS:Createmapcell.Mlocation SuccessBlock:^(NSString *success)
              {
                  
                  [CommoneTools alertOnView:self.view content:success];
                  
                  
              } FailuerBlock:^(NSString *error) {
                  
              }];
             
         }
         
     }
                  Failuer:^(NSString *errorBlock)
     {
         
         
     }];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)sendphotos:(NSMutableArray *)ArraySelectphotos sendtag:(int)tag
{
    if (tag==0) {
        
    
    ButtonAdd *btn1 =[[ButtonAdd alloc]init];
    btn1.delegate = self;

    ZLThumbnailViewController *VC = [[ZLThumbnailViewController alloc]initWithNibName:@"ZLThumbnailViewController" bundle:nil];
    
    VC.maxSelectCount = 5;
    
    [_arraySelectPhotos removeAllObjects];
    [_arraySelectPhotos addObjectsFromArray:ArraySelectphotos];
    
    VC.SelectPhotos = _arraySelectPhotos;
    
    [VC setDoneBlock:^(NSArray<ZLSelectPhotoModel *> *ZLelectPhotos) {
        
    [self.arraySelectPhotos removeAllObjects];
    [self.arraySelectPhotos addObjectsFromArray:ZLelectPhotos];
    [self.tableView reloadData];
        
     }];
    
    [btn1 CheckCammer:self andViewVC:VC];
    
    }
    else if(tag ==1)
    {
        NSMutableArray<PHAsset *> *arrSel = [NSMutableArray array];
        for (ZLSelectPhotoModel *model in ArraySelectphotos) {
            
            [arrSel addObject:model.asset];
            
        }
        
        ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
        svc.assets         = arrSel;
        svc.arraySelectPhotos = self.arraySelectPhotos.mutableCopy;
        svc.selectIndex    = 0;
        svc.maxSelectCount = arrSel.count;
        svc.showPopAnimate = NO;
        svc.shouldReverseAssets = NO;
        [svc setOnSelectedPhotos:^(NSArray<ZLSelectPhotoModel *> *selectedPhotos) {
            
            [self.arraySelectPhotos removeAllObjects];
            [self.arraySelectPhotos addObjectsFromArray:selectedPhotos];
            [self.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:svc animated:YES];

        }
    else
    {
        NSMutableArray<PHAsset *> *arrSel = [NSMutableArray array];
        for (ZLSelectPhotoModel *model in ArraySelectphotos) {
            
            [arrSel addObject:model.asset];
            
        }
        
        ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
        svc.assets         = arrSel;
        svc.arraySelectPhotos = self.arraySelectPhotos.mutableCopy;
        svc.selectIndex    = 0;
        svc.fag =2;
        svc.maxSelectCount = arrSel.count;
        svc.showPopAnimate = NO;
        svc.shouldReverseAssets = NO;
        [svc setOnSelectedPhotos:^(NSArray<ZLSelectPhotoModel *> *selectedPhotos) {
            
            [self.arraySelectPhotos removeAllObjects];
            [self.arraySelectPhotos addObjectsFromArray:selectedPhotos];
            [self.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:svc animated:YES];
        

    }
    
}



-(void)sendtextInfo:(NSString *)str
{
    storyText=str;
}


-(void)sendimages:(NSMutableArray *)imageArray
{
    [photosArray removeAllObjects];
    
    [photosArray addObjectsFromArray:imageArray];
}

-(void)sendCammerImage
{
    UIImagePickerController *imagePicker =[[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing =YES;
    imagePicker.modalTransitionStyle =UIModalTransitionStyleCoverVertical;
    imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage  *image =[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage  *resizedImage = [UIImage scaleToSize:image size:CGSizeMake(480,480)];
    ZLSelectPhotoModel *model = [[ZLSelectPhotoModel alloc]init];
    model.image =resizedImage;
    [_arraySelectPhotos addObject:model];
    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.section==0) {
        
        height=220;
    }
    
    else if (indexPath.section==1)
    {
        height=130;
    }
    else
    {
        height=250;
    }
    
    return height;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =nil;
    
    if (indexPath.section ==0)
    {
        CreateMapTableViewCell *mapcell =[tableView dequeueReusableCellWithIdentifier:@"CreateMapTableViewCell" forIndexPath:indexPath];
        
        Createmapcell =mapcell;
        
        cell = mapcell;
        
     }
    else if (indexPath.section ==1)
    {
        CreatePhotoTableViewCell *photocell =[tableView dequeueReusableCellWithIdentifier:@"CreatePhotoTableViewCell"forIndexPath:indexPath];
        
        photocell.delegate = self;
        
        [photocell getcellInfo:_arraySelectPhotos];
        
        cell = photocell;
       
    }
    else
    {
        CreateInfoTableViewCell *infocell =[tableView dequeueReusableCellWithIdentifier:@"CreateInfoTableViewCell"forIndexPath:indexPath];
        
        Createinfocell =[[CreateInfoTableViewCell alloc]init];
        Createinfocell =infocell;
        

        infocell.CategoryTextfield.delegate =self;
        infocell.CreatetimeTextField.delegate=self;
        infocell.TelePhoneTextField.delegate =self;
        infocell.TitemTextField.delegate =self;
        
        [self setinfoCell:infocell];
        
        
        
        cell = infocell ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



-(void)setinfoCell:(CreateInfoTableViewCell *)cell
{
    
    UIButton *textBtn =[[UIButton alloc]init];
    textBtn.frame =cell.CategoryTextfield.frame;
    [textBtn addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:textBtn];
}


-(void)chooseCategory:(CreateInfoTableViewCell *)cell
{
    cell= Createinfocell;
    UIAlertController *alterC =[UIAlertController alertControllerWithTitle:@"类别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction  *zhuaction =[UIAlertAction actionWithTitle:@"主食" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.CategoryTextfield.text =@"主食";
        _fag =2;
        
    }];
    UIAlertAction *xiaochiA =[UIAlertAction actionWithTitle:@"小吃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.CategoryTextfield.text =@"小吃";
        _fag=3;
    }];
    
    UIAlertAction *tianA =[UIAlertAction actionWithTitle:@"甜点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cell.CategoryTextfield.text =@"甜点";
        _fag=1;
    }];
    
    UIAlertAction *qitaA =[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        cell.CategoryTextfield.text =@"其他";
        _fag=4;
    }];
    
    [alterC addAction:zhuaction];
    [alterC addAction:xiaochiA];
    [alterC addAction:tianA];
    [alterC addAction:qitaA];
    
    [self presentViewController:alterC animated:YES completion:nil];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    _CategoryText = Createinfocell.CategoryTextfield.text;
    _telephoneText = Createinfocell.TelePhoneTextField.text;
    _ItemsText =Createinfocell.TitemTextField.text;
    _timeText =Createinfocell.CreatetimeTextField.text;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
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
