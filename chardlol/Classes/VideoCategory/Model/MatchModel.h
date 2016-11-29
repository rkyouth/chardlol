//
//  MatchModel.h
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 GameLogo = "http://shp.qpic.cn/lolwebvideo/201501/8d492caaad431a02ff09aeb86e109af4/0";
 GameStatus = 0;
 GameThumb = "http://shp.qpic.cn/lolwebvideo/201501/0607839d295005fe379f69709d0ed998/0";
 bGameId = 6;
 bGameName = "\U5168\U660e\U661f\U8d5b";
 eDate = "2016-12-11";
 functions = "<null>";
 gameDataUrl = "http://lol.qq.com/m/act/a20151231match/game_data.shtml?sgid=47";
 sDate = "2016-12-08";
 sGameId = 47;
 sGameName = "2016\U5168\U660e\U661f\U8d5b";
 videoNum = 0;
 */
@interface MatchModel : NSObject

+ (instancetype)matchWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *gameLogo;
@property (nonatomic,copy) NSString *gameThumb;
@property (nonatomic,copy) NSString *bGameName;
@property (nonatomic,copy) NSString *sGameName;
@property (nonatomic,copy) NSString *gameDataUrl;
@property (nonatomic,copy) NSString *bGameId;
@property (nonatomic,copy) NSString *sGameId;



@end
