//
//  ButtonAdd.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/12.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYShareView : UIView

@property (strong,nonatomic)void (^getTouch)(int ButTag);
@property (weak, nonatomic) IBOutlet UIView *ShareView;

@property (weak, nonatomic) IBOutlet UIButton *Btnsender;

+(instancetype)creatXib;
-(void)show;
-(void)close;


@end
