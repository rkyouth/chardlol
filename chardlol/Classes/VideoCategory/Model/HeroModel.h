//
//  HeroModel.h
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *avatar;

@property (nonatomic,copy) NSString *en_name;

+ (instancetype)herowithDic:(NSDictionary *)dic;

@end
