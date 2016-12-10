//
//  AdManager.h
//  chardlol
//
//  Created by ChardLl on 2016/11/30.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdManager : NSObject

+ (AdManager *)sharedManager;

+ (void)setNormalAdWithSuperView:(UIView *)superView;

@end
