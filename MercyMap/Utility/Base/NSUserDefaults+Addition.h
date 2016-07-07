//
//  NSUserDefaults+Addition.h
//  tiangou
//
//  Created by admin on 14-4-8.
//  Copyright (c) 2014年 shangdao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSUserDefaults (Addition)

@property (assign, getter=app_launched,
           setter=app_setLaunched:)BOOL app_launched;

@property (assign, getter=getRoleId,
           setter=setRoleId:)NSString *roleId;

@property (assign, getter=passWord,
           setter=setPassWord:) NSString *passWord;

@property (assign, getter=app_password,
           setter=app_setPassword:) NSString *app_password;

@property (assign, getter=app_userName,
           setter=app_setUserName:) NSString *app_userName;

@property (assign, getter=getEmployeesLogModel,
           setter=setEmployeesLogModel:) NSDictionary *employModel;

@property (assign, getter=getArea,
           setter=setArea:) NSString *area;

@property (assign, getter=getName,
           setter=setName:) NSString *name;
/**
 *  @Author 傅锦, 14-12-11 15:12:13
 *
 *  @brief  登录状态
 */
@property (assign, getter=getLoginState,
           setter=setLoginState:) BOOL loginState;
/**
 *  是否进入手势
 */
@property (assign, getter=getToGestureState,
           setter=setToGestureState:)BOOL toGestureState;

@property (assign, getter=getToken,
           setter=setToken:) NSString *token;

@property (assign, getter=getUserId,
           setter= setUserId:) NSInteger userId;

@property (assign, getter=getUserIdKey,
           setter=setUserIdKey:) NSString *userIdKey;
/**
 *
 *  @brief 用户名
 */
@property (assign, getter=getUserName,
           setter=setUserName:) NSString *userName;

@property (assign, getter=getState,
           setter=setState:) NSString *state;

@property (assign, getter=getStoresId,
           setter=setStoresId:) NSString *storesId;


//以下为会员相关
@property (assign, getter=getCardNo,
           setter=setCardNo:) NSString *cardNo;

@property (assign, getter=getIntegral,
           setter=setIntegral:) NSNumber *integral;

@property (assign, getter=getMlevel,
           setter=setMlevel:) NSString *mlevel;

@property (assign, getter=getMobile,
           setter=setMobile:) NSString *mobile;

@property (assign, getter=getMemberName,
           setter=setMemberName:) NSString *memberName;

@property (assign, getter=getSex,
           setter=setSex:) NSString *sex;

@property (assign, getter=getStorage,
           setter=setStorage:) NSString *storage;
@end

