//
//  CHCollectionCell.h
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface CHCollectionCell : UICollectionViewCell

@property (nonatomic,strong) RecommendModel *model;

@property (nonatomic,weak) UIView *highlightView;

@end
