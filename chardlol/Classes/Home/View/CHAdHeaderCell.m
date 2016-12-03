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

@end

@implementation CHAdHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *adView = [[UIImageView alloc] init];
        [adView sd_setImageWithURL:[NSURL URLWithString:@"https://img3.doubanio.com/view/dale-online/dale_ad/public/94329b1ad3bf566.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.contentView addSubview:adView];
        self.adView = adView;
        
//        UIView *line = [[UIView alloc] init];
////        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        [self.contentView addSubview:line];
//        self.line = line;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat adW = self.contentView.frame.size.width - cellgap * 2;
    self.adView.frame = CGRectMake(cellgap, cellgap, adW, 60);
    
//    CGFloat lineY = CGRectGetMaxY(self.adView.frame) + cellgap;
//    self.line.frame = CGRectMake(cellgap, lineY, adW, 0.5);
}

@end
