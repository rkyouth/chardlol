//
//  AdManager.h
//  chardlol
//
//  Created by ChardLl on 2016/11/30.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define gdt_adkey @"1105876246"

#define gdt_home_banner @"8070210785077458"
#define gdt_host_banner @"6010110735372439"
#define gdt_videolist_banner @"5030814715372550"
#define gdt_guide_banner @"6070119735979531"
#define gdt_setting_banner @"3050313765670522"

@interface AdManager : NSObject

- (void)newNaitveAdWithSuperView:(UIView *)superView
                      Controller:(UIViewController *)controller
                             Key:(NSString *)key
                             Pid:(NSString *)pid;

- (void)newBannerWithContentView:(UIView *)contentView Pid:(NSString *)pid;

@end
