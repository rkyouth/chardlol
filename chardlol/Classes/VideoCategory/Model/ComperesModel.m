//
//  ComperesModel.m
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "ComperesModel.h"

@implementation ComperesModel

+ (instancetype)comperesWithDic:(NSDictionary *)dic
{
    ComperesModel *model = [[ComperesModel alloc] init];
    model.comId = dic[@"id"];
    model.name = dic[@"name"];
    model.desc = dic[@"description"];
    model.avatar = dic[@"avatar"];
    return model;
}

@end
