//
//  UIImage+chard.m
//  chardlol
//
//  Created by ChardLl on 2016/12/12.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "UIImage+chard.h"

@implementation UIImage (chard)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
