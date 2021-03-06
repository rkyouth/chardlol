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
#import "RecommendModel.h"
#import "UIImageView+WebCache.h"
#import "SettingController.h"

@interface RecommendController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) int page;
@property (nonatomic,assign) int total;

@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) UIView *adView;
@end

@implementation RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.refreshControl;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    self.navigationItem.rightBarButtonItem = [self settingsBarButtonItem];
    
    [self loadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat H = self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, H);
//    self.tableView.frame = self.view.bounds;
    
    self.indicatorView.center = self.tableView.center;
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
    self.page = 1;
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"user_id":yk_feixiongid,
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"count":@"10"
                             };
    [RequestTool GET:yk_uservideos Parameters:params Successed:^(NSDictionary *resData) {

        self.total = [resData[@"total"] intValue];
        
        [self.dataSource removeAllObjects];
        
        NSArray *videos = resData[@"videos"];
        for (NSDictionary *dic in videos) {
            RecommendModel *model = [RecommendModel recommendWithDic:dic];
            [self.dataSource addObject:model];
            
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
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"user_id":yk_feixiongid,
                             @"page":[NSString stringWithFormat:@"%d",self.page],
                             @"count":@"10"
                             };
    [RequestTool GET:yk_uservideos Parameters:params Successed:^(NSDictionary *resData) {
        
        self.page = [resData[@"page"] intValue];
        
        NSArray *videos = resData[@"videos"];
        for (NSDictionary *dic in videos) {
            RecommendModel *model = [RecommendModel recommendWithDic:dic];
            [self.dataSource addObject:model];
            
        }
        [self.tableView reloadData];
        
        
        
    } Failed:^(NSError *error) {}];
}

- (void)refreshAction
{
    [self loadData];
}

- (void)seqWithArr:(NSMutableArray *)arr
{
    
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = cellHeight;
        _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
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

#pragma mark - ui_response
- (void)didTapSettingsButton:(UIBarButtonItem *)item
{
    NSLog(@"...");
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[SettingController alloc] init]];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
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
    
    RecommendModel *model = self.dataSource[indexPath.section];
    cell.model = model;
    
    __block NSIndexPath *weakIndexPath = indexPath;
    __weak typeof(self)  weakSelf      = self;
    __block RecommendCell *weakCell    = cell;
    cell.playBlock = ^(UIButton *btn){
        
        // 分辨率字典（key:分辨率名称，value：分辨率url)
//        NSMutableDictionary *dic = @{}.mutableCopy;
//        for (ZFVideoResolution * resolution in model.playInfo) {
//            [dic setValue:resolution.url forKey:resolution.name];
//        }
        // 取出字典中的第一视频URL
        NSURL *videoURL = [NSURL URLWithString:model.link];
        
    };
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
//        self.adView.backgroundColor = [UIColor orangeColor];
        return self.adView;
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 70.0;
    }
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
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
    if(currentOffset >= maximumOffset)
    {
        self.page ++;
        
        int page_forward = self.total / 10;
        if (self.page > page_forward + 1) {
            return;
        }
        
        [self loadMoreData];
    }
}


@end
