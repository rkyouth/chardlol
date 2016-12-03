//
//  CHCollectionCell.m
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHCollectionCell.h"
#import "UIImageView+WebCache.h"

#define UILABEL_LINE_SPACE 1.5
#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height

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
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.numberOfLines = 0;
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
        UIView *highlightView = [[UIView alloc] init];
        highlightView.hidden = YES;
        highlightView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        highlightView.layer.cornerRadius = 3;
        highlightView.clipsToBounds = YES;
        [self.contentView addSubview:highlightView];
        self.highlightView = highlightView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgH = self.contentView.frame.size.width * 9 / 16 + 10;
    self.imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, imgH);
    
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 5;
    CGFloat titleW = self.contentView.frame.size.width - 20;
    self.titleLab.frame = CGRectMake(0, titleY, titleW, 35);
    
    self.highlightView.frame = self.imageView.bounds;
}

- (void)setModel:(RecommendModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self setLabelSpace:self.titleLab withValue:model.title withFont:[UIFont systemFontOfSize:12]];
}

- (void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

@end
