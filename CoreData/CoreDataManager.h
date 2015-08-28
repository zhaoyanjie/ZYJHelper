//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by LZXuan on 15-4-19.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//封装 成一个 数据管理类 专门 管理 CoreData

//设计一个单例类 管理数据库
@interface CoreDataManager : NSObject
//非标准单例
+ (instancetype)defaultManager;

//上下文管理对象
@property (nonatomic,strong) NSManagedObjectContext *context;


//增删改查
//增加一个数据
- (void)insertDataWithName:(NSString *)name age:(int)age;

//根据名字删除
- (void)deleteDataWithName:(NSString *)name;

//修改数据 根据名字修改年龄
- (void)updateDataWithName:(NSString *)name age:(int)age;

//查询
//查询所有的数据
- (NSArray *)fetchAllData;

//根据名字查找
- (NSArray *)fetchDataWithName:(NSString *)name;


@end











