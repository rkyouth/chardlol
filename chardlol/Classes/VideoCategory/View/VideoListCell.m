//
//  VideoListCell.m
//  chardlol
//
//  Created by ChardLl on 2016/12/12.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "VideoListCell.h"

@interface VideoListCell()

@end

@implementation VideoListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"customcell";
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[VideoListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        //        self.imageView.layer.cornerRadius = 5;
        //        self.imageView.clipsToBounds = YES;
        
        self.durationLab = [[UILabel alloc] init];
        self.durationLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.durationLab.textColor = [UIColor whiteColor];
        self.durationLab.textAlignment = NSTextAlignmentCenter;
        self.durationLab.font = [UIFont systemFontOfSize:10];
        [self.imageView addSubview:self.durationLab];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat wh = self.contentView.frame.size.height - 20;
    CGFloat imgW = wh + 20;
    self.imageView.frame = CGRectMake(10, 10, imgW, wh);
    
    CGFloat durW = 36;
    CGFloat durH = 20;
    CGFloat durX = self.imageView.frame.size.width - durW - 5;
    CGFloat durY = self.imageView.frame.size.height - durH - 5;
    self.durationLab.frame = CGRectMake(durX, durY, durW, durH);
    
    CGRect textRect = self.textLabel.frame;
    textRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    textRect.size.width = self.contentView.frame.size.width - textRect.origin.x - 10;
    self.textLabel.frame = textRect;
    
    CGRect detailRect = self.detailTextLabel.frame;
    detailRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.detailTextLabel.frame = detailRect;
    
    self.separatorInset = UIEdgeInsetsMake(0, textRect.origin.x, 0, 0);
    
}

@end
