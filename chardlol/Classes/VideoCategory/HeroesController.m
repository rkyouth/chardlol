//
//  HerosController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "HeroesController.h"
#import "UIImageView+WebCache.h"
#import "RequestTool.h"
#import "HeroModel.h"
#import "CHCustomCell.h"
#import "VideoListController.h"

@interface HeroesController () <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *filtHero;
@property (nonatomic,strong) NSMutableArray *heroes;

@property (nonatomic,strong) NSMutableArray *heroIcons;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) UISearchController *searchController;

@end

@implementation HeroesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"英雄列表";

    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.indicatorView.center = self.tableView.center;
}

- (void)loadData
{
    [RequestTool GET:hero_list Parameters:nil Successed:^(id resData) {
        
        NSArray *datas = resData;
        [self.heroes removeAllObjects];
        
        for (NSDictionary *dic in datas) {
            HeroModel *hero = [HeroModel herowithDic:dic];
            [self.heroes addObject:hero];
        }
        [self.tableView reloadData];
        
        [self.indicatorView stopAnimating];
        
    } Failed:^(NSError *error) {
        [self.indicatorView stopAnimating];
    }];
}

- (void)pushForVideoList:(HeroModel *)model
{
    VideoListController *list = [[VideoListController alloc] init];
    list.listType = HeroVList;
    list.hero = model;
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 70;
    }
    return _tableView;
}

- (NSMutableArray *)heroes
{
    if (!_heroes) {
        _heroes = [[NSMutableArray alloc] init];
    }
    return _heroes;
}

- (NSMutableArray *)filtHero
{
    if (!_filtHero) {
        _filtHero = [NSMutableArray array];
    }
    return _filtHero;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.color = [UIColor grayColor];
    }
    return _indicatorView;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        self.definesPresentationContext = YES;
        _searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _searchController.searchBar.placeholder = @"请输入英雄名";
    }
    return _searchController;
}



#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active && self.searchController.searchBar.text.length) {
        return self.filtHero.count;
    }
    return self.heroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHCustomCell *cell = [CHCustomCell cellWithTableView:tableView];
    
    if (self.searchController.active && self.searchController.searchBar.text.length) {
        HeroModel *filtHeroModel = self.filtHero[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:filtHeroModel.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.textLabel.text = filtHeroModel.name;
    }else{
        HeroModel *hero = self.heroes[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hero.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.textLabel.text = hero.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchController.active && self.searchController.searchBar.text.length) {
        HeroModel *filtHeroModel = self.filtHero[indexPath.row];
        [self pushForVideoList:filtHeroModel];
    }else{
        HeroModel *hero = self.heroes[indexPath.row];
        [self pushForVideoList:hero];
    }
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"...");
    [self.filtHero removeAllObjects];
    //  得到searchBar中的text
    NSString *text = searchController.searchBar.text;
    //  遍历源数据中的联系人
    for (HeroModel *hero in self.heroes) {
        //  1、text不能为空，第二判断contact是否包括字符串text，是得话，加入到临时数组中
        if ([text length] != 0 && [hero.name containsString:text]) {
            [self.filtHero addObject:hero];
        }
    }
    
    [self.tableView reloadData];
}

@end
