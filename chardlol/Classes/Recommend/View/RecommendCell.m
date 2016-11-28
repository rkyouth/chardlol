//
//  RecommendCell.m
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "RecommendCell.h"
#import "UIImageView+WebCache.h"

@interface RecommendCell()


@end

@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (RecommendCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"recommendcell";
    RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.tag = 101;
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont systemFontOfSize:15];
        titleLab.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *descLab = [[UILabel alloc] init];
        [self.contentView addSubview:descLab];
        self.descLab = descLab;
        
        UIButton *playBtn = [[UIButton alloc] init];
        [playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgView addSubview:playBtn];
        self.playBtn = playBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleW = self.contentView.bounds.size.width - gap * 2;
    self.titleLab.frame = CGRectMake(gap, gap, titleW, 30);
    
    CGFloat imgY = CGRectGetMaxY(self.titleLab.frame) + gap;
    CGFloat imgW = self.contentView.frame.size.width;
    CGFloat imgH = [UIScreen mainScreen].bounds.size.width * 9 / 16;
    self.imgView.frame = CGRectMake(0, imgY, imgW, imgH);
    
    CGFloat btnX = (self.imgView.frame.size.width - 50) * 0.5;
    CGFloat btnY = (self.imgView.frame.size.height - 50) * 0.5;
    self.playBtn.frame = CGRectMake(btnX, btnY, 50, 50);
}

- (void)setModel:(RecommendModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLab.text = model.title;
}

- (void)play:(UIButton *)sender {
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

@end
