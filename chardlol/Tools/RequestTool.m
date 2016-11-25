//
//  RequestTool.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "RequestTool.h"
#import "AFNetworking.h"

@implementation RequestTool

+ (void)GET:(NSString *)urlString
 Parameters:(NSDictionary *)parameters
  Successed:(void (^)(id resData))successed
     Failed:(void (^)(NSError *error))failed
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (successed) {
            successed(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)POST:(NSString *)urlString
  Parameters:(NSDictionary *)parameters
   Successed:(void (^)(id resData))successed
      Failed:(void (^)(NSError *error))failed
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successed) {
            successed(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}

@end
