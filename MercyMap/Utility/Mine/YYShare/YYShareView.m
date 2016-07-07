//
//  ButtonAdd.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "YYShareView.h"

@implementation YYShareView

-(void)awakeFromNib
{
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.ShareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 145);
}

+(instancetype)creatXib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YYShareView" owner:nil options:nil]lastObject];
}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        
        self.ShareView.frame = CGRectMake(0, self.frame.size.height - 145, self.frame.size.width, 145);
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.ShareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 145);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)YYCancel:(UIButton *)sender
{
    [self close];
}

- (IBAction)touchBut:(UIButton *)sender
{
    self.getTouch((int)sender.tag);
    [self close];
}

@end
