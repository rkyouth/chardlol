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

@interface CHAdHeaderCell()

@property (nonatomic,weak) UIImageView *adView;

@property (nonatomic,weak) UIView *line;

@property (nonatomic,weak) UILabel *choiceView;

@end

@implementation CHAdHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *adView = [[UIImageView alloc] init];
        [adView sd_setImageWithURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/mw690/005GC2Nwgw1fai7vd8m09j312c06otao.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        adView.layer.cornerRadius = 3.0;
        adView.clipsToBounds = YES;
        adView.userInteractionEnabled = YES;
        [adView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd:)]];
        [self.contentView addSubview:adView];
        self.adView = adView;
        
//        UIView *line = [[UIView alloc] init];
////        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        [self.contentView addSubview:line];
//        self.line = line;
        
        UILabel *choiceView = [[UILabel alloc] init];
        choiceView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        choiceView.textColor = [UIColor whiteColor];
        choiceView.text = @"广告";
        choiceView.font = [UIFont systemFontOfSize:12];
        choiceView.textAlignment = NSTextAlignmentCenter;
        [self.adView addSubview:choiceView];
        self.choiceView = choiceView;
    }
    return self;
}

- (void)tapAd:(UITapGestureRecognizer *)ges
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jennixlove.com"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat adW = self.contentView.frame.size.width - cellgap * 2;
    self.adView.frame = CGRectMake(cellgap, cellgap, adW, 60);
    
//    CGFloat lineY = CGRectGetMaxY(self.adView.frame) + cellgap;
//    self.line.frame = CGRectMake(cellgap, lineY, adW, 0.5);
    
    CGFloat choiceX = self.adView.frame.size.width - 30;
    CGFloat choiceY = self.adView.frame.size.height - 18;
    self.choiceView.frame = CGRectMake(choiceX, choiceY, 30, 20);
}

@end
