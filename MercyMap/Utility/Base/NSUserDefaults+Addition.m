//
//  NSUserDefaults+Addition.m
//  tiangou
//
//  Created by admin on 14-4-8.
//  Copyright (c) 2014年 shangdao. All rights reserved.
//

#import "NSUserDefaults+Addition.h"
@implementation NSUserDefaults (Addition)

NSString *const APPDefaultsKeyLaunched=@"app_launched";
NSString *const APPRoleId=@"roleId";
NSString *const APPDefaultsKeyUserName=@"app_userName";
NSString *const APPDefaultsKeyPassword = @"app_password";
NSString *const APPEmployModel = @"employModel";
NSString *const APPArea = @"area";
NSString *const APPName= @"name";
NSString *const AppLoginState= @"loginState";
NSString *const ApptoGestureState= @"toGestureState";

NSString *const APPLongitude= @"APPLongitude";
NSString *const APPLatitude = @"APPLatitude";
NSString *const APPToken = @"token";
NSString *const APPUserId = @"user_id";
NSString *const APPUserName = @"username";
NSString *const APPDefaultsKeyUserJid = @"app_userjid";
NSString *const APPDefaultsKeyUserStatus=@"app_userStatus";
NSString *const APPDefaultsKeyDataHolder = @"app_dataHolder";
NSString *const APPDefaultsKeyUserFriendList= @"app_userFriendList";
NSString *const APPPassWord = @"passWord";
NSString *const APPUserIdKey = @"userIdKey";
NSString *const APPStoresId = @"storesId";
NSString *const APPState = @"state";

NSString *const APPCardNo = @"cardNo";
NSString *const APPIntegral = @"integral";
NSString *const APPMlevel = @"mlevel";
NSString *const APPMobile = @"mobile";
NSString *const APPMemberName = @"memberName";
NSString *const APPSex = @"sex";
NSString *const APPStorage = @"storage";

// 经度
-(double)getLongitude
{
    return [self doubleForKey:APPLongitude];
}

-(void)setLongitude:(double)longitude
{
    [self setObject:@(longitude) forKey:APPLongitude];
}

// 纬度
-(double)getLatitude
{
    return [self doubleForKey:APPLatitude];
}

-(void)setLatitude:(double)latitude
{
    [self setObject:@(latitude) forKey:APPLatitude];
}


-(NSString *)getName
{
    return [self stringForKey:APPName];
}

-(void)setName:(NSString *)name
{
    [self setObject:name forKey:APPName];
}


-(void)setArea:(NSString *)area
{
    [self setObject:area forKey:APPArea];
}

-(NSString *)getArea
{
    return [self stringForKey:APPArea];
}

-(void)setEmployeesLogModel:(NSDictionary *)employModel
{
    [self setObject:employModel forKey:APPEmployModel];
}

-(NSDictionary *)getEmployeesLogModel{
    return [self objectForKey:APPEmployModel];
}

- (BOOL)app_launched {
    return [[self objectForKey:APPDefaultsKeyLaunched] boolValue];
}

- (void)app_setLaunched:(BOOL)app_launched{
    [self setObject:[NSNumber numberWithBool:app_launched] forKey:APPDefaultsKeyLaunched];
}

- (NSString*)getRoleId {
    return [self stringForKey:APPRoleId];
}

- (void)setRoleId:(NSString *)roleId{
    [self setObject:roleId forKey:APPRoleId];
}



-(NSString *)app_userName
{
    return [self stringForKey:APPDefaultsKeyUserName];
}

- (void)app_setUserName:(NSString *)app_userName{
    [self setObject:app_userName forKey:APPDefaultsKeyUserName];
}


- (NSString *)app_password {
    return [self stringForKey:APPDefaultsKeyPassword];
}

- (void)app_setPassword:(NSString *)app_password {
    [self setObject:app_password forKey:APPDefaultsKeyPassword];
}
//登录状态
-(BOOL)getLoginState{
    return [self boolForKey:AppLoginState];
}
-(void)setLoginState:(BOOL)loginState{
    [self setObject:[NSNumber numberWithBool:loginState] forKey:AppLoginState];
}
//是否进入手势
- (BOOL)getToGestureState
{
    return [self boolForKey:ApptoGestureState];
}
- (void)setToGestureState:(BOOL)toGestureState
{
    [self setObject:[NSNumber numberWithBool:toGestureState] forKey:ApptoGestureState];
}


-(NSString *)getToken{
    return [self stringForKey:APPToken];
}
-(void)setToken:(NSString *)token{
    [self setObject:token forKey:APPToken];
}
//用户id
-(NSInteger)getUserId{
    return [self integerForKey:APPUserId];
}
-(void)setUserId:(NSInteger)userId{
    [self setObject:[NSNumber numberWithInteger:userId] forKey:APPUserId];
}
//用户名
-(NSString *)getUserName{
    return [self stringForKey:APPUserName];
}
-(void)setUserName:(NSString *)userName{
    [self setObject:userName forKey:APPUserName];
}

- (NSString *)getState {
    return [self stringForKey:APPState];
}

- (void)setState:(NSString *)state {
    [self setObject:state forKey:APPState];
}

- (NSString *)app_userStatus {
    return [self stringForKey:APPDefaultsKeyUserStatus];
}

- (void)app_setUserStatus:(NSString *)app_userStatus{
    [self setObject:app_userStatus forKey:APPDefaultsKeyUserStatus];
}

- (NSDictionary*)app_dataHolder{
    return (NSDictionary*)[self stringForKey:APPDefaultsKeyDataHolder];
}

- (void)app_setDataHolder:(NSDictionary *)app_dataHolder {
    [self setObject:app_dataHolder forKey:APPDefaultsKeyDataHolder];
}


-(void)setPassWord:(NSString *)passWord{
    [self setObject:passWord forKey:APPPassWord];
}
-(NSString *)passWord{
    return [self stringForKey:APPPassWord];
}

- (NSString *)getStoresId {
    return [self stringForKey:APPStoresId];
}

- (void)setStoresId:(NSString *)storesId{
    [self setObject:storesId forKey:APPStoresId];
}

- (NSArray *)app_userFriendList {
    return [self objectForKey:APPDefaultsKeyUserFriendList];
}

- (void)app_setUserFriendList:(NSArray *)app_userFriendList{
    [self setObject:app_userFriendList forKey:APPDefaultsKeyUserFriendList];
}

- (NSString *)getCardNo {
    return [self stringForKey:APPCardNo];
}

- (void)setCardNo:(NSString *)cardNo{
    [self setObject:cardNo forKey:APPCardNo];
}

- (NSNumber *)getIntegral {
    return [self objectForKey:APPIntegral];
}

- (void)setIntegral:(NSNumber *)integral{
    [self setObject:integral forKey:APPIntegral];
}

- (NSString *)getMlevel {
    return [self stringForKey:APPMlevel];
}

- (void)setMlevel:(NSString *)mlevel{
    [self setObject:mlevel forKey:APPMlevel];
}

- (NSString *)getMobile {
    return [self stringForKey:APPMobile];
}

- (void)setMobile:(NSString *)mobile{
    [self setObject:mobile forKey:APPMobile];
}

- (NSString *)getMemberName {
    return [self stringForKey:APPMemberName];
}

- (void)setMemberName:(NSString *)memberName{
    [self setObject:memberName forKey:APPMemberName];
}

- (NSString *)getSex {
    return [self stringForKey:APPSex];
}

- (void)setSex:(NSString *)sex{
    [self setObject:sex forKey:APPSex];
}

- (NSString *)getStorage{
    return [self stringForKey:APPStorage];
}

- (void)setStorage:(NSString *)storage{
    [self setObject:storage forKey:APPStorage];
}

- (NSString *)getUserIdKey{
    return [self stringForKey:APPUserIdKey];
}

- (void)setUserIdKey:(NSString *)userIdKey{
    [self setObject:userIdKey forKey:APPUserIdKey];
}

@end
