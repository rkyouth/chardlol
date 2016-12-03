//
//  HomeViewController.m
//  chardlol
//
//  Created by ChardLl on 2016/12/2.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "HomeViewController.h"
#import "RequestTool.h"
#import "TableViewCCell.h"
#import "ComperesController.h"
#import "HeroesController.h"
#import "CHCollectionCell.h"
#import "RecommendModel.h"
#import "CCellHeadView.h"
#import "MoviePlayerViewController.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) int page;
@property (nonatomic,assign) int total;

@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation HomeViewController

static NSString *const ccellId = @"collectioncell";
static NSString *const cheaderId = @"collectioncellheader";
static NSString *const tableccellid = @"tableccellid";
static NSString *const chcellId = @"chcell";
static NSString *const ccellheadid = @"ccellheadid";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.refreshControl];
    
    [self loadData];
}

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
        [self.collectionView reloadData];
        
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
        [self.collectionView reloadData];
        
        
        
    } Failed:^(NSError *error) {}];
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = cellgap;
        layout.minimumLineSpacing = cellgap;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, self.tabBarController.tabBar.frame.size.height, 0);
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ccellId];
        [_collectionView registerClass:[CHCollectionCell class] forCellWithReuseIdentifier:chcellId];
        [_collectionView registerClass:[TableViewCCell class] forCellWithReuseIdentifier:tableccellid];
        [_collectionView registerClass:[CCellHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ccellheadid];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    }
    return _collectionView;
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
        _indicatorView.center = self.view.center;
    }
    return _indicatorView;
}

#pragma mark - ui_response
- (void)refreshAction
{
    [self loadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.dataSource.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ccellId forIndexPath:indexPath];
//    if (!cell) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.bounds];
        [cell addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://r1.ykimg.com/material/0A03/201612/122/117648/1202-1300-100.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    }
    
//    cell.backgroundColor = [UIColor orangeColor];
    
    if (indexPath.section == 1) {
        TableViewCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:tableccellid forIndexPath:indexPath];
        ccell.cCellClick = ^(NSInteger row){
            switch (row) {
                case 0:{
                    ComperesController *comp = [[ComperesController alloc] init];
                    [comp setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:comp animated:YES];
                }
                    break;
                case 1:{
                    HeroesController *heros = [[HeroesController alloc] init];
                    [heros setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:heros animated:YES];
                }
                default:
                    break;
            }
        };
        
        return ccell;
    }
    
    if (indexPath.section == 2) {
        CHCollectionCell *chcell = [collectionView dequeueReusableCellWithReuseIdentifier:chcellId forIndexPath:indexPath];
        RecommendModel *rec = self.dataSource[indexPath.row];
        chcell.model = rec;
        
        return chcell;
    }
    
    return cell;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        RecommendModel *rec = self.dataSource[indexPath.item];
        
        MoviePlayerViewController *moviePlayer = [[MoviePlayerViewController alloc] init];
        moviePlayer.videoURL = [NSURL URLWithString:rec.link];
        moviePlayer.videoTitle = rec.title;
        [moviePlayer setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:moviePlayer animated:YES];
    }
   
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        CHCollectionCell *cell = (CHCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.highlightView.hidden = NO;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        CHCollectionCell *cell = (CHCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.highlightView.hidden = YES;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(self.view.frame.size.width, 70);
            break;
        case 1:
            return CGSizeMake(self.view.frame.size.width, 120);
            break;
        case 2:{
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
            layout.sectionInset = UIEdgeInsetsMake(0, cellgap, 0, cellgap);
            CGFloat W = (self.view.frame.size.width - cellgap * 3) * 0.5;
            CGFloat H = W * 9 / 16 + 40;
            return CGSizeMake(W, H);
            break;
        }
        default:
            return CGSizeZero;
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return CGSizeMake(self.view.frame.size.width, 50);
    }
    return CGSizeZero;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        if([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            CCellHeadView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ccellheadid forIndexPath:indexPath];
            if(headerView == nil)
            {
                headerView = [[CCellHeadView alloc] init];
                
            }
            headerView.titleLab.text = indexPath.section == 1 ? @"分 类" : @"推 荐";
            
            return headerView;
        }
    }
    
    return nil;
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
