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

@interface CategoryController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *categories;

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [self settingsBarButtonItem];
    
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

#pragma mark - ui_response
- (void)didTapSettingsButton:(UIBarButtonItem *)item
{
    NSLog(@"...");
    
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
