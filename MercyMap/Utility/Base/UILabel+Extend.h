//
//  UILabel+EasyExtend.h
//  leway
//
//  Created by keirlee on 14-6-6.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (EasyExtend)
-(CGSize)autoSize;
- (void)adEightWithLines:(unsigned int)line maxHight:(float)maxH spaceWidth:(float)spaceW;
@end
