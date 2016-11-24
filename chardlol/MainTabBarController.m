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

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *titles = @[@"推荐",@"分类",@"我的",@"设置"];
    
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
            vc = [[KeepingController alloc] init];
            vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:index];
        }
            break;
        case 3:{
            vc = [[SettingController alloc] init];
            vc.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:index];
        }
            break;
            
        default:
            break;
    }
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
