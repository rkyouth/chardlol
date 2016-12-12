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
#import <UMMobClick/MobClick.h>
#import "AdManager.h"
#import "UIImage+chard.h"

@interface KeepingController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) int page;
@property (nonatomic,assign) BOOL nextPage;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) AdManager *adMgr;
@property (nonatomic,strong) UIView *adView;

@end

@implementation KeepingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [self loadData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"KeepController"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"KeepController"];
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
        
        self.isLoadMore = NO;
        
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
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
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

- (UIView *)adView
{
    if (!_adView) {
        CGFloat W = self.view.frame.size.width;
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W, W * 50 / 320)];
        _adView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        CGFloat lineY = _adView.frame.size.height - 0.5;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, _adView.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [_adView addSubview:line];
    }
    return _adView;
}

- (AdManager *)adMgr
{
    if (!_adMgr) {
        _adMgr = [[AdManager alloc] init];
    }
    return _adMgr;
}

#pragma mark - ui_response
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_adView) {
        [self.adMgr newBannerWithContentView:self.adView Pid:gdt_guide_banner];
    }
    return self.adView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.frame.size.width * 50 / 320;
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
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。
    if((int)currentOffset == (int)maximumOffset && self.isLoadMore == NO)
    {
        if (self.nextPage) {
            self.isLoadMore = YES;
            self.page ++;
            [self loadMoreData];
        }
    }
}

@end
