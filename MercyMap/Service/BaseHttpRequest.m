//
//  BaseHttpRequest.m
//  MercyMap
//
//  Created by sunshaoxun on 16/4/14.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "AFNetworking.h"
#import "JSONModel.h"
#import "JSONKit.h"
#import "UIImage+Addition.h"
#import "Single.h"
@implementation BaseHttpRequest

-(void)sendRequestHttp:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dic1 =[str objectFromJSONString];
        successBlock(dic1);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error.description);
        
    }];
    
    
}

-(void)sendRequestHttpGet:(NSString *)url parameters:(NSDictionary *)dic Success:(RequestSuccessBlock)successBlock Failuer:(RequestFaileBlock)errorBlock
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
   [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       NSData *data = (NSData *)responseObject;
       NSString *str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       NSDictionary *dic1 =[str objectFromJSONString];
       successBlock(dic1);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         errorBlock(error.description);
        
    }];
    
}




-(void)sendImage:(NSString *)url Sizeimage:(UIImage *)resizedImage iamgeName:(NSString *)fileName Token:(NSString *)Toekn success:(RequestImageSuccessBlock)success error:(RequestImageFailurBlock)error
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSData *imageData =UIImageJPEGRepresentation(resizedImage, 0.5);

//    [UIImage savePNGImage:resizedImage toCachesWithName:fileName];
//    NSData *imageData = [NSData dataWithContentsOfFile: [UIImage getPNGImageFilePathFromCache:fileName]];
//    NSString *str1 = [[NSString alloc]initWithData:imageData encoding:NSUTF8StringEncoding];
//    NSString *str2=[imageData base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
//    NSString * str = imageData.description;
//    str  =[str stringByReplacingOccurrencesOfString:@" " withString:@""];
//    str=[str stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    str =[str stringByReplacingOccurrencesOfString:@">" withString:@""];
//    
//    NSDictionary *dataDic =@{@"receivedBytes":str,@"fileName":fileName};
//    NSArray *dataArray=@[dataDic];
//    
//    NSData *data=[NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:nil];
    
    
//    NSDictionary *dic=@{@"UpFileList":data,@"Token":Toekn};
//   NSDictionary *dic =@{@"receivedBytes":str,@"fileName":fileName,@"Token":Toekn};
//   [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        NSData *data = (NSData *)responseObject;
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSDictionary *dic = (NSDictionary *)[str objectFromJSONString];
//        if ([dic[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
//            
//            [SDWebImageManager.sharedManager.imageCache clearMemory];
//            [SDWebImageManager.sharedManager.imageCache clearDisk];
//            success(dic[@"uploadPicture"]);
//            
//            //
//            //             SDImageCache *sd = [[SDImageCache alloc] init];
//            //             NSData *data = [NSData dataWithContentsOfURL:url];
//            //
//            //             NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            //
//            //             [sd removeImageForKey:str];
//            
//        }
//        else
//        {
//            success(dic[@"OMsg"][@"Msg"]);
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    NSDictionary *dic =@{@"Token":Toekn};
    
  [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
      
      [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
      
  } success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
               NSData *data = (NSData *)responseObject;
               NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       
               NSDictionary *dic = (NSDictionary *)[str objectFromJSONString];
               if ([dic[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
       
                   [SDWebImageManager.sharedManager.imageCache clearMemory];
                   [SDWebImageManager.sharedManager.imageCache clearDisk];
                   success(dic[@"uploadPictures"]);
               }
               else
               {
                   
                   success(dic[@"Omsg"]);
               }
    
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"image error");
    
   }];
    
}


-(void)sendImageurl:(NSString *)url imageArray:(NSArray *)imageArray Token:(NSString *)Token success:(RequestImageSuccessBlock)successBlock Failuer:(RequestImageFailurBlock)errorBlock
{
    single =[Single Send];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *dic =@{@"Token":single.Token};
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
        for (int i = 0; i<imageArray.count; i++) {
            UIImage * image = imageArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
            
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
            NSDate * date =[NSDate date];
            NSString * imageName = [formatter stringFromDate:date];
            imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@""];
            imageName = [imageName stringByReplacingOccurrencesOfString:@"-" withString:@""];
            imageName = [NSString stringWithFormat:@"%@%d%d.jpg",imageName,single.ID,i];

        
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:imageName mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = (NSDictionary *)[str objectFromJSONString];
        if ([dic[@"OMsg"][@"Flag"]isEqualToString:@"S"]) {
            
            [SDWebImageManager.sharedManager.imageCache clearMemory];
            [SDWebImageManager.sharedManager.imageCache clearDisk];
            successBlock(dic[@"uploadPictures"]);
        }
        else
        {
            
            successBlock(dic[@"Omsg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"image error");
        
    }];
    

    
}

@end
