//
//  RecommendCell.h
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

#define gap 10
#define cellHeight [UIScreen mainScreen].bounds.size.width * 9 / 16 + 50

typedef void(^PlayBtnCallBackBlock)(UIButton *);

@interface RecommendCell : UITableViewCell

+ (RecommendCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) RecommendModel *model;

@property (nonatomic,copy) PlayBtnCallBackBlock playBlock;

@property (nonatomic,weak) UILabel *titleLab;
@property (nonatomic,weak) UILabel *descLab;
@property (nonatomic,weak) UIImageView *imgView;
@property (nonatomic,weak) UIButton *playBtn;

@end
