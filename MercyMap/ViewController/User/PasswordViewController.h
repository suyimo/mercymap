//
//  PasswordViewController.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/15.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol backViewDelegate
//-(void)backView:(NSString *)telPhoneNum andPassWord:(NSString *)password;
//@end

@interface PasswordViewController : UIViewController
//@property(nonatomic,weak)id<backViewDelegate>delegate;
@property(nonatomic,strong)NSString *telNum;
@property (weak, nonatomic) IBOutlet UITextField *passWordFiled;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordField;
- (IBAction)OverBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *OverBtn1;

@end
