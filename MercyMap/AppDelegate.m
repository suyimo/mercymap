//
//  AppDelegate.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/7.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "BaseHttpRequest.h"
#import "Single.h"
#import "LoginService.h"
#import"MapViewSet.h"
#import "UMSocial.h"
#import "LogViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface AppDelegate ()<AMapLocationManagerDelegate>
{
    BaseHttpRequest *firstLogin;
    LoginService *loginService;
    MapViewSet *mapSet;
    
   
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[IQKeyboardManager sharedManager ]setShouldResignOnTouchOutside:YES];
    [IQKeyboardManager sharedManager].enable =YES;
    
     mapSet =[[MapViewSet alloc]init];
    [mapSet setcity];
    
    [SMSSDK registerApp:appkey withSecret:appsecret];
    
    [self setLogin];
    [self setUmeng];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UMSocialSnsService  applicationDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return  [UMSocialSnsService handleOpenURL:url];
}



-(void)setLogin

{
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"UserLogin"];
//    [defaults removeObjectForKey:@"ID"];
//    [defaults removeObjectForKey:@"newUser"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"newUser"]boolValue])
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
        {
            Single *sing = [[Single alloc]init];
            sing = [Single Send];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            
            sing.MobileNum =[defaults objectForKey:@"MobileNum"];
            sing.Password =[defaults objectForKey:@"Password"];
            NSInteger newID =[[NSUserDefaults standardUserDefaults]integerForKey:@"ID"];
            sing.ID =[[NSString stringWithFormat:@"%ld",newID]intValue];
            sing.Token = [defaults objectForKey:@"Token"];
            sing.nickname = [defaults objectForKey:@"NickName"];
            
            LogViewController *logVC =[[LogViewController alloc]init];
            [logVC loginUser:2];
            NSLog(@"我的ID1%d",sing.ID);

            
        }
        else
        {
            Single *sing = [[Single alloc]init];
            sing = [Single Send];
            NSInteger newID =[[NSUserDefaults standardUserDefaults]integerForKey:@"ID"];
            sing.ID =[[NSString stringWithFormat:@"%ld",newID]intValue];
            
            NSLog(@"我的ID2%d",sing.ID);
        }
        
        
    }
    else
    {
        loginService =[[LoginService alloc]init];
        [loginService firstLogin];
        
    }
}

-(void)setUmeng
{
    //第三方登录与分享
    [UMSocialData setAppKey:umengkey];
//    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //设置微信AppId，设置分享url
   [UMSocialWechatHandler setWXAppId:@"wx7a811780f82a006e" appSecret:@"c3b5d877d8299119d27fc864ed1f9102" url:@"http://www.umeng.com/social"];
    
    
    //打开新浪微博的SSO开关
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //设置支持没有客户端下支持SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */


 @end
