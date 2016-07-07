//
//  VerificationViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "VerificationViewController.h"
#import "AppDelegate.h"
#import "PasswordViewController.h"
@interface VerificationViewController ()<UITextFieldDelegate>
{
    NSTimer *time;
    int i;
    
}
@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title =@"输入验证码";
     i=60;
    
    self.againSendBtn1.enabled = NO;
    self.CodeID.delegate = self;
    self.NextBtn1.layer.masksToBounds =YES;
    self.NextBtn1.layer.cornerRadius=10;
    [_CodeID becomeFirstResponder];
    _CodeID.keyboardType = UIKeyboardTypeNumberPad;
    
    self.NextBtn1.backgroundColor=[UIColor colorWithRed:246/250.0 green:246/250.0 blue:246/250.0 alpha:1.0];

    
    time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navBackBtn@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnClick)];

}
-(void)navLeftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


-(void)changeTime
{
    if (i==0)
    {
        i=60;
        [time invalidate];
        self.againSendBtn1.enabled = YES;
        self.againSendBtn1.titleLabel.text =[NSString stringWithFormat:@"重新发送"];
        [self.againSendBtn1 setTitleColor:[UIColor colorWithRed:77/250.0 green:142/250.0 blue:249/250.0 alpha:1.0]forState:UIControlStateNormal];
    }
    else
    {
        i--;
       [self.againSendBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
       self.againSendBtn1.titleLabel.text =[NSString stringWithFormat:@"重新发送(%d)",i];
        if (i==0)
        {
            [self.againSendBtn1 setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];

        }
        else
        {
        [self.againSendBtn1 setTitle:[NSString stringWithFormat:@"重新发送(%d)",i] forState:UIControlStateNormal];
         //        [self changeTime];
        }
        
    }
    
    
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField = self.CodeID;
    
    if ([textField.text length]>=4)
    {
        self.NextBtn1.backgroundColor =[UIColor colorWithRed:61/255.0 green:185/255.0 blue:253/255.0 alpha:1.0];

    }
    return YES;
}


- (IBAction)againSendBtn:(id)sender {
    
    NSLog(@"%@",self.tel);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.tel zone: @"86" customIdentifier: nil result:^(NSError *error)
     {
         if (!error) {
            
             self.againSendBtn1.enabled = NO;
             time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
         }
         
         else{
             
             [CommoneTools alertOnView:self.view content:@"发送失败"];
             
         }
     }];

    
    
}

- (IBAction)NextBtn:(id)sender {
    
    [SMSSDK commitVerificationCode:self.CodeID.text phoneNumber:self.tel zone: @"86" result:^(NSError *error) {
        if (!error) {
            
            PasswordViewController *PVC= [[PasswordViewController alloc]initWithNibName:@"PasswordViewController" bundle:nil];
            PVC.telNum = self.tel;
            [self.navigationController pushViewController:PVC animated:YES];
            
            
        }
        else
        {
            [CommoneTools alertOnView:self.view content:@"验证码错误"];
        }
        
    }];
    

    
    
}
@end
