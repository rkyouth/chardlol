//
//  StrategyModel.h
//  chardlol
//
//  Created by ChardLl on 2016/11/30.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrategyModel : NSObject

+ (instancetype)strategyWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image_url_small;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *targetid;
@property (nonatomic,copy) NSString *article_url;

@end
