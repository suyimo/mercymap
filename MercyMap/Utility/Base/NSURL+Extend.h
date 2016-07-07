//
//  NSURL+EasyExtend.h
//  leway
//
//  Created by keirlee on 14-6-5.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extend.h"
@interface NSURL (EasyExtend)
- (NSURL *)addParams:(NSDictionary *)params;
- (NSDictionary *)params;
@end
