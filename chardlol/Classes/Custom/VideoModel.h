//
//  VideoModel.h
//  chardlol
//
//  Created by Chard on 2016/12/3.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic,copy) NSString *videoId;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *link;

@property (nonatomic,copy) NSString *thumbnail;

@property (nonatomic,copy) NSString *published;

+ (instancetype)videoWithDic:(NSDictionary *)dic;

@end
