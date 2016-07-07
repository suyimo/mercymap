//
//  RegViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "RegViewController.h"
#import "LoginService.h"
#import "VerificationViewController.h"
#import "ButtonAdd.h"
#import "AppDelegate.h"
@interface RegViewController ()<UITextFieldDelegate>
{
    LoginService *loginService;
    ButtonAdd *checklength;
}

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    checklength = [[ButtonAdd alloc]init];
    
    self.title =@"填写手机号";
    
    self.telPhoneTextfile.delegate =self;
    
    self.NextBtn.layer.masksToBounds =YES;
    self.NextBtn.layer.cornerRadius=10;
    
    self.NextBtn.backgroundColor=[UIColor colorWithRed:246/250.0 green:246/250.0 blue:246/250.0 alpha:1.0];
    
    loginService = [[LoginService alloc]init];
    [_telPhoneTextfile becomeFirstResponder];
    _telPhoneTextfile.keyboardType =UIKeyboardTypeNumberPad;
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
 

- (IBAction)NextClick:(id)sender {
    
    if (![checklength checkInput:self.telPhoneTextfile.text] )
    {
        if ([self.telPhoneTextfile.text length]==11) {
            
            VerificationViewController *VerVC = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];
            
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telPhoneTextfile.text zone: @"86" customIdentifier: nil result:^(NSError *error)
            {
                if (!error) {
                    VerVC.tel = self.telPhoneTextfile.text;
                    
                    [self.navigationController pushViewController:VerVC animated:YES];
                }
                
                else{
                    
                    [CommoneTools alertOnView:self.view content:@"发送失败"];
                    
                   }
            }];
            
            
           
            
        }
    }

    
    }


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   
    textField =self.telPhoneTextfile;
    if (![checklength checkInput:textField.text] )
    {
        if ([textField.text length]==11) {
            self.NextBtn.backgroundColor =[UIColor colorWithRed:61/255.0 green:185/255.0 blue:253/255.0 alpha:1.0];
            self.NextBtn.layer.masksToBounds =YES;
            self.NextBtn.layer.cornerRadius=10;
            
        }
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}
@end
