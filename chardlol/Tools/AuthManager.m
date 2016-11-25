//
//  AuthManager.m
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "AuthManager.h"

@implementation AuthManager

+ (AuthManager *)sharedManager {
    static AuthManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

@end
