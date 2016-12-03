//
//  VideoModel.m
//  chardlol
//
//  Created by Chard on 2016/12/3.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (instancetype)videoWithDic:(NSDictionary *)dic
{
    VideoModel *model = [[VideoModel alloc] init];
    model.videoId = dic[@"id"];
    model.title = dic[@"title"];
    model.link = [NSString stringWithFormat:@"http://pl.youku.com/playlist/m3u8?vid=%@&ts=1480098062.0&ctype=12&token=3739&keyframe=1&sid=848009806257712f776e6&ev=1&type=hd2&ep=eiacGkmEXs4G5ybYjz8bMSvlciIJXJZ3kkjP%%2FJgxAcVQIa%%2FB6DPcqJ63TfY%%3D&oip=2067476272",model.videoId];
    model.thumbnail = dic[@"thumbnail"];
    model.published = dic[@"published"];
    
    return model;
}

@end
