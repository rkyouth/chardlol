//
//  CategoryController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/23.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CategoryController.h"
#import "HeroesController.h"
#import "ComperesController.h"
#import "CHCustomCell.h"
#import "SettingController.h"
#import "MatchViewController.h"
#import "SDCycleScrollView.h"

@interface CategoryController () <UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *categories;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [self settingsBarButtonItem];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.cycleScrollView.imageURLStringsGroup = @[@"http://ww3.sinaimg.cn/mw690/005GC2Nwgw1faag8o5nurj30ku0bhmyf.jpg",@"http://ww1.sinaimg.cn/mw690/005GC2Nwgw1f5za8shrrlj30gt0tfq70.jpg"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 60;
        _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return _tableView;
}

- (NSArray *)categories
{
    if (!_categories) {
        _categories = @[@{@"des":@"解 说",@"icon":@"00"},
                        @{@"des":@"英 雄",@"icon":@"11"},
                        @{@"des":@"联 赛",@"icon":@"22"},
                        @{@"des":@"战 队",@"icon":@"33"}];
    }
    return _categories;
}

- (UIBarButtonItem *)settingsBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(didTapSettingsButton:)];
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        CGFloat H = self.view.frame.size.width * 9 / 16;
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, H);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"placeholde"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        _cycleScrollView.autoScrollTimeInterval = 12;
        
        
    }
    return _cycleScrollView;
}

#pragma mark - ui_response
- (void)didTapSettingsButton:(UIBarButtonItem *)item
{    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[SettingController alloc] init]];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCustomCell *cell = [CHCustomCell cellWithTableView:tableView];
    cell.textLabel.text = self.categories[indexPath.row][@"des"];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
//    cell.textLabel.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    cell.imageView.image = [UIImage imageNamed:self.categories[indexPath.row][@"icon"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
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
            break;
        case 2:{
            MatchViewController *match = [[MatchViewController alloc] init];
            [match setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:match animated:YES];
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycle : %ld",(long)index);
}

@end
