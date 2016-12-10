//
//  AdManager.m
//  chardlol
//
//  Created by ChardLl on 2016/11/30.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "AdManager.h"
#import "GDTSplashAd.h"
#import "GDTMobBannerView.h"
#import "UIImageView+WebCache.h"

@interface AdManager() 

@end

@implementation AdManager

static id shared_manager;

+ (AdManager *)sharedManager
{
    static AdManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

#pragma mark - 打底
+ (void)setNormalAdWithSuperView:(UIView *)superView
{
    UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,superView.frame.size.width - 20,superView.frame.size.height - 20)];
    [adView sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/005GC2Nwgw1fai7vd8m09j312c06otao.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    adView.layer.cornerRadius = 3.0;
    adView.clipsToBounds = YES;
    adView.userInteractionEnabled = YES;
    [adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd:)]];
    [superView addSubview:adView];
}

+ (void)tapAd:(UITapGestureRecognizer *)ges
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jennixlove.com"]];
}

#pragma mark - banner
- (void)getBannerWithContentView:(UIView *)contentView
{
    
}


#pragma mark - SplashAd


@end
