//
//  LoginService.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "LoginService.h"
#import "AppDelegate.h"
#import "Single.h"
#import "LoginModel.h"
#import "LightModel.h"
@implementation LoginService
{
    Single *single;
}

-(void)Login:(int)ID UserName:(NSString *)UserName andPassWord:(NSString *)password successBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock
{
            //设备名称
//            NSString *strName = [[UIDevice currentDevice]name];
//            //系统名称
//            NSString *strSysName =[[UIDevice currentDevice]systemName];
//            //手机机型
//            NSString *phoneModel = [[UIDevice currentDevice]model];
            //app当前应用软件版本
//            NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
//            NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    
//            NSString *Allstr = [NSString stringWithFormat:@"%@%@%@",strName,strSysName,phoneModel];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserLogin"];
    
    NSDictionary *dic =@{@"MobileNum":UserName,@"Password":password,@"ClientAttr":@"123",@"TokenType":@10};
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
         NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setValue:dicData[@"OMsg"][@"Flag"] forKey:@"Flag"];
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"])
        {
            [dic addEntriesFromDictionary:dicData[@"MUsers"]];
            [dic setValue:dicData[@"Token"] forKey:@"Token"];
           
             successBlock(dic);
        }
        else
        {
            [dic setValue:dicData[@"OMsg"][@"Msg"]forKey:@"Reason"];
            successBlock(dic);
        }
        
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
    }];
    
}


-(void)Regist:(int)ID MobileNum:(NSString *)MobileNum andPassWord:(NSString *)password successBlock:(RegSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock

{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserReg"];
    NSNumber *UserID = [NSNumber numberWithInt:ID];
    NSDictionary *dic = @{@"ID":UserID,@"MobileNum":MobileNum,@"Password":password};
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
            
            successBlock(dicData[@"OMsg"][@"Flag"]);
                
       
    } Failuer:^(NSString *errorInfo) {
        
        errorBlock(errorInfo);
    }];
    
}



-(void)getUser:(int)ID Token:(NSString *)Token successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"http://www.wispeed.com/api/Account/UserInfo?id=%d&token=%@",ID,Token];
    NSNumber *userID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{@"id":userID,@"Token":Token};
    [self sendRequestHttpGet:url parameters:dic   Success:^(NSDictionary *dicData) {
        
        
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            
             successBlock(dicData[@"MUsers"]);
        }
        
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);
        
    }];
}



-(void)fixUserMessage:(int)ID Token:(NSString *)Token Parameters:(NSString *)Parameters Code:(NSString *)Code successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock

{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserUpdate"];
    
    NSNumber *UserID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =[[NSDictionary alloc]init];
    
    if ([Code isEqualToString:@"RealName"]) {
        dic=@{@"ID":UserID,@"Token":Token,@"RealName":Parameters};
    }
    if ([Code isEqualToString:@"NickName"]) {
        dic =@{@"ID":UserID,@"Token":Token,@"NickName":Parameters};
        
    }
    if ([Code isEqualToString:@"HeadImg"])
    {
        dic =@{@"ID":UserID,@"Token":Token,@"HeadImg":Parameters};
        
    }
    if ([Code isEqualToString:@"Address"]) {
        dic=@{@"ID":UserID,@"Token":Token,@"Address":Parameters};
    }
    if ([Code isEqualToString:@"Idiograph"]) {
        
        dic =@{@"ID":UserID,@"Token":Token,@"Idiograph":Parameters};
        
    }
    if ([Code isEqualToString:@"Sex"]) {
        
        bool bool_true ;
        NSString *sex;
        if ([Parameters isEqualToString:@"Boy"]) {
        //         bool_true =true;
            sex=@"true";
        }
        else
        {
            bool_true =false;
            sex=@"false";
        }
        
       dic =@{@"ID":UserID,@"Token":Token,@"Sex":sex};
        
    }
    
    if ([Code isEqualToString:@"ThirdLogin"]) {
        
        single =[Single Send];
        
        dic =@{@"ID":[NSNumber numberWithInt:single.ID],@"Token":single.Token,@"NickName":single.nickname,@"HeadImg":single.imageUrl};
    }

    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
        successBlock(dicData[@"MUsers"]);
        
    } Failuer:^(NSString *errorInfo) {
        
        errorBlock(errorInfo);
        
    }];
}


-(void)fixUserCity:(int)ID Token:(NSString *)Token Province:(NSString *)Province City:(NSString *)City successBlock:(GetUserInfornationSuccessBlock)successBlock Failuer:(GetUserInfornationFailuerBlock)errorBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Account/UserUpdate"];
    NSNumber *UserID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =[[NSDictionary alloc]init];
    dic=@{@"ID":UserID,@"Token":Token,@"Province":Province,@"City":City};
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
        successBlock(dicData[@"OMsg"]);

        
    } Failuer:^(NSString *errorInfo) {
        errorBlock(errorInfo);

        
        
    }];
    
    
    
}

-(void)getLightKindInfornation:(int)shopCategoryID PageIndex:(int)pageIndex PageSize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/GetShopListForCategory"];
    NSDictionary *dic =[[NSDictionary alloc]init];
    NSNumber *shopcategoryID =[NSNumber numberWithInt:shopCategoryID];
    NSNumber *pageindex =[NSNumber numberWithInt:pageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:pageSize];
    dic =@{@"shopCategoryID":shopcategoryID,@"pageIndex":pageindex,@"pageSize":pagesize};
//    NSMutableArray *dataArray =[[NSMutableArray alloc]initWithCapacity:0];
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData)
    {
        
        
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            
//            for (NSDictionary *tmpDic in dicData[@"ListShopList"])
//            {
//                LightModel *model =[[LightModel alloc]initWithDictionary:tmpDic error:nil];
//                [dataArray addObject:model];
//                successBlock(dataArray);
//            }
            successBlock(dicData[@"ListShopList"]);
//
            
        }
           }
    Failuer:^(NSString *errorInfo)
    {
       errorBlock(errorInfo);
    }];
}



-(void)getLightListInfonation:(int)PageIndex Pagesize:(int)pageSize successBlock:(GetLightInfonationSuccessBlock)successBlock Failuer:(GetLightInfonationFailuerBlock)errorBlock
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/GetShopListForCategory"];
    NSDictionary *dic =[[NSDictionary alloc]init];
    NSNumber *pageindex =[NSNumber numberWithInt:PageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:pageSize];
    dic =@{@"pageIndex":pageindex,@"pageSize":pagesize};
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
    if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
               
               successBlock(dicData[@"ListShopList"]);
               
           }
    } Failuer:^(NSString *errorInfo)
    {
       errorBlock(errorInfo);
       
   }];
}
     

-(void)GetSelfLightInfo:(int)ID SuccessBlock:(LoginSuccessBlock)successBlock FailuerBlock:(loginFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"%@api/Shop/GetShopDetail?shopID=%d",URLM,ID];
    NSNumber *LightID =[NSNumber numberWithInt:ID];
    NSDictionary *dic =@{@"shopID":LightID};
    
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData)
    {
        if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"])
        {
            successBlock(dicData[@"ShopList"]);
        }
        else
        {
            errorBlock(dicData[@"OMsg"][@"Msg"]);
        }
        
    }
    Failuer:^(NSString *errorInfo)
    {
        errorBlock(errorInfo);
    }];
}


-(void)GetSelfLightComment:(int)shopID PageIndex:(int)pageIndex pageSize:(int)pageSize SuccessBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetLightInfonationFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"%@api/Shop/ShopCommentList?shopID=%d&pageIndex=%d&pageSize=%d",URLM,shopID,pageIndex,pageSize];
    
    NSNumber *ShopID =[NSNumber numberWithInt:shopID];
    NSNumber *PageIndex =[NSNumber numberWithInt:pageIndex];
    NSNumber *PageSize =[NSNumber numberWithInt:pageSize];
    
    NSDictionary *dic= @{@"ID":ShopID,@"pageIndex":PageIndex,@"pageSize":PageSize};
    
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData)
   {
       if ([dicData[@"OMsg"][@"Flag"]isEqualToString:@"S"])
       {
           successBlock(dicData[@"ListShopComment"]);
           
       }
       else
       {
           errorBlock(dicData[@"OMsg"][@"Msg"]);
       }
      
   }
   Failuer:^(NSString *errorInfo) {
       
       errorBlock(errorInfo);
       
   }];
}


-(void)dianzanLightShopID:(int)ShopID UID:(int)UID Token:(NSString *)Token SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/ClickLike"];
    NSNumber *shopID =[NSNumber numberWithInt:ShopID];
    NSNumber *uID =[NSNumber numberWithInt:UID];
    NSDictionary *Userdic,*dic;
    
    Userdic =@{@"ShopID":shopID,@"UID":uID};
    dic =@{@"ShopLiked":Userdic,@"Token":Token};
    
   [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
        successBlock(dicData[@"Msg"]);
        
    } Failuer:^(NSString *errorInfo) {
        
    }];
    
}


-(void)sendCommentShopID:(int)ShopID UID:(int)UID Token:(NSString *)Token CommentInfo:(NSString *)CommentInfo SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock
{
    
    NSString *url =[NSString stringWithFormat:@"%@%@",URLM,@"api/Shop/ShopComment"];
    NSNumber *shopID =[NSNumber numberWithInt:ShopID];
    NSNumber *uID =[NSNumber numberWithInt:UID];
    
    NSDictionary *Userdic,*dic;
    Userdic =@{@"ShopID":shopID,@"UID":uID,@"CommentInfo":CommentInfo};
    dic =@{@"ShopComment":Userdic,@"Token":Token};

    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
        successBlock(dicData[@"Msg"]);
        
    } Failuer:^(NSString *errorInfo) {
        
    }];

    
}



-(void)CreateLight:(NSString *)ShopName ShopCategoryID:(int)ShopCategoryID ShopMainImg:(NSString *)ShopMainImg ShopAddr:(NSString *)ShopAddr ShopHours:(NSString *)ShopHours ShopStory:(NSString *)ShopStory ShopImageArray:(NSMutableArray *)ImageArray Token:(NSString *)Token ShopMobileNum:(NSString *)ShopMobileNum ShopGPS:(NSString *)ShopGPS SuccessBlock:(RegSuccessBlock)successBlock FailuerBlock:(RegFailuerBlock)errorBlock
{
    single=[Single Send];
    NSString *url =[NSString stringWithFormat:@"%@api/Shop/CreateShop",URLM];
    NSNumber *shopCategoryID =[NSNumber numberWithInt:ShopCategoryID];
    NSNumber *uid =[NSNumber numberWithInt:single.ID];
    NSMutableDictionary *dic;
    NSDictionary *dic2;
    dic =[[NSMutableDictionary alloc]initWithCapacity:0];
   dic2=@{@"ShopName":ShopName,@"ShopCategoryID":shopCategoryID,@"ShopMainImg":ShopMainImg,@"ShopAddr":ShopAddr,@"ShopHours":ShopHours,@"ShopStory":ShopStory,@"Token":Token,@"ShopMobileNum":ShopMobileNum,@"UID":uid,@"ShopGPS":ShopGPS};
    
    [dic addEntriesFromDictionary:dic2];
    
    
    for (int i=0; i<ImageArray.count; i++)
    {
        
        NSString *ImageName =[NSString stringWithFormat:@"ShopImg%d",i+1];
        
        [dic setObject:ImageArray[i] forKey:ImageName];
    }
    
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData){
        
        successBlock(dicData[@"Msg"]);
        NSLog(@"%@",dicData[@"Msg"]);
        
        
        } Failuer:^(NSString *errorInfo) {
        
    }];
    
}

-(void)CollectionUser:(int)ShopID UID:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token SuccessBlock:(RegSuccessBlock)successBlock Failuer:(RegFailuerBlock)errorBlock
{
    NSString *url = [NSString stringWithFormat:@"%@api/Account/UserClickFocus",URLM];
    NSNumber *shopid = [NSNumber numberWithInt:ShopID];
    NSNumber *uid =[NSNumber numberWithInt:UID];
    NSDictionary *dic;
    if (FocusType) {
        dic =@{@"ShopID":shopid,@"UID":uid,@"FocusType":@"false",@"Token":Token};

    }
    else{
       dic =@{@"ShopID":shopid,@"UID":uid,@"FocusType":@"true",@"Token":Token};
}
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
       
        successBlock(dicData[@"Msg"]);
        
    } Failuer:^(NSString *errorInfo) {
        
        errorBlock(errorInfo);
        
    }];
    
    
}



-(void)CollectionInfo:(int)UID FocusType:(BOOL)FocusType Token:(NSString *)Token PageSize:(int)PageSize PageIndex:(int)PageIndex SuccesBlock:(GetLightInfonationSuccessBlock)successBlock FailuerBlock:(GetUserInfornationFailuerBlock)errorBlock
{
    NSString *url =[NSString stringWithFormat:@"%@api/Account/UserClickFocusList",URLM];
    NSNumber *uid =[NSNumber numberWithInt:UID];
    NSNumber *pageIndex =[NSNumber numberWithInt:PageIndex];
    NSNumber *pagesize =[NSNumber numberWithInt:PageSize];
    NSDictionary *dic;
    if (FocusType) {
        
        dic =@{@"UID":uid,@"FocusType":@"false",@"Token":Token,@"pageSize":pagesize,@"pageIndex":pageIndex};
        
    }
    else{
        dic =@{@"UID":uid,@"FocusType":@"true",@"Token":Token,@"pageSize":pagesize,@"pageIndex":pageIndex};
    }
    
    [self sendRequestHttp:url parameters:dic Success:^(NSDictionary *dicData) {
        
        successBlock(dicData[@"ListUserClickFocus"]);
        
    } Failuer:^(NSString *errorInfo) {
        
        errorBlock(errorInfo);
        
    }];
    
    
}


-(void)firstLogin
{
    //        //设备名称
    //        NSString *strName = [[UIDevice currentDevice]name];
    //        //系统名称
    //        NSString *strSysName =[[UIDevice currentDevice]systemName];
    //        //手机机型
    //        NSString *phoneModel = [[UIDevice currentDevice]model];
    //app当前应用软件版本
    //        NSDictionary *dicInfo = [[NSBundle mainBundle]infoDictionary];
    //        NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    
    //        NSString *Allstr = [NSString stringWithFormat:@"%@%@%@",strName,strSysName,phoneModel];
    
    [self sendRequestHttp:[NSString stringWithFormat:@"%@/api/Account/UserCreateGuest",URLM]parameters:nil Success:^(NSDictionary *dicData)
     {
         // [[NSUserDefaults standardUserDefaults]setObject:dicData[@"ID"] forKey:@"userID"];
         Single *sing = [[Single alloc]init];
         sing = [Single Send];
         sing.ID = [dicData[@"ID"] intValue];
         int ID =sing.ID;
         
         [[NSUserDefaults standardUserDefaults]setInteger:ID forKey:@"ID"];
         
         
     } Failuer:^(NSString *errorInfo) {
         NSLog(@"gg%@",errorInfo);
         NSLog(@"error");
         
     }];
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"newUser"];

}

@end
