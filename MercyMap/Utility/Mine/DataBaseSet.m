//
//  DataBaseSet.m
//  MercyMap
//
//  Created by sunshaoxun on 16/6/16.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import "DataBaseSet.h"

@implementation DataBaseSet

-(NSString *)getDBpath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
    
    NSLog(@"%@",dbPath);
    return dbPath;
    
}


-(void)getDBInfo:(NSString *)sql getInfo:(getDBInfoBlock)getInfo
{
    NSFileManager *filemanager =[NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:[self getDBpath]])
    {
        FMDatabase *database =[FMDatabase databaseWithPath:[self getDBpath]];
        [database open];
        
        FMResultSet *result = [database executeQuery:sql];

//        BOOL isSuccess =[database executeQuery:sql];
        
        if([result next])
        {
            
            NSString *success =[result stringForColumn:@"time"];
            getInfo(success);
            [database close];
            
        }
        
        else
        {
            NSString *str =@"failuer";
            getInfo(str);
        }
        
    }
    else
    {
        FMDatabase *database =[FMDatabase databaseWithPath:[self getDBpath]];
        [database open];
        
        NSString *sql1 =[NSString stringWithFormat:@"CREATE TABLE dianzan (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,time varchar NOT NULL,name integer NOT NULL);"];
        BOOL issuccess =[database executeUpdate:sql1];
        if (issuccess)
        {
           [database close];
            NSString *success =@"DSuccess";
            getInfo(success);
            
        }
        
        else
        {
            NSLog(@"获取数据库失败");
        }

        
    }

}


-(void)getDBInfo:(NSString *)sql gettimeInfo:(getDBInfoBlock)gettime
{
    NSFileManager *filemager =[NSFileManager defaultManager];
    if ([filemager fileExistsAtPath:[self getDBpath]])
    {
        FMDatabase *database =[FMDatabase databaseWithPath:[self getDBpath]];
        [database open];
        BOOL isSuccess = [database executeUpdate:sql];
        if (isSuccess)
        {
            gettime(@"Success");
        }
        
    }
    
}

@end
