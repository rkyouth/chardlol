//
//  CDPlayerViewController.m
//  chardlol
//
//  Created by ChardLl on 2016/12/15.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CDPlayerViewController.h"

@interface CDPlayerViewController ()

@end

@implementation CDPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (BOOL)shouldAutorotate
{
    return YES;
}

//支持左右旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
}

//默认为右旋转
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

@end
