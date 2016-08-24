//
//  LSLHttpTool.m
//  百思不得姐
//
//  Created by 李天空 on 16/5/30.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "LSLHttpTool.h"
@implementation LSLHttpTool

+(void)get:(NSInteger)index params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
 
    NSString * str = [NSString stringWithFormat:@"http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=%zd&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2",index];

    //2.发送Get请求
    [mgr GET:str parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
             if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *dataTask = [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}


@end
