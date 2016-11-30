//
//  StrategyModel.m
//  chardlol
//
//  Created by ChardLl on 2016/11/30.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "StrategyModel.h"
#import "RequestTool.h"

@implementation StrategyModel

+ (instancetype)strategyWithDic:(NSDictionary *)dic
{
    StrategyModel *model = [[StrategyModel alloc] init];
    model.title = dic[@"title"];
    model.image_url_small = dic[@"image_url_small"];
    model.summary = dic[@"summary"];
    model.targetid = dic[@"targetid"];
    NSString *article_url = dic[@"article_url"];
    if(![article_url hasPrefix:@"http://"]){ //不是视频链接 拼接 url
        article_url = [newsUrlPath stringByAppendingString:article_url];
    }
    model.article_url = article_url;
    
    return model;
}

@end
