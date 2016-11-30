//
//  CHCustomCell.m
//  chardlol
//
//  Created by Chard on 2016/11/27.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHCustomCell.h"

@implementation CHCustomCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"customcell";
    CHCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CHCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat wh = self.contentView.frame.size.height - 20;
    self.imageView.frame = CGRectMake(10, 10, wh, wh);
    
    CGRect textRect = self.textLabel.frame;
    textRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.textLabel.frame = textRect;
    
    CGRect detailRect = self.detailTextLabel.frame;
    detailRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.detailTextLabel.frame = detailRect;
    
    self.separatorInset = UIEdgeInsetsMake(0, textRect.origin.x, 0, 0);
}

@end
