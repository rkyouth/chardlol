//
//  CCellHeadView.m
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CCellHeadView.h"

@interface CCellHeadView()

@end

@implementation CCellHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont systemFontOfSize:18];
        self.titleLab.textColor = [UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1];
        [self addSubview:self.titleLab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(cellgap, 0, self.bounds.size.width - cellgap * 2, self.bounds.size.height);
}

@end
