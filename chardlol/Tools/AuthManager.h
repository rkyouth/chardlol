//
//  AuthManager.h
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AuthManager : NSObject

@property (nonatomic,copy) NSString *authCode;

@property (nonatomic,copy) NSString *accessCode;

+ (AuthManager *)sharedManager;

@end
