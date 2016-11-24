//
//  RequestTool.h
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

#define hero_list @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/hero_list.js"
#define hero_package @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/package_info.js"
#define hero_icon @"http://down.qq.com/qqtalk/lolApp/img/champion/"

// 优酷接口
#define yk_clientid @"92927d657412b8f8"
#define yk_users @"https://openapi.youku.com/v2/users/show_batch.json"

#define CACHE_FOLDER [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface RequestTool : NSObject

+ (void)GET:(NSString *)urlString
 Parameters:(NSDictionary *)parameters
  Successed:(void (^)(id resData))successed
     Failed:(void (^)(NSError *error))failed;

+ (void)POST:(NSString *)urlString
 Parameters:(NSDictionary *)parameters
   Successed:(void (^)(id resData))successed
      Failed:(void (^)(NSError *error))failed;


@end
