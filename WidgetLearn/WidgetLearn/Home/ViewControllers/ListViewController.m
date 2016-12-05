//
//  ListViewController.m
//  WidgetLearn
//
//  Created by 孙道慧 on 2016/10/27.
//  Copyright © 2016年 孙道慧. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有列表";
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@"iOS帅"];
    [self.dataArray addObject:@"iOS龙"];
    [self.dataArray addObject:@"iOS瑜"];
    [self.dataArray addObject:@"iOS宇"];
    [self.dataArray addObject:@"iOS道"];
    [self.dataArray addObject:@"iOS白"];
    [self.dataArray addObject:@"iOS杰"];
    [self.dataArray addObject:@"iOS杨"];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"CellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailVc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailVc.nameString = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
