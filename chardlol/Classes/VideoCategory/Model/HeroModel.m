//
//  HeroModel.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "HeroModel.h"
#import "RequestTool.h"

@implementation HeroModel

+ (instancetype)herowithDic:(NSDictionary *)dic
{
    HeroModel *model = [[HeroModel alloc] init];
    model.name = dic[@"name"];
    model.en_name = dic[@"en_name"];
    model.avatar = [NSString stringWithFormat:@"%@%@.png",hero_icon,model.en_name];
    model.nickName = dic[@"nick"];
    
    return model;
}

@end
