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

@interface CategoryController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *categories;

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 70;
        _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
    return _tableView;
}

- (NSArray *)categories
{
    if (!_categories) {
        _categories = @[@"解说",@"英雄",@"联赛",@"战队"];
    }
    return _categories;
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
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.text = self.categories[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
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
            
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}

@end
