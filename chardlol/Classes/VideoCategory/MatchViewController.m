//
//  MatchViewController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/29.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "MatchViewController.h"
#import "RequestTool.h"
#import "MatchModel.h"
#import "CHCustomCell.h"
#import "UIImageView+WebCache.h"

@interface MatchViewController ()

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)loadData
{
    [RequestTool GET:match_list Parameters:nil Successed:^(NSDictionary *resData) {
        
        
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in resData[@"data"][@"gameList"]) {
            MatchModel *match = [MatchModel matchWithDic:dic];
            [self.dataSource addObject:match];
        }
        [self.tableView reloadData];
        NSLog(@" data : %@",resData);
        
        
    } Failed:^(NSError *error) {
        
    }];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
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
    
    MatchModel *model = self.dataSource[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.gameLogo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = model.bGameName;
    cell.detailTextLabel.text = model.sGameName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
