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
#import "GDTNativeAd.h"

@interface AdManager() <GDTNativeAdDelegate,GDTMobBannerViewDelegate>

@property (nonatomic,strong) UIView *superView;

// native
@property (nonatomic,strong) GDTNativeAd *nativeAd;
@property (nonatomic,strong) GDTNativeAdData *nativeData;

// banner
@property (nonatomic,strong) GDTMobBannerView *banner;

@end

@implementation AdManager

#pragma mark - 打底
- (void)setNormalAdWithSuperView:(UIView *)superView
{
    UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,superView.frame.size.width,superView.frame.size.height)];
    [adView sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/005GC2Nwgw1fai7vd8m09j312c06otao.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    adView.layer.cornerRadius = 3.0;
    adView.clipsToBounds = YES;
    adView.userInteractionEnabled = YES;
    [adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd:)]];
    [superView addSubview:adView];
    
    
    CGFloat choiceX = adView.frame.size.width - 30;
    CGFloat choiceY = adView.frame.size.height - 21;
    UILabel *choiceView = [[UILabel alloc] initWithFrame:CGRectMake(choiceX, choiceY, 25, 16)];
    choiceView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    choiceView.textColor = [UIColor whiteColor];
    choiceView.text = @"广告";
    choiceView.font = [UIFont systemFontOfSize:10];
    choiceView.textAlignment = NSTextAlignmentCenter;
    [adView addSubview:choiceView];
    
    CGFloat lineW = superView.frame.size.width;
    CGFloat lineY = superView.frame.size.height - 0.5;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, lineW, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [superView addSubview:line];
}

- (void)tapAd:(UITapGestureRecognizer *)ges
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jennixlove.com"]];
}

#pragma mark - native
- (void)newNaitveAdWithSuperView:(UIView *)superView
                      Controller:(UIViewController *)controller
                             Key:(NSString *)key
                             Pid:(NSString *)pid
{
    _superView = superView;
    
    self.nativeAd = [[GDTNativeAd alloc] initWithAppkey:key placementId:pid];
    self.nativeAd.controller = controller;
    self.nativeAd.delegate = self;
    [self.nativeAd loadAd:8];
}

- (void)viewTapped:(UITapGestureRecognizer *)ges
{
    [self.nativeAd clickAd:_nativeData];
}

// GDTNativeAdDelegate
/**
 *  原生广告加载广告数据成功回调，返回为GDTNativeAdData对象的数组
 */
- (void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray
{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        _nativeData = nativeAdDataArray[arc4random() % 8];
        NSString *iconUrl = _nativeData.properties[GDTNativeAdDataKeyIconUrl];
        NSString *titleText = _nativeData.properties[GDTNativeAdDataKeyTitle];
        NSString *descText = _nativeData.properties[GDTNativeAdDataKeyDesc];
        
        CGFloat iconWH = weakSelf.superView.frame.size.height;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconWH, iconWH)];
        [icon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [weakSelf.superView addSubview:icon];
        
        CGFloat titleX = CGRectGetMaxX(icon.frame) + 10;
        CGFloat titleY = weakSelf.superView.frame.size.height * 0.5 - 20;
        CGFloat titleW = weakSelf.superView.frame.size.width - titleX - 10;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, 20)];
        title.font = [UIFont systemFontOfSize:15];
        title.text = titleText;
        [weakSelf.superView addSubview:title];
        
        CGFloat desY = CGRectGetMaxY(title.frame);
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(titleX, desY, titleW, 20)];
        desc.font = [UIFont systemFontOfSize:13];
        desc.textColor = [UIColor lightGrayColor];
        desc.text = descText;
        [weakSelf.superView addSubview:desc];
        
        CGFloat choiceX = weakSelf.superView.frame.size.width - 30;
        CGFloat choiceY = weakSelf.superView.frame.size.height - 21;
        UILabel *choiceView = [[UILabel alloc] initWithFrame:CGRectMake(choiceX, choiceY, 25, 16)];
        choiceView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        choiceView.textColor = [UIColor whiteColor];
        choiceView.text = @"广告";
        choiceView.font = [UIFont systemFontOfSize:10];
        choiceView.textAlignment = NSTextAlignmentCenter;
        [weakSelf.superView addSubview:choiceView];
        
        CGFloat lineW = weakSelf.superView.frame.size.width;
        CGFloat lineY = weakSelf.superView.frame.size.height - 0.5;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, lineW, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [weakSelf.superView addSubview:line];
        
        [weakSelf.nativeAd attachAd:_nativeData toView:weakSelf.superView];
        
        /*注册点击事件*/
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [weakSelf.superView addGestureRecognizer:tap];
    });
}

/**
 *  原生广告加载广告数据失败回调
 */
- (void)nativeAdFailToLoad:(NSError *)error
{
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setNormalAdWithSuperView:self.superView];
    });
    
}

#pragma mark - banner
- (void)newBannerWithContentView:(UIView *)contentView Pid:(NSString *)pid
{
    _superView = contentView;
    
    CGRect rect = CGRectMake(0, 0, GDTMOB_AD_SUGGEST_SIZE_320x50.width, GDTMOB_AD_SUGGEST_SIZE_320x50.height);
    self.banner = [[GDTMobBannerView alloc] initWithFrame:rect appkey:gdt_adkey placementId:pid];
    self.banner.center = contentView.center;
    self.banner.delegate = self;
    self.banner.currentViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    self.banner.isAnimationOn = YES;
    self.banner.showCloseBtn = NO;
    self.banner.isGpsOn = YES;
    [contentView addSubview:self.banner];
    
    [self.banner loadAdAndShow];
}

- (void)bannerViewFailToReceived:(NSError *)error
{
    [self setNormalAdWithSuperView:_superView];
}

@end
