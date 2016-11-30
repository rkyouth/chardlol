//
//  CHCustomCell.h
//  chardlol
//
//  Created by Chard on 2016/11/27.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCustomCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
