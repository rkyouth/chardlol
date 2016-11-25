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
#import "AuthManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - private
- (void)setMainTabBarViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
}

- (void)setAccessToken
{
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"response_type":@"code",
                             @"redirect_uri":@"http://www.youku.com"};
    [RequestTool GET:authorize_url Parameters:params Successed:^(id resData) {

        NSDictionary *accessParams = @{@"client_id":yk_clientid,
                                       @"client_secret":yk_secretid,
                                       @"grant_type":@"authorization_code",
                                       @"code":resData,
                                       @"redirect_uri":@"http://www.youku.com"};
        [RequestTool POST:accestoken_url Parameters:accessParams Successed:^(NSDictionary *resData) {
            [AuthManager sharedManager].accessCode = resData[@"access_token"];
            
            [self setMainTabBarViewController];
            
        } Failed:^(NSError *error) {}];
        
    } Failed:^(NSError *error) {
    
    }];
}

#pragma mark - lifecircle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setAccessToken];
    
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
