//
//  ShareManager.m
//  chardlol
//
//  Created by Chard on 2016/12/10.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager

+ (void)shareWithController:(UIViewController *)controller Url:(NSString *)url
{
    NSString *title = @"下载Luer,观看更多英雄联盟视频,攻略。";
    UIImage *img = [UIImage imageNamed:@"60"];
    NSURL *link = [NSURL URLWithString:url];
    NSArray *items = @[link,title,img];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAirDrop];
    
    [controller presentViewController:activityVC animated:YES completion:nil];
}

@end
