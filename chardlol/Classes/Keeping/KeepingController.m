//
//  KeepingController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "KeepingController.h"
#import "SettingController.h"
#import "RequestTool.h"
#import "CHCustomCell.h"
#import "StrategyModel.h"
#import "UIImageView+WebCache.h"
#import "CHWebViewController.h"

@interface KeepingController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) int page;
@property (nonatomic,assign) BOOL nextPage;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;


@end

@implementation KeepingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [self settingsBarButtonItem];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.refreshControl;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [self loadData];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat H = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, H);
    
    self.indicatorView.center = self.tableView.center;
}

- (void)loadData
{
//    ?id=10&page=0&plat=ios&version=33
    self.page = 0;
    NSDictionary *params = @{@"id":@"10",
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"plat":@"ios",
                             @"version":@"33"};
    [RequestTool GET:strategy_list Parameters:params Successed:^(NSDictionary *resData) {
        
        NSString *next = resData[@"next"];
        if ([next isEqualToString:@"True"]) {
            self.nextPage = YES;
        }else{
            self.nextPage = NO;
        }
        
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in resData[@"list"]) {
            StrategyModel *strategy = [StrategyModel strategyWithDic:dic];
            [self.dataSource addObject:strategy];
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
        
    } Failed:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
    }];
}

- (void)loadMoreData
{
    NSDictionary *params = @{@"id":@"10",
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"plat":@"ios",
                             @"version":@"33"};
    [RequestTool GET:strategy_list Parameters:params Successed:^(NSDictionary *resData) {
        
        NSString *next = resData[@"next"];
        if ([next isEqualToString:@"True"]) {
            self.nextPage = YES;
        }else{
            self.nextPage = NO;
        }
        
        for (NSDictionary *dic in resData[@"list"]) {
            StrategyModel *strategy = [StrategyModel strategyWithDic:dic];
            [self.dataSource addObject:strategy];
        }
        [self.tableView reloadData];
        
    } Failed:^(NSError *error) {
        
    }];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
//        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.rowHeight = 80;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIBarButtonItem *)settingsBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(didTapSettingsButton:)];
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.color = [UIColor grayColor];
    }
    return _indicatorView;
}

#pragma mark - ui_response
- (void)didTapSettingsButton:(UIBarButtonItem *)item
{
    NSLog(@"...");
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[SettingController alloc] init]];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)refreshAction
{
    [self loadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCustomCell *cell = [CHCustomCell cellWithTableView:tableView];
    StrategyModel *model = self.dataSource[indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.summary;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_small] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StrategyModel *model = self.dataSource[indexPath.row];
    CHWebViewController *webVc = [[CHWebViewController alloc] init];
    webVc.requesUrl = model.article_url;
    webVc.title = model.title;
    webVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    CGFloat maximumOffset = size.height;
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
    if(currentOffset == maximumOffset)
    {
        if (self.nextPage) {
            self.page ++;
            [self loadMoreData];
        }
    }
}

@end
