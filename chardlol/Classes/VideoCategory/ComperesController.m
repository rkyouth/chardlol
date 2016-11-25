//
//  ComperesController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/24.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "ComperesController.h"
#import "RequestTool.h"

@interface ComperesController ()

@end

@implementation ComperesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

- (void)loadData
{
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"user_names":@"SilenceOB,Misaya若风"};
    [RequestTool POST:yk_users Parameters:params Successed:^(id resData) {
        
        NSLog(@"data : %@",resData);
        
    } Failed:^(NSError *error) {
        
    }];
}


@end
