//
//  VideoListController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "VideoListController.h"
#import "VideoListCell.h"
#import "RequestTool.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import "CHPlayerTool.h"
#import <UMMobClick/MobClick.h>
#import "AdManager.h"

@interface VideoListController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) int page;
@property (nonatomic,assign) BOOL nextPage;
@property (nonatomic,assign) int total;
@property (nonatomic,assign) BOOL isLoadMore;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) AdManager *adMgr;
@property (nonatomic,strong) UIView *adView;

@end

@implementation VideoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"视频列表";
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.refreshControl];
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    self.page = 1;
    switch (_listType) {
        case CompereVList:
            [self loadCompereData];
            break;
        case HeroVList:
            [self loadHeroData];
            break;
        default:
            break;
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"VideoListPage"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"VideoListPage"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    self.indicatorView.center = self.tableView.center;
}

- (void)loadCompereData
{
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"user_id":self.userId,
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"count":@"6"};
    [RequestTool GET:yk_uservideos Parameters:params Successed:^(NSDictionary *resData) {
        
        self.total = [resData[@"total"] intValue];
        
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in resData[@"videos"]) {
            VideoModel *vd = [VideoModel videoWithDic:dic];
            [self.dataSource addObject:vd];
        }
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
        
        self.isLoadMore = NO;
        
    } Failed:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
    }];
}

- (void)loadHeroData
{
    
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"keyword":[NSString stringWithFormat:@"%@,%@",self.hero.name,self.hero.nickName],
                             @"period":@"history",
                             @"orderby":@"published",
                             @"category":@"游戏",
                             @"streamtypes":@"1,2,3,4,5,6",
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"count":@"8"};
    [RequestTool GET:yk_videosearch Parameters:params Successed:^(NSDictionary *resData) {
        
        self.total = [resData[@"total"] intValue];
        
        if (self.page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in resData[@"videos"]) {
            VideoModel *vd = [VideoModel videoWithDic:dic];
            [self.dataSource addObject:vd];
        }
        [self.tableView reloadData];
        
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
        
        self.isLoadMore = NO;
        
    } Failed:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [self.indicatorView stopAnimating];
    }];
}

#pragma mark - ui_response
- (void)refreshAction
{
    self.page = 1;
    switch (self.listType) {
        case CompereVList:
            [self loadCompereData];
            break;
        case HeroVList:
            [self loadHeroData];
            break;
        default:
            break;
    }
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 100;
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
    VideoListCell *cell = [VideoListCell cellWithTableView:tableView];
    VideoModel *model = self.dataSource[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.published;
    
    int min = [model.duration intValue] / 60;
    int sec = [model.duration intValue] % 60;
    cell.durationLab.text = [NSString stringWithFormat:@"%02d:%02d",min,sec];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VideoModel *model = self.dataSource[indexPath.row];
    [CHPlayerTool playWithUrl:[NSURL URLWithString:model.link] atController:self];
    [MobClick event:@"videoListClick"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_adView) {
        [self.adMgr newBannerWithContentView:self.adView Pid:gdt_videolist_banner];
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
            self.page ++;
            
            int page_forward = self.total / 10;
            if (self.page > page_forward + 1) {
                return;
            }
        
        self.isLoadMore = YES;
            switch (self.listType) {
                case CompereVList:
                    [self loadCompereData];
                    break;
                case HeroVList:
                    [self loadHeroData];
                    break;
                default:
                    break;
            }
    }
}

@end
