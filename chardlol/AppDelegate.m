//
//  AppDelegate.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "RequestTool.h"
#import <UMMobClick/MobClick.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString * const VIDEO_CONTROLLER_CLASS_NAME_IOS7 = @"MPInlineVideoFullscreenViewController";
static NSString * const VIDEO_CONTROLLER_CLASS_NAME_IOS8 = @"AVPlayerViewController";

#pragma mark - private
- (void)setMainTabBarViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
}

- (void)setUmeng
{
    UMConfigInstance.appKey = umeng_appkey;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.eSType = E_UM_NORMAL; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

#pragma mark - lifecircle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setMainTabBarViewController];
    
    [self setUmeng];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
