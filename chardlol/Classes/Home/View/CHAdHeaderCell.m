//
//  CHAdHeaderCell.m
//  chardlol
//
//  Created by Chard on 2016/12/4.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHAdHeaderCell.h"
#import "UIImageView+WebCache.h"
#import "CCellHeadView.h"
#import "AdManager.h"

@interface CHAdHeaderCell()

@property (nonatomic,strong) UIView *adView;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,strong) AdManager *adMgr;

@end

@implementation CHAdHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adView = [[UIView alloc] init];
        self.adView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        [self.contentView addSubview:self.adView];
        
        [self.adMgr newBannerWithContentView:self.contentView Pid:gdt_home_banner];
    }
    return self;
}

- (AdManager *)adMgr
{
    if (!_adMgr) {
        _adMgr = [[AdManager alloc] init];
    }
    return _adMgr;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat adW = 60 * 320 / 50;
    CGFloat adX = (self.contentView.bounds.size.width - adW) * 0.5;
    self.adView.frame = CGRectMake(adX, 0, adW, 60);
    
}

@end
