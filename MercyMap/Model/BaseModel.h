//
//  BaseModel.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel
@property(nonatomic,strong)NSString * flag;
-(BOOL)hasNoError;

@end
