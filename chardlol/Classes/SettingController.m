//
//  SettingController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "SettingController.h"
#import <Social/Social.h>
#import <UMMobClick/MobClick.h>
#import "RequestTool.h"
#import <MessageUI/MessageUI.h>
#import "UIAlertView+Blocks.h"
#import "ShareManager.h"
#import "SDImageCache.h"
#import "AdManager.h"

@interface SettingController () <UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) AdManager *adManager;
@property (nonatomic,strong) UIView *adView;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.title = @"设置";
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.adView;
    [self.adManager newNaitveAdWithSuperView:self.adView Controller:self Key:@"1105344611" Pid:@"1080215124193862"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"SettingController"];//("PageOne"为页面名称，可自定义)
    
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"SettingController"];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        lab.text = @"Copyright © 2016 \n\n Chard All rights reserved.";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor lightGrayColor];
        lab.numberOfLines = 0;
//        lab.backgroundColor = [UIColor orangeColor];
        _tableView.tableFooterView = lab;
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@[@"添加评论",
                        @"分享App给好友",@"反馈"],
                        @[@"清理缓存"]];
    }
    return _dataSource;
}

- (UIView *)adView
{
    if (!_adView) {
        CGFloat W = self.view.frame.size.width;
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W, W * 50 / 320)];
        _adView.backgroundColor = [UIColor lightTextColor];
    }
    return _adView;
}

- (AdManager *)adManager
{
    if (!_adManager) {
        _adManager = [[AdManager alloc] init];
    }
    return _adManager;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"settingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
  
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 1 && indexPath.row == 0) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor lightGrayColor];
        lab.text = [self getMemorySize];
        cell.accessoryView = lab;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self goCommentApp];
                [MobClick event:@"appCommentClick"];
                break;
            case 1:
                [self socielShare];
                [MobClick event:@"socielShareClick"];
                break;
            case 2:
                [self punishApp];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                [self clearMemory];
                break;
            default:
                break;
        }
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"分享";
            break;
        case 1:
            return @"其他";
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark - ui_response
- (void)socielShare
{
    [ShareManager shareWithController:self Url:share_link];
}

- (void)goCommentApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:share_link]];
}

- (void)punishApp
{
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mailto://"]];
    if (canOpen) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"英雄联盟通 意见反馈"];
        [controller setMessageBody:@"您好,您的反馈非常重要,我们会认真改进APP" isHTML:NO];
        [controller setToRecipients:@[@"loltv@creativechard.cn"]];
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSString *tip = @"无法打开系统邮箱\n欢迎发送至loltv@creativechard.cn";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:tip delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"复制邮箱", nil];
        [alertView show:^(NSUInteger buttonIndex) {
            if (buttonIndex == 1) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = @"loltv@creativechard.cn";
            }else{
                
            }
        }];
    }
    
}

- (NSString *)getMemorySize
{
    NSInteger cache = [[SDImageCache sharedImageCache] getSize];
    return [NSString stringWithFormat:@"%.2f M",cache/1000.0/1000.0];
}

- (void)clearMemory
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.tableView reloadData];
    }];
    
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
