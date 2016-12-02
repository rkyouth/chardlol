//
//  CHCollectionCell.m
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface CHCollectionCell()

@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UILabel *titleLab;

@end

@implementation CHCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 3;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.numberOfLines = 0;
        titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgH = self.contentView.frame.size.width * 9 / 16;
    self.imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, imgH);
    
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 5;
    CGFloat titleW = self.contentView.frame.size.width - 20;
    self.titleLab.frame = CGRectMake(0, titleY, titleW, 30);
}

- (void)setModel:(RecommendModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLab.text = model.title;
}

@end
