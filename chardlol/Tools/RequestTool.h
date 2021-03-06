//
//  RequestTool.h
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CACHE_FOLDER [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define hero_list @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/hero_list.js"
#define hero_package @"http://ossweb-img.qq.com/upload/qqtalk/lol_hero/package_info.js"
#define hero_icon @"http://down.qq.com/qqtalk/lolApp/img/champion/"

// 优酷接口
#define yk_clientid @"92927d657412b8f8"
#define yk_secretid @"444f27bd42fbf358d15b129315bb631b"
#define yk_playlistid @"28731667"
#define yk_feixiongid @"812557199"
#define authorize_url @"https://openapi.youku.com/v2/oauth2/authorize"
#define accestoken_url @"https://openapi.youku.com/v2/oauth2/token"
#define yk_playurl @"http://pl.youku.com/playlist/m3u8?vid=%@&ts=1480098062.0&ctype=12&token=3739&keyframe=1&sid=848009806257712f776e6&ev=1&type=hd2&ep=eiacGkmEXs4G5ybYjz8bMSvlciIJXJZ3kkjP%2FJgxAcVQIa%2FB6DPcqJ63TfY%3D&oip=2067476272"

#define yk_users @"https://openapi.youku.com/v2/users/show_batch.json"
#define yk_uservideos @"https://openapi.youku.com/v2/videos/by_user.json"
#define recommend_list @"https://openapi.youku.com/v2/playlists/videos.json"
#define match_list @"http://apps.game.qq.com/lol/match/app_apis/searchSGameList.php?a1=qtapp&a2=1480405711&a3=72a91959a23e77bdbfa899e71dadcb6e"
#define strategy_list @"http://qt.qq.com/php_cgi/news/php/varcache_getnews.php"
#define newsUrlPath   @"http://qt.qq.com/static/pages/news/phone/"
#define yk_uservideos @"https://openapi.youku.com/v2/videos/by_user.json"
#define yk_videosearch @"https://openapi.youku.com/v2/searches/video/by_keyword.json"

#define umeng_appkey @"5844ddbb1061d2040d000a64"
#define share_link @"https://itunes.apple.com/cn/app/luer/id1182433375?mt=8"


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
