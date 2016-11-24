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

@interface HeroesController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *heroes;

@property (nonatomic,strong) NSMutableArray *heroIcons;

@end

@implementation HeroesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

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
    [RequestTool GET:hero_list Parameters:nil Successed:^(id resData) {
        
        NSArray *datas = resData;
        [self.heroes removeAllObjects];
        
        for (NSDictionary *dic in datas) {
            HeroModel *hero = [HeroModel herowithDic:dic];
            [self.heroes addObject:hero];
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

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    HeroModel *hero = self.heroes[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hero.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = hero.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
