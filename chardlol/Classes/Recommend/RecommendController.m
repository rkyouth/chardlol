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
#import "RecommendModel.h"
#import "UIImageView+WebCache.h"
#import "ZFPlayer.h"
#import "ZFDownloadManager.h"
#import "SettingController.h"

@interface RecommendController () <UITableViewDataSource,UITableViewDelegate,ZFPlayerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, strong) ZFPlayerView        *playerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [self settingsBarButtonItem];
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
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
                             @"playlist_id":yk_playlistid,
                             @"page":@"",
                             @"count":@"10"
                             };
    [RequestTool GET:recommend_list Parameters:params Successed:^(NSDictionary *resData) {

        [self.dataSource removeAllObjects];
        NSArray *videos = resData[@"videos"];
        for (NSDictionary *dic in videos) {
            RecommendModel *model = [RecommendModel recommendWithDic:dic];
            [self.dataSource addObject:model];
        }
        [self.tableView reloadData];
    } Failed:^(NSError *error) {}];
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

- (ZFPlayerView *)playerView
{
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        _playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        // _playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView
{
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
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
        
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.title            = model.title;
        playerModel.videoURL         = videoURL;
        playerModel.placeholderImageURLString = model.thumbnail;
        playerModel.tableView        = weakSelf.tableView;
        playerModel.indexPath        = weakIndexPath;
        // 赋值分辨率字典
//        playerModel.resolutionDic    = dic;
        // (需要设置imageView的tag值，此处设置的为101)
        playerModel.cellImageViewTag = weakCell.imgView.tag;
        
        // 设置播放控制层和model
        [weakSelf.playerView playerControlView:weakSelf.controlView playerModel:playerModel];
        [weakSelf.playerView addPlayerToCellImageView:weakCell.imgView];
        // 下载功能
        weakSelf.playerView.hasDownload = NO;
        // 自动播放
        [weakSelf.playerView autoPlayTheVideo];
    };
    
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

#pragma mark - ZFPlayerDelegate
- (void)zf_playerDownload:(NSString *)url
{
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}

@end
