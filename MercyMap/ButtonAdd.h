//
//  ButtonAdd.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Addition.h"
@protocol  ImageSendDelegate<NSObject>
-(void)sendCammerImage;
@end

@interface ButtonAdd : UIView<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)id<ImageSendDelegate>delegate;

-(void)setButton:(UIButton *)Btn BtnTitile:(NSString *)str;
-(BOOL)checkInput:(NSString *)str;

-(void)CheckCammer:(UIViewController *)View andViewVC:(UIViewController *)VC;

-(void)AlterView:(UIViewController *)view;
@end
