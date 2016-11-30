//
//  ComperesController.m
//  chardlol
//
//  Created by ChardLl on 2016/11/24.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "ComperesController.h"
#import "RequestTool.h"
#import "CHCustomCell.h"
#import "ComperesModel.h"
#import "UIImageView+WebCache.h"

#define userslist @"89323481,99201492,25003662,86787875,91386394,76521919,86364302,346799477,431098561,340703547,14771885,369136383,57379868,111568632,455360660,87581910,70802174,141103004,94442014,67612492,45810217,340647717,344782203,155410757,136141036,134336394,148833979,97764116,146341241,90827101,19654343,138108211,65078683,104820044,110299062,98073387,128560709"

@interface ComperesController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@end

@implementation ComperesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"解说";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
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
    NSDictionary *params = @{@"client_id":yk_clientid,
                             @"user_ids":userslist};
    [RequestTool POST:yk_users Parameters:params Successed:^(NSDictionary *resData) {
        
        [self.dataSource removeAllObjects];
        for (NSDictionary *dic in resData[@"users"]) {
            ComperesModel *com = [ComperesModel comperesWithDic:dic];
            [self.dataSource addObject:com];
        }
        [self.tableView reloadData];
        
        [self.indicatorView stopAnimating];
        
    } Failed:^(NSError *error) {
        [self.indicatorView stopAnimating];
    }];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
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

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.color = [UIColor grayColor];
    }
    return _indicatorView;
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
    
    ComperesModel *model = self.dataSource[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.desc;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
