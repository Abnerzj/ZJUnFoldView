//
//  ViewController.m
//  ZJUnFoldView
//
//  Created by Abnerzj on 2017/5/3.
//  Copyright © 2017年 Abnerzj. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataList;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.rowHeight = 60.0f;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _dataList = @[@{@"title" : @"添加行间距", @"lineSpacing" : @(7.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(NO), @"location" : @(2)},
                  @{@"title" : @"不添加行间距", @"lineSpacing" : @(0.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(NO), @"location" : @(2)},
                  @{@"title" : @"默认折叠三行", @"lineSpacing" : @(7.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(NO), @"location" : @(2)},
                  @{@"title" : @"默认展开", @"lineSpacing" : @(7.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(YES), @"location" : @(2)},
                  @{@"title" : @"展开时展开按钮位置：左边", @"lineSpacing" : @(7.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(NO), @"location" : @(0)},
                  @{@"title" : @"默认配置初始化", @"lineSpacing" : @(7.0f), @"foldLines" : @(3), @"isDefaultUnFold" : @(NO), @"location" : @(2)}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ZJUnFoldViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row >= 0 && indexPath.row < _dataList.count) {
        NSDictionary *dict = _dataList[indexPath.row];
        cell.textLabel.text = dict[@"title"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < _dataList.count) {
        NSDictionary *dict = _dataList[indexPath.row];
        DetailViewController *vc = [[DetailViewController alloc] init];
        vc.dict = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
