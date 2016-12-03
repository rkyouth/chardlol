//
//  VideoListController.h
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CompereVList,
    HeroVList,
} ListType;

@interface VideoListController : UIViewController

@property (nonatomic,assign) ListType listType;

@property (nonatomic,copy) NSString *userId;

@end
