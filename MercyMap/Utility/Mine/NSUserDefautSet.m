
//
//  NSUserDefautSet.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/20.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "NSUserDefautSet.h"

@implementation NSUserDefautSet

-(void)loginDataStorage:(int)ID MobileNum :(NSString *)MobileNum Password :(NSString *)Password Token:(NSString *)Token
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"ID"];
    [defaults removeObjectForKey:@"MobileNum"];
    [defaults removeObjectForKey:@"Password"];
    [defaults removeObjectForKey:@"Token"];
    [defaults removeObjectForKey:@"UserLogin"];
    
    
    [defaults setObject:Password forKey:@"Password"];
    [defaults setInteger:ID forKey:@"ID"];
    
    [defaults setObject:MobileNum forKey:@"MobileNum"];
    [defaults setObject:Token forKey:@"Token"];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"UserLogin"];
     
}
@end
