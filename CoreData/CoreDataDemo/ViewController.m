//
//  ViewController.m
//  CoreDataDemo
//
//  Created by LZXuan on 15-4-19.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "UserModel.h"
#import "CoreDataManager.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    //数据源数组
    NSMutableArray *_dataArr;
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //给tableView设置一个数据源数组
    _dataArr = [[NSMutableArray alloc] init];
    //这个tableView 只是为了 显示查询的结果
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    
}
//增加
- (IBAction)addClick:(id)sender {
    //单例对象 增加
    [[CoreDataManager defaultManager] insertDataWithName:self.name.text age:self.age.text.intValue];
}


- (IBAction)deleteClick:(id)sender {
    [[CoreDataManager defaultManager] deleteDataWithName:self.name.text];
}

//更新 名字 对应的对象的 年龄
- (IBAction)updateClick:(UIButton *)sender {
    [[CoreDataManager defaultManager] updateDataWithName:self.name.text age:self.age.text.intValue];
}

- (IBAction)fetchClick:(UIButton *)sender {
    NSArray *arr = nil;
    [_dataArr removeAllObjects];

#if 1
    //查询 所有的
    arr = [[CoreDataManager defaultManager] fetchAllData];
#else
    //根据名字 查找
    arr = [[CoreDataManager defaultManager] fetchDataWithName:self.name.text];
#endif
    [_dataArr addObjectsFromArray:arr];
    //刷新表格
    [self.tabelView reloadData];
}

#pragma mark - tableView协议

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
    }
    UserModel *model = _dataArr[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"name:%@ age:%d",model.name,model.age.intValue];
    return cell;
}




@end
