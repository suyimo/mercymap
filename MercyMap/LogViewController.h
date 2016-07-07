//
//  LogViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *telePhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)logClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *regBtn1;

- (IBAction)forgetPasswordBtn:(id)sender;
- (IBAction)regBtn:(id)sender;
- (IBAction)QQLog:(id)sender;

- (IBAction)weiboLog:(id)sender;
- (IBAction)weixinlog:(id)sender;
-(void)loginUser:(int)fag;
@property(nonatomic,assign)int fagB;
@end
