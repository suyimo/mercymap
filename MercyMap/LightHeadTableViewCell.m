//
//  LightHeadTableViewCell.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LightHeadTableViewCell.h"
#import "AppDelegate.h"
#import "LightListTableViewController.h"
#import "LightListTableViewCell.h"
#import "LoginService.h"
@implementation LightHeadTableViewCell
{
    int page;
    NSTimer *timer;
    LoginService *Service;
    NSMutableArray *dataArray;
    int headID;
    
    
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    
    Service =[[LoginService alloc]init];
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self getHeadImageInfo];

   }

-(void)getHeadImageInfo
{
    NSString *url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/GetShopStoryList"];
    
    [Service sendRequestHttp:url parameters:nil Success:^(NSDictionary *dicData) {
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            
             dataArray = dicData[@"ListShopList"];
             [self addImageView];
        }
        else
        {
            
        }
        
        
    } Failuer:^(NSString *errorInfo) {
        
    }];
    
}

-(void)addImageView
{
    
    self.pageScrollView.contentSize =CGSizeMake(MainScreen.size.width*dataArray.count,0);
    self.pageScrollView.maximumZoomScale =4;
    self.pageScrollView.minimumZoomScale=1;
    self.pageScrollView.bounces =NO;
    self.pageScrollView.pagingEnabled =YES;
    
    CGFloat height = self.pageScrollView.frame.size.height;
    self.pagePageControl.currentPageIndicatorTintColor =[UIColor redColor];
    self.pagePageControl.numberOfPages = dataArray.count;
    self.pagePageControl.frame=CGRectMake(MainScreen.size.width/2,height-10 , 39, 37);
    self.pageScrollView.delegate=self;

    
    float windth =MainScreen.size.width;
    
    for (int i=0; i<dataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*windth,0, windth, 200)];
        
        //  imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSURL *url= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",pictureUrl,dataArray[i][@"ShopHeadImg"]]];
        [imageView sd_setImageWithURL:url];
        
        self.introduceLable.text = dataArray[i][@"ShopStory"];
        
//        imageView.tag =100+i;
        [self.pageScrollView addSubview:imageView];
        [imageView addSubview:self.pagePageControl];
        
        UITapGestureRecognizer *singleRecongnizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
        
        singleRecongnizer.numberOfTapsRequired =1;
        singleRecongnizer.numberOfTouchesRequired =1;
        imageView.userInteractionEnabled =YES;
        
        [imageView addGestureRecognizer:singleRecongnizer];
    }
    
    page=0;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
}


-(void)singleTap
{
    NSInteger b= self.pagePageControl.currentPage;
    headID =[dataArray[b][@"ID"]intValue];
    [self.delegate singleTaps:headID];
    
}


-(void)changePage
{
    if (page == 3) {
        
        page = 0;
    }
    
    [self.pageScrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width*page, 0) animated:YES];
    page++;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   int jude=(int)scrollView.contentOffset.x/(int)MainScreen.size.width;
    if (jude<dataArray.count)
    {
        self.pagePageControl.currentPage =jude;
        self.introduceLable.text =dataArray[jude][@"ShopStory"];

    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
 
}

@end
