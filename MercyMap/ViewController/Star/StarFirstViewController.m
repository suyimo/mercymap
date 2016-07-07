//
//  StarFirstViewController.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/21.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "StarFirstViewController.h"
#import "LoginService.h"
#import "Single.h"
#import "StarInfornationTableViewController.h"
@interface StarFirstViewController ()<UITextFieldDelegate>
{
    UIButton *rightBtn;
    LoginService *service;
    Single *single;
}

@end

@implementation StarFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_EditTextFile becomeFirstResponder];
    _EditTextFile.delegate =self;
    service = [[LoginService alloc]init];
    single = [Single Send];
    [self setTextLable];
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"Over2"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =rightItem;
    
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

-(void)setTextLable
{
    if (_tag==1) {
        
        _introduceLable.text =[NSString stringWithFormat:@"写下你的个人信条"];
        _EditTextFile.placeholder =@"请输入你的宣言";
    }
    
    else
    {
        _EditTextFile.placeholder =@"你的昵称";
    }
}



-(void)Over
{
    
    
    if (_tag ==0) {
        [service fixUserMessage:single.ID Token:single.Token Parameters:self.EditTextFile.text Code:@"NickName" successBlock:^(NSDictionary *model) {
            
            StarInfornationTableViewController *InfoVC =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            
            
            [self.navigationController popToViewController:InfoVC animated:YES];
            
        } Failuer:^(NSString *error) {
            
        }];
    }
    
    if (_tag==1) {
        
        [service fixUserMessage:single.ID Token:single.Token Parameters:self.EditTextFile.text Code:@"Idiograph" successBlock:^(NSDictionary *model) {
            
            StarInfornationTableViewController *InfoVC =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            
            [self.navigationController popToViewController:InfoVC animated:YES];
            
        } Failuer:^(NSString *error) {
            
        }];
    }
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [rightBtn setEnabled:YES];
    [rightBtn setImage:[UIImage imageNamed:@"Over"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(Over) forControlEvents:UIControlEventTouchUpInside];
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [rightBtn setImage:[UIImage imageNamed:@"Over2"] forState:UIControlStateNormal];
    [rightBtn setEnabled:NO];
    return YES;
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
