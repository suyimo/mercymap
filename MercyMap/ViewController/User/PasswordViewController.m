//
//  PasswordViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/15.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "PasswordViewController.h"
#import "ButtonAdd.h"
#import "LogViewController.h"
#import "LoginService.h"
#import "Single.h"
@interface PasswordViewController ()<UITextFieldDelegate>
{
    ButtonAdd *lengthCheck;
    LoginService *serVice;
    Single *Sing;
}
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.OverBtn1.layer.masksToBounds =YES;
    self.OverBtn1.layer.cornerRadius=10;
    self.OverBtn1.backgroundColor=[UIColor colorWithRed:246/250.0 green:246/250.0 blue:246/250.0 alpha:1.0];
   lengthCheck = [[ButtonAdd alloc]init];
    self.passWordFiled.delegate =self;
    self.againPasswordField.delegate =self;
    serVice = [[LoginService alloc]init];
    Sing = [Single Send];
    
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

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    if ([textField.text length]>=6 && [textField.text length]<=16) {
        
        self.OverBtn1.backgroundColor =[UIColor colorWithRed:61/255.0 green:185/255.0 blue:253/255.0 alpha:1.0];
        
    }
    
    return YES;
}


- (IBAction)OverBtn:(id)sender {
    
    if ([lengthCheck checkInput:self.passWordFiled.text]||[lengthCheck checkInput:self.againPasswordField.text] )
    {
         [CommoneTools alertOnView:self.view content:@"请填写完整"];
    }
    
    else{
        
    if(![self.passWordFiled.text isEqualToString:self.againPasswordField.text])
        {
          [CommoneTools alertOnView:self.view content:@"两次密码不同"];
        
        }
        
    else
        {
            if ([self.passWordFiled.text length]>=6 && [self.passWordFiled.text length]<=16) {
                [serVice Regist:Sing.ID MobileNum:self.telNum andPassWord:self.passWordFiled.text successBlock:^(NSString *success) {
                    
                    if ([success isEqualToString:@"S"]) {
                        
                        LogViewController *LoginVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-4];
                        
                        LoginVC.telePhoneNumber.text = self.telNum;
                        LoginVC.passwordText.text =self.passWordFiled.text;
                        
                        [self.navigationController popToViewController:LoginVC animated:YES];
                        
                    }
                    else
                    {
                        [CommoneTools alertOnView:self.view content:@"该手机已注册"];

                    }
                    
                    
                } FailuerBlock:^(NSString *error) {
                    [CommoneTools alertOnView:self.view content:@"注册失败"];
                    
                }];

              }
            
            else
            {
             [CommoneTools alertOnView:self.view content:@"密码长度错误"];
            }
            
            
        }
    }
}


@end
