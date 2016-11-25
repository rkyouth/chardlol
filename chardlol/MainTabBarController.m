//
//  MainTabBarController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "MainTabBarController.h"
#import "RecommendController.h"
#import "CategoryController.h"
#import "KeepingController.h"
#import "SettingController.h"
#import "RKSwipeBetweenViewControllers.h"
#import "AuthManager.h"
#import "CHWebViewController.h"
#import "RequestTool.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"推荐",@"分类",@"我的"];
    
    for (int i = 0; i < titles.count; i ++) {
        NSString *title = titles[i];
        [self addChildViewControllerWithTitle:title Index:i];
    }
}

- (void)addChildViewControllerWithTitle:(NSString *)title Index:(int)index
{
    UIViewController *vc = nil;
    switch (index) {
        case 0:{
            vc = [[RecommendController alloc] init];
            vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:index];
        }
            break;
        case 1:{
            vc = [[CategoryController alloc] init];
            vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:index];
        }
            break;
        case 2:{
            RKSwipeBetweenViewControllers *nav_down = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
            [nav_down.viewControllerArray addObjectsFromArray:@[[[KeepingController alloc] init],
                                                                 [[KeepingController alloc] init]]];
            nav_down.buttonText = @[@"收藏", @"下载"];
            nav_down.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:index];
            vc = nav_down;
        }
            break;
            
        default:
            break;
    }
    vc.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    vc.title = title;
    if (index != 2) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
         [self addChildViewController:nav];
    }else{
        [self addChildViewController:vc];
    }
    
}

@end
