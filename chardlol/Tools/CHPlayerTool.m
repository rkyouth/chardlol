//
//  CHPlayerTool.m
//  chardlol
//
//  Created by Chard on 2016/12/4.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHPlayerTool.h"
#import "AFNetworkReachabilityManager.h"
#import "UIAlertView+Blocks.h"

@implementation CHPlayerTool

+ (void)playWithUrl:(NSURL *)url atController:(UIViewController *)controller
{
    __weak __typeof(self)weakSelf = self;
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            [weakSelf setPlayerWithUrl:url Controller:controller];
        }else{
            NSString *tip = @"您正在使用非Wi-Fi环境\n播放将产生流量费用";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定播放", nil];
            [alertView show:^(NSUInteger buttonIndex) {
                if (buttonIndex == 1) {
                    [weakSelf setPlayerWithUrl:url Controller:controller];
                }
            }];
        }
    }];
    [mgr startMonitoring];
}

+ (void)setPlayerWithUrl:(NSURL *)url Controller:(UIViewController *)controller
{
    //初始化
    AVPlayerViewController  *playerVc = [[AVPlayerViewController alloc]init];
    
    //AVPlayerItem 视频的一些信息  创建AVPlayer使用的
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
    
    //通过AVPlayerItem创建AVPlayer
    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:item];
    [player play];
    
    //给AVPlayer一个播放的layer层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //设置AVPlayer的填充模式
    layer.videoGravity = AVLayerVideoGravityResize;
    
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    playerVc.player = player;
    
    //关闭AVPlayerViewController内部的约束
    playerVc.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [controller presentViewController:playerVc animated:YES completion:nil];
}

@end
