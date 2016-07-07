//
//  LogViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LogViewController.h"
#import "AppDelegate.h"
#import "ButtonAdd.h"
#import "RegViewController.h"
#import "LoginService.h"
#import "PasswordViewController.h"
#import "Single.h"
#import "NSUserDefautSet.h"

#import "UMSocial.h"


@interface LogViewController ()
{
    LoginService *loginServic;
    Single *sing;
    NSUserDefautSet *defaultSet;
    AppDelegate *app;
}

@end

@implementation LogViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"登录";
    
    self.userImageView.layer.cornerRadius =self.userImageView.frame.size.height/2;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.masksToBounds =YES;
    
    self.regBtn1.layer.masksToBounds =YES;
    self.regBtn1.layer.cornerRadius =YES;
    self.regBtn1.layer.cornerRadius =10;
    defaultSet = [[NSUserDefautSet alloc]init];
    
    sing = [Single Send];
    [self juge];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

}


-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)backView:(NSString *)telPhoneNum andPassWord:(NSString *)password
//{
//    NSLog(@"%@",telPhoneNum);
//    NSLog(@"%@",password);
//    
//    self.telePhoneNumber.text = telPhoneNum;
//    self.passwordText.text = password;
//    
//}

-(void)juge
{
  if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"UserLogin"]boolValue])
    {
        if(sing.nickname==nil){
        self.telePhoneNumber.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"MobileNum"];
        
        self.passwordText.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"Password"];
        }
        else
        {
            
            
        }
    }
  else
  {
      
      [_telePhoneNumber becomeFirstResponder];
      [_telePhoneNumber setKeyboardType:UIKeyboardTypeNumberPad];

      
      if (_fagB==1)
      {
          app =[[AppDelegate alloc]init];
          [app setLogin];
          
      }
  }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
 
 
- (IBAction)logClick:(id)sender {
   
    ButtonAdd *length = [[ButtonAdd alloc]init];
   
if ([length checkInput:self.telePhoneNumber.text]||[length checkInput:self.passwordText.text]) {
         [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }
    else
    {
        
        [self loginUser:1];
     
    }
    
    
    
}

-(void)loginUser:(int)fag
{
    
    
   loginServic = [[LoginService alloc]init];
   sing = [[Single alloc]init];
   sing = [Single Send];
    if (fag==1)
    {

        sing.MobileNum = self.telePhoneNumber.text;
        sing.Password = self.passwordText.text;
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"NickName"]!=nil) {
        
        [self secondLogin:2];
    }
    else{
    [loginServic Login:sing.ID UserName:sing.MobileNum  andPassWord:sing.Password successBlock:^( NSMutableDictionary *dic) {
       
        if ([dic[@"Flag"]isEqualToString:@"S"])
        {
            
            
            sing = [[Single alloc]init];
            sing = [Single Send];
            
            sing.MobileNum = self.telePhoneNumber.text;
            sing.Password =  self.passwordText.text;
            sing.ID =[dic[@"ID"]intValue];
            sing.Token =dic[@"Token"];
            
            //         NSString *MobileNum = sing.MobileNum;
            //         NSString *Password = sing.
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"%@",sing.Token);
            
            //登录数据的基本存储
            [defaultSet loginDataStorage:sing.ID MobileNum:sing.MobileNum Password:sing.Password Token:sing.Token];
        }
        else
        {
            [CommoneTools alertOnView:self.view content:dic[@"Reason"]];
        }
    } FailuerBlock:^(NSString *error) {
        [CommoneTools alertOnView: self.view content:@"登录失败"];
    }];
    }
}



- (IBAction)forgetPasswordBtn:(id)sender {
    
    
}

- (IBAction)regBtn:(id)sender {
    
    
    RegViewController *RegVC = [[RegViewController alloc]initWithNibName:@"RegViewController" bundle:nil];
    
    [self.navigationController pushViewController:RegVC animated:YES];
    
    
}

- (IBAction)QQLog:(id)sender {
    
//    int fag=1;
//    
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//    
//    [self sendUMeng:snsPlatform fag:fag];
    
    RegViewController *RegVC = [[RegViewController alloc]initWithNibName:@"RegViewController" bundle:nil];
    
    [self.navigationController pushViewController:RegVC animated:YES];
    

    
}

- (IBAction)weiboLog:(id)sender {
    
//    int fag =2;
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    [self sendUMeng:snsPlatform fag:2];
    
}

- (IBAction)weixinlog:(id)sender
{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    [self sendUMeng:snsPlatform fag:3];
    
    
    
}

-(void)sendUMeng:(UMSocialSnsPlatform *)snsPlatform fag:(int)fag
{
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount;
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"UserLogin"];
            [defaults removeObjectForKey:@"ID"];
            [defaults removeObjectForKey:@"newUser"];

            
            app =[[AppDelegate alloc]init];
            [app setLogin];
            
            switch (fag) {
                case 1:
                    snsAccount =[[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToQQ];
                    
                    break;
                    
                case 2:
                    snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToSina];
                    
                    break;
                    
                case 3:
                    
                    snsAccount =[[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
                    
                    break;
                    
                default:
                    break;
            }
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            loginServic =[[LoginService alloc]init];
            sing =[Single Send];
            
            sing.MobileNum = snsAccount.usid;
            sing.Password =snsAccount.platformName;
            sing.nickname = snsAccount.userName;
            sing.imageUrl =snsAccount.iconURL;

            
            [loginServic Regist:sing.ID MobileNum:snsAccount.usid andPassWord:snsAccount.platformName successBlock:^(NSString *success) {
                
                [self secondLogin:1];
                
        
            } FailuerBlock:^(NSString *error) {
                
                [CommoneTools alertOnView:self.view content:@"登录失败"];
                
            }];

            
        }
    });
}

-(void)secondLogin:(int)fag
{
    loginServic =[[LoginService alloc]init];
    
    [loginServic Login:sing.ID UserName:sing.MobileNum  andPassWord:sing.Password successBlock:^( NSMutableDictionary *dic) {
        
        if ([dic[@"Flag"]isEqualToString:@"S"])
        {
            sing = [Single Send];
            sing.Token =dic[@"Token"];
            
            NSLog(@"%@",sing.Token);
            NSLog(@"%@",sing.nickname);
            
    
            //登录数据的基本存储
            [defaultSet loginDataStorage:sing.ID MobileNum:sing.MobileNum Password:sing.Password Token:sing.Token];
            if (fag==1) {
                
                [self fixUser];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:sing.nickname forKey:@"NickName"];

                
            }

        }
        else
        {
            [CommoneTools alertOnView:self.view content:dic[@"Reason"]];
        }
    } FailuerBlock:^(NSString *error) {
        
        [CommoneTools alertOnView: self.view content:@"登录失败"];
        
    }];
    

}


-(void)fixUser
{
    loginServic =[[LoginService alloc]init];
    
   [loginServic fixUserMessage:sing.ID Token:sing.Token Parameters:nil Code:@"ThirdLogin" successBlock:^(NSDictionary *model) {
       
       [self.navigationController popToRootViewControllerAnimated:YES];

       
       
    } Failuer:^(NSString *error) {
        
    }];
    
}
@end
