//
//  ComperesModel.h
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComperesModel : NSObject

+ (instancetype)comperesWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *comId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *desc;

@end
