//
//  LoginService.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "LoginModel.h"
#import "LightModel.h"

typedef void(^LoginSuccessBlock)(NSMutableDictionary *dic);
typedef void (^loginFailuerBlock)(NSString *error);
typedef void(^RegSuccessBlock)(NSString *success);
typedef void(^RegFailuerBlock)(NSString *error);
typedef void(^GetUserInfornationSuccessBlock)(NSDictionary *model);
typedef void (^GetUserInfornationFailuerBlock)(NSString *error);
typedef void(^GetLightInfonationSuccessBlock)(NSArray *modelArray);
typedef void (^GetLightInfonationFailuerBlock)(NSString *error);
@interface LoginService : BaseHttpRequest

-(void)Login:(int)ID UserName:(NSString *)UserName andPassWord:(NSString *)password successBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock;

-(void)Regist:(int)ID MobileNum:(NSString *)MobileNum andPassWord:(NSString *)password successBlock:(RegSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock;

-(void)getUser:(int)ID Token:(NSString *)Token  successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock;

-(void)fixUserMessage:(int)ID Token:(NSString *)Token Parameters:(NSString *)Parameters Code:(NSString *)Code successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock;

-(void)fixUserCity:(int)ID Token:(NSString *)Token Province:(NSString *)Province City:(NSString *)City successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock;


-(void)getLightKindInfornation:(int)shopCategoryID PageIndex:(int)pageIndex PageSize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock;


-(void)getLightListInfonation:(int)PageIndex Pagesize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock;


-(void)GetSelfLightInfo:(int)ID SuccessBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock;


-(void)GetSelfLightComment:(int)shopID PageIndex:(int)pageIndex pageSize:(int)pageSize SuccessBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetLightInfonationFailuerBlock)errorBlock;

-(void)dianzanLightShopID:(int)ShopID UID:(int)UID Token:(NSString *)Token SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock;

-(void)sendCommentShopID:(int)ShopID UID:(int)UID Token:(NSString *)Token CommentInfo:(NSString *)CommentInfo  SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock;


-(void)CreateLight:(NSString *)ShopName ShopCategoryID:(int)ShopCategoryID ShopMainImg:(NSString *)ShopMainImg ShopAddr:(NSString *)ShopAddr ShopHours:(NSString *)ShopHours  ShopStory:(NSString *)ShopStory ShopImageArray:(NSMutableArray *)ImageArray Token:(NSString *)Token ShopMobileNum:(NSString *)ShopMobileNum ShopGPS:(NSString *)ShopGPS  SuccessBlock:(RegSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock;


-(void)CollectionUser:(int)ShopID  UID:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token SuccessBlock:(RegSuccessBlock) successBlock Failuer:(RegFailuerBlock)errorBlock;


-(void)CollectionInfo:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token PageSize:(int)PageSize PageIndex:(int)PageIndex SuccesBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetUserInfornationFailuerBlock)errorBlock;

-(void)firstLogin;

@end
