//
//  MatchModel.m
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "MatchModel.h"

@implementation MatchModel

+ (instancetype)matchWithDic:(NSDictionary *)dic
{
    MatchModel *model = [[MatchModel alloc] init];
    model.gameLogo = dic[@"GameLogo"];
    model.gameThumb = dic[@"GameThumb"];
    model.bGameId = dic[@"bGameId"];
    model.sGameId = dic[@"sGameId"];
    model.bGameName = dic[@"bGameName"];
    model.sGameName = dic[@"sGameName"];
    model.gameDataUrl = dic[@"gameDataUrl"];
    
    return model;
}

@end
