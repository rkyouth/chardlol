//
//  CHPlayerTool.h
//  chardlol
//
//  Created by Chard on 2016/12/4.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface CHPlayerTool : NSObject

+ (void)playWithUrl:(NSURL *)url atController:(UIViewController *)controller;

@end
