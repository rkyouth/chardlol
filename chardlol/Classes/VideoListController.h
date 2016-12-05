//
//  VideoListController.h
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"

typedef enum : NSUInteger {
    CompereVList,
    HeroVList,
} ListType;

@interface VideoListController : UIViewController

@property (nonatomic,assign) ListType listType;

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,strong) HeroModel *hero;

@end
