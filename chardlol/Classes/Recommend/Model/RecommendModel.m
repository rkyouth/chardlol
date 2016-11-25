//
//  RecommendModel.m
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "RecommendModel.h"


/*
 "id" : "XMjg1MTcyNDQ0",
 "title" : "泡芙小姐的灯泡 11",
 "link" : "http://v.youku.com/v_show/id_XMjg1MTcyNDQ0.html",
 "thumbnail" : "http://g4.ykimg.com/0100641F464E1FC...",
 "duration" : "910",
 "state" : "normal",
 "view_count" : 2555843,
 "favorite_count" : 534,
 "comment_count" : 10,
 "up_count" : 14859,
 "down_count" : 559,
 "published" : "2011-07-15 09:00:42",
 "user" :
 {
 "id" : 58921428,
 "name" : "泡芙小姐",
 "link" : "http://u.youku.com/user_show/id_UMjM1Njg1NzEy.html"
 },
 "operation_limit": ["COMMENT_DISABLED"],
 "streamtypes" : ["flv","flvhd","hd"],
 "seq_no" : 1
 */
@implementation RecommendModel

+ (instancetype)recommendWithDic:(NSDictionary *)dic
{
    RecommendModel *model = [[RecommendModel alloc] init];
    model.videoId = dic[@"id"];
    model.title = dic[@"title"];
    model.link = [NSString stringWithFormat:@"http://pl.youku.com/playlist/m3u8?vid=%@&ts=1480098062.0&ctype=12&token=3739&keyframe=1&sid=848009806257712f776e6&ev=1&type=hd2&ep=eiacGkmEXs4G5ybYjz8bMSvlciIJXJZ3kkjP%%2FJgxAcVQIa%%2FB6DPcqJ63TfY%%3D&oip=2067476272",model.videoId];
    model.thumbnail = dic[@"thumbnail"];
    model.published = dic[@"published"];
    
    return model;
}

@end
