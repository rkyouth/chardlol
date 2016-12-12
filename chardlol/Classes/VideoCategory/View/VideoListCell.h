//
//  VideoListCell.h
//  chardlol
//
//  Created by ChardLl on 2016/12/12.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picView;

@property (nonatomic,strong) UILabel *durationLab;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
