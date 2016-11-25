//
//  RecommendController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "RecommendController.h"
#import "RecommendCell.h"
#import "RequestTool.h"
#import "AuthManager.h"

@interface RecommendController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [self settingsBarButtonItem];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (UIBarButtonItem *)settingsBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(didTapSettingsButton:)];
}

#pragma mark - private
- (void)loadData
{
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"access_token":[AuthManager sharedManager].accessCode,
                             @"orderby":@"",
                             @"page":@"",
                             @"count":@""};
    [RequestTool GET:recommend_list Parameters:params Successed:^(NSDictionary *resData) {
        NSLog(@"recommend : %@",resData);
    } Failed:^(NSError *error) {}];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"..",@".."]];
    }
    return _dataSource;
}

#pragma mark - ui_response
- (void)didTapSettingsButton:(UIBarButtonItem *)item
{
    NSLog(@"...");
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendCell *cell = [RecommendCell cellWithTableView:tableView];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

@end
