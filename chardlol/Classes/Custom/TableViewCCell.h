//
//  TableViewCCell.h
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tableCCellClick)(NSInteger);

@interface TableViewCCell : UICollectionViewCell

@property (nonatomic,copy) tableCCellClick cCellClick;

@end
