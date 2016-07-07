//
//  LightListTableViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/11.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightListTableViewController.h"
#import "AppDelegate.h"
#import "LoginService.h"
#import "LightListKindTableViewCell.h"
#import "LightListKindTableViewCell.h"
#import "LightListInfoTableViewCell.h"
#import "LightListSecondTableViewCell.h"
#import "Single.h"
#import "MJRefresh.h"
#import "StarTableViewController.h"
#import "LogViewController.h"
#import "MapViewSet.h"
#import "DataBaseSet.h"
#import "YYShareView.h"
#import "ZLShowBigImgViewController.h"
#import "UMSocial.h"

@interface LightListTableViewController ()<dianzanDelegate,UITextViewDelegate>
{
    LoginService *SerVice;
    Single *single;
    UITextView *keytextfile;
    UIView *keyBoardView;
    UIButton *sendBtn;
    
    int pageNum,i,sendfag,dianfag,Fag;
    NSMutableArray *finallyArray;
    NSMutableDictionary *dataDic;
}
@property(nonatomic,strong)LightListInfoTableViewCell *listInfoCell;
@property (nonatomic) CLLocationCoordinate2D Mapcoordinate;

@end

@implementation LightListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    self.tableView.showsVerticalScrollIndicator = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    SerVice =[[LoginService alloc]init];
    single = [Single Send];
    finallyArray=[[NSMutableArray alloc]initWithCapacity:0];
    dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    i=0;
    sendfag=0;
    dianfag =0;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setTabbarInfo];

    //刷新数据
    
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:@selector(GetComment) withObject:self afterDelay:0];
            
        });
        
    }];
    
    
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            i=0;
            [finallyArray removeAllObjects];
            [self performSelector:@selector(GetComment) withObject:self afterDelay:0];
            
        });
    }];
    self.tableView.footer.hidden =YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

    
    
    [keyBoardView addSubview:sendBtn];
    [keyBoardView addSubview:keytextfile];
    [self.tabBarController.view addSubview:keyBoardView];

}
-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendDianzanDelegaet:(int)fag
{
    MapViewSet *MapView =[[MapViewSet alloc]init];
    
    if (fag ==2)
    {
        
        NSString *str =dataDic[@"ShopGPS"];
        if ([str isKindOfClass:[NSNull class]]) {
            [CommoneTools alertOnView:self.view content:@"无法获取地理坐标"];
            fag=0;
            
        }
        else
        {
            
        NSArray *array = [str componentsSeparatedByString:@","];
        float latitude = [array[0] floatValue];
        float longitude =[array[1] floatValue];
        _Mapcoordinate=CLLocationCoordinate2DMake(latitude, longitude);
            
        }
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
    {
        switch (fag) {
            case 1:
                [self stardianzan];
                break;
                
            case 2:
                
                [MapView rightBtnClick:_Mapcoordinate view:self fag:2];
                
                break;
            case 3:
                [self shareView];
                
                break;
            case 4:
                
                [keytextfile becomeFirstResponder];
                
                break;
                
                case 5:
                
                [self collectionInfo];
                break;
                
            default:
                break;
        }
    }
    else{
        [self alterController];
    }

}

-(void)getcollectionINfo
{
    
    [SerVice CollectionInfo:single.ID FocusType:1 Token:single.Token PageSize:10 PageIndex:0 SuccesBlock:^(NSArray *modelArray) {
       
        
        if ([modelArray isKindOfClass:[NSNull class]]) {
        }
        
        else{
            
    for (int a=0 ;a<modelArray.count;a++)
        {
       
        if ([modelArray[a][@"ShopID"] intValue]==_ID )
            {
               
                    [_listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
                

            }
        else{
//                Fag =0;
            [_listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"收藏1.png"] forState:UIControlStateNormal];

            }
            
        }}
        
    } FailuerBlock:^(NSString *error) {
            
    }];
    
    
}

-(void)collectionInfo
{
    [self.listInfoCell.shoucangBtn setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    
    [SerVice CollectionUser:_ID UID:single.ID FocusType:1 Token:single.Token SuccessBlock:^(NSString *success) {
        
        [CommoneTools alertOnView:self.view content:success];
        
    } Failuer:^(NSString *error) {
        
    }];
}

-(void)sendBigImage:(NSMutableArray<NSURL *> *)imagesArray imagetag:(int)tag
{
//    NSMutableArray<UIImage *> *arrSel=[NSMutableArray array];
//    for (ZLSelectPhotoModel *model in imagesArray) {
//        [arrSel addObject:model.image];
//    }
    
    ZLShowBigImgViewController *svc = [[ZLShowBigImgViewController alloc] init];
    svc.imageA =imagesArray;
    svc.selectIndex    = tag;
    svc.fag =1;
    svc.maxSelectCount = 5;
    svc.showPopAnimate = NO;
    svc.shouldReverseAssets = NO;
    

    [self.navigationController pushViewController:svc animated:YES];

    
    
}

-(void)stardianzan
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date =[NSDate date];
    NSString * str1 = [formatter stringFromDate:date];
    
    if (dianfag ==1) {
        
        [CommoneTools alertOnView:self.view content:@"你已经点过"];
        
    }
    else{
        
    
    
    [SerVice dianzanLightShopID:_ID UID:single.ID Token:single.Token SuccessBlock:^(NSString *success)
     {
         dianfag=1;
         
         NSString *sql =[NSString stringWithFormat:@"insert into dianzan (time,name) values ('%@',%d);",str1,_ID];
         
         DataBaseSet *database = [[DataBaseSet alloc]init];
         [database getDBInfo:sql gettimeInfo:^(NSString *info) {
             if ([info isEqualToString:@"Success"]) {
                 
                 NSLog(@"goodjob");
                 
             }
             
         }];
         
       [CommoneTools alertOnView:self.view content:success];
       [self SelfLightList];
         
         
       }
    Failuer:^(NSString *error) {
                            
                        }];
        
    }
}


-(void)shareView
{
    
    
    YYShareView * share = [YYShareView creatXib];
    [share setGetTouch:^(int tag)
     {
         [self getTag:tag];
     }];
    [share show];

    
}

-(void)getTag:(int)tag
{
      NSString *imageStr=[NSString stringWithFormat:@"%@%@",pictureUrl,dataDic[@"ShopImg1"]];
      NSString *Imgstr =[imageStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    switch (tag) {
         case 1:
            
//            self shareWithTitle:nil content:dataDic[@"ShopStory"] image:dataDic[@"ShopImg1"] andWebUrl:@"http://baidu.com" viewController:<#(UIViewController *)#> type:<#(NSString *)#>
            
            break;
            
         case 2:
            
            [self shareWithTitle:nil content:dataDic[@"ShopStory"] image:Imgstr andWebUrl:@"http://baidu.com" viewController:self type:UMShareToWechatTimeline ];

            break;
            
         case 3:
               [self shareWithTitle:nil content:dataDic[@"ShopStory"] image:Imgstr andWebUrl:@"http://baidu.com" viewController:self type:UMShareToWechatSession];
            break;
            
        default:
            break;
    }

//    NSLog(@"分享：%d",tag);
}


-(void)shareWithTitle:(NSString *)title content:(NSString *)content image:(id)image andWebUrl:(NSString *)url viewController:(UIViewController *)vc type:(NSString *)type{
    
    id img ,urlResource;
    if ([image isKindOfClass:[NSString class]]) {
        
        UMSocialUrlResource * resource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:image];
        urlResource = resource;
    }else{
        img = image;
    }
    
    NSLog(@"微信");
    if ([type isEqualToString:UMShareToWechatSession]) {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:img location:nil urlResource:urlResource presentedController:vc completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
                
            }
        }];
    }
    else if ([type isEqualToString:UMShareToWechatTimeline]){
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:img location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
                
            }
        }];
    }
    else if ([type isEqualToString:UMShareToSina]){
        
        [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@%@ %@",title,url,content] shareImage:img socialUIDelegate:vc];        //设置分享内容和回调对象
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(vc,[UMSocialControllerService defaultControllerService],YES);
        
    }else if ([type isEqualToString:UMShareToQQ]){
        
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.title = title;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:img location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
                
            }
        }];
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



-(void)SelfLightList
{
   [SerVice GetSelfLightInfo:_ID SuccessBlock:^(NSMutableDictionary *dic)
    {
        
    [dataDic addEntriesFromDictionary:dic];
    [self.tableView reloadData];
        
   }
  FailuerBlock:^(NSString *error)
  {
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeText;
      hud.labelText = @"您的网络不给力!";
      [hud hide: YES afterDelay: 2];


   }];
    
}

-(void)GetComment
{
    
    
    [SerVice GetSelfLightComment:_ID PageIndex:i  pageSize:5 SuccessBlock:^(NSArray *modelArray)
     {
         i++;
         [finallyArray addObjectsFromArray:modelArray];
         [self.tableView reloadData];
         
         [self.tableView.footer endRefreshing];
         [self.tableView.header endRefreshing];
         if (modelArray.count==0)
         {
             [self.tableView.footer endRefreshingWithNoMoreData];
         }
    }
     
    FailuerBlock:^(NSString *error)
     
     {
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.mode = MBProgressHUDModeText;
         hud.labelText = @"您的网络不给力!";
         [hud hide: YES afterDelay: 2];

     }];
    
}


-(void)setTabbarInfo
{
    keyBoardView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width,44)];
    
    keyBoardView.backgroundColor =[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    keytextfile =[[UITextView alloc]initWithFrame:CGRectMake(5,6, self.view.frame.size.width-60, 30)];
    sendBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 6,45, 30)];
    
    sendBtn.backgroundColor=[UIColor whiteColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    sendBtn.titleLabel.font =[UIFont fontWithName:@"Arial" size:14.0];
    sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sendBtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    
    keytextfile.backgroundColor=[UIColor whiteColor]; //背景色
    keytextfile.scrollEnabled = NO;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    keytextfile.editable = YES;        //是否允许编辑内容，默认为“YES”
    keytextfile.delegate = self;       //设置代理方法的实现类
    keytextfile.font=[UIFont fontWithName:@"Arial" size:14.0]; //设置字体名字和字体大小;
    keytextfile.returnKeyType = UIReturnKeyDefault;//return键的类型
    keytextfile.keyboardType = UIKeyboardTypeDefault;//键盘类型
    keytextfile.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    keytextfile.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    keytextfile.textColor = [UIColor blackColor];
}



-(void)textViewDidChange:(UITextView *)textView
{
    
    CGSize size = [keytextfile sizeThatFits:CGSizeMake(CGRectGetWidth(keytextfile.frame),MAXFLOAT)];
    CGRect frame =keytextfile.frame;
    frame.size.height =size.height;
    keytextfile.frame =frame;
    
    keyBoardView.frame=CGRectMake(0,self.view.frame.size.height-44-size.height, self.view.frame.size.width,size.height+44);
    
    sendBtn.frame = CGRectMake(self.view.frame.size.width-50, 6+(size.height-30)/2, 45, 30);
    
    if (![keytextfile.text isEqualToString:@""])
    {
        sendBtn.backgroundColor =[UIColor colorWithRed:126/255.0 green:211/255.0 blue:250/255.0 alpha:1.0];
        sendfag =1;
        
    }
    else
    {
        sendfag =0;
        sendBtn.backgroundColor=[UIColor whiteColor];
        keyBoardView.frame =CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width,44);
        
        sendBtn.frame =CGRectMake(self.view.frame.size.width-50, 6,45, 30);
        
    }
    
}


-(void)send:(NSString *)str
{
    if (sendfag==0)
    {
        [CommoneTools alertOnView:self.tableView content:@"评论为空"];
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]){
        [SerVice sendCommentShopID:_ID UID:single.ID Token:single.Token CommentInfo:keytextfile.text  SuccessBlock:^(NSString *success)
         {
             [keytextfile resignFirstResponder];
             sendBtn.backgroundColor=[UIColor whiteColor];
             [CommoneTools alertOnView:self.view content:success];
             keytextfile.text =NULL;
             keyBoardView.frame =CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width,44);
             keytextfile.frame =CGRectMake(5,6, self.view.frame.size.width-60, 30);
             sendBtn.frame =CGRectMake(self.view.frame.size.width-50, 6,45, 30);
             [self GetComment];
             [self.tableView reloadData];

             
         } Failuer:^(NSString *error) {
             
         }];
        }
        else
        {
            [self alterController];
        }
    }
    
    
}


-(void)getDB:(NSString *)sql
{
    DataBaseSet *database = [[DataBaseSet alloc]init];
    
    [database getDBInfo:sql getInfo:^(NSString *info)
    {
        
        if ([info isEqualToString:@"failuer"]||[info isEqualToString:@"DSuccess"])
        {
        }
        else
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            NSDate *Date= [dateFormatter dateFromString:info];
            
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:Date toDate:[NSDate date] options:0];
//        NSLog(@"%ld",(long)dCom.day);
            
        if (dCom.day>0)
           {
            
            NSString *sql =[NSString stringWithFormat:@"delete from dianzan where name = %d",_ID];
               
           [database getDBInfo:sql gettimeInfo:^(NSString *info) {
               if ([info isEqualToString:@"Success"])
               {
                   dianfag =0;
               }
               
                }];
            }
            else
            {
                dianfag =1;
            }
        }
        
    }];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [keyBoardView removeFromSuperview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
   NSString *sql =[NSString stringWithFormat:@"select * from dianzan  where name = %d",_ID];
    
    [self SelfLightList];
    [self GetComment];
    [self getDB:sql];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue]) {
        [self getcollectionINfo];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
     return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger rowNumber =0;
    if (section==0)
    {
        rowNumber = 1;
    }
   else
   {
       rowNumber =finallyArray.count;
   }
    return rowNumber;;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat contentHight=0.0f;
    CGFloat imageHight=0.0f;
    CGFloat otherHight=0.0f;
    NSInteger Cellheight =0;
//  CGSize size1= [[finallyArray[indexPath.row][@"CommentInfo"]];
    
    NSString *str =dataDic[@"ShopStory"];
    CGSize size = [str calculateSize:CGSizeMake(self.view.frame.size.width-10, FLT_MAX) font:[UIFont systemFontOfSize:14]];
    
    contentHight = size.height;
    
    CGFloat width = (self.view.frame.size.width-10- 30) / 5.0;
    imageHight = width;
    
    otherHight =150+100+20+50+30+30;
    
    if(indexPath.section==0)
    {
        Cellheight =contentHight+imageHight+otherHight;
    }
   
    if (indexPath.section==1)
    {
        if (![finallyArray[indexPath.row][@"CommentInfo"] isKindOfClass:[NSNull class]])
        {
            NSString *str =finallyArray[indexPath.row][@"CommentInfo"];
            
            CGSize size1 = [str calculateSize:CGSizeMake(self.view.frame.size.width-10, FLT_MAX) font:[UIFont systemFontOfSize:14]];
            
            Cellheight = size1.height+50;
        }
     
    }
    return Cellheight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     UITableViewCell *cell =nil;
     if(indexPath.section==0)
   {
      self.listInfoCell=[tableView dequeueReusableCellWithIdentifier:@"ListInfo" forIndexPath:indexPath];
         
        [_listInfoCell setCellInfo:dataDic fag:dianfag Collectionfag:Fag];
       
       _listInfoCell.Ddelegaet =self;
       
        cell = self.listInfoCell;
     }
     else
     {
         LightListSecondTableViewCell *secondCell =[tableView dequeueReusableCellWithIdentifier:@"SecondLight" forIndexPath:indexPath];
         
         self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
         if (![finallyArray[indexPath.row][@"CommentInfo"] isKindOfClass:[NSNull class]])
         {
             secondCell.StarcommentLable.text =finallyArray[indexPath.row][@"CommentInfo"];
             
             secondCell.StarNameLable.text = finallyArray[indexPath.row][@"NickName"];
             
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
             
             NSDate *Date= [dateFormatter dateFromString:finallyArray[indexPath.row][@"CommentTIme"]];
             
             NSCalendar *calendar = [NSCalendar currentCalendar];
             NSDateComponents *dCom = [calendar components:NSCalendarUnitDay fromDate:Date toDate:[NSDate date] options:0];
             
             if (dCom.day ==0) {
                 secondCell.timeLable.text=@"今天";
             }
             else if (dCom.day==1)
             {
                 secondCell.timeLable.text =@"昨天";
             }
             else{
                 
                 NSArray *array = [finallyArray[indexPath.row][@"CommentTIme"] componentsSeparatedByString:@" "];
                 
                 secondCell.timeLable.text=[NSString stringWithFormat:@"%@",array[0]];
             }
     }
         
         cell =secondCell;
    }
     return cell;
}

@end
