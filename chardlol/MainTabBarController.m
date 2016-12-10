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
#import "CHWebViewController.h"
#import "RequestTool.h"
#import "HomeViewController.h"
#import <UMMobClick/MobClick.h>

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"推 荐",@"攻 略",@"设 置"];
    
    for (int i = 0; i < titles.count; i ++) {
        NSString *title = titles[i];
        [self addChildViewControllerWithTitle:title Index:i];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"TabbarController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"TabbarController"];
}

- (void)addChildViewControllerWithTitle:(NSString *)title Index:(int)index
{
    UIViewController *vc = nil;
    switch (index) {
        case 0:{
            vc = [[HomeViewController alloc] init];
            vc.tabBarItem.image = [UIImage imageNamed:@"tabbar_recommend"];
            vc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_recommend_selected"];
        }
            break;
        case 1:{
            vc = [[KeepingController alloc] init];
            vc.tabBarItem.image = [UIImage imageNamed:@"tabbar_collect"];
            vc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_collect_selected"];
            
        }
            break;
        case 2:{
//            RKSwipeBetweenViewControllers *nav_down = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
//            [nav_down.viewControllerArray addObjectsFromArray:@[[[KeepingController alloc] init],
//                                                                 [[ZFDownloadViewController alloc] init]]];
//            nav_down.buttonText = @[@"收藏", @"下载"];
//            nav_down.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:index];
//            vc = nav_down;
//            vc = [[CategoryController alloc] init];
//            vc.tabBarItem.image = [UIImage imageNamed:@"tabbar_find"];
//            vc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_find_selected"];
            vc = [[SettingController alloc] init];
            vc.tabBarItem.image = [UIImage imageNamed:@"tabbar_find"];
            vc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_find_selected"];
        }
            break;
            
        default:
            break;
    }
//    vc.view.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    vc.title = title;
//    self.tabBar.tintColor = [UIColor colorWithRed:216/255.0 green:30/255.0 blue:6/255.0 alpha:1];
    self.tabBar.tintColor = self.view.tintColor;
//    if (index != 2) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    nav.navigationBar.translucent = NO;
        [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:0.1]}];
         [self addChildViewController:nav];
//    }else{
//        [self addChildViewController:vc];
//    }
    
}

@end
