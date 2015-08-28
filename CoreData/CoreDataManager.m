//
//  CoreDataManager.m
//  CoreDataDemo
//
//  Created by LZXuan on 15-4-19.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "CoreDataManager.h"
#import "UserModel.h"

@implementation CoreDataManager

+ (instancetype)defaultManager {
    static CoreDataManager *manager = nil;
    
    @synchronized(self) {
        manager = [[self alloc] init];
    }
    return manager;
}
//初始化准备工作
//1.导入头文件 CoreData/CoreData.h
//2.创建一个 一个数据模型文件(和数据库中的表类似)，里面创建一些数据模型(设计属性)
//3.设计 一个数据模型类(根据数据模型文件)

- (instancetype)init {
    if (self = [super init]) {
        //1.将数据模型文件中的 的模型 放入 modelFile 指向的 对象中
        //关联数据模型
         NSManagedObjectModel *modelFile = [NSManagedObjectModel mergedModelFromBundles:nil];

        //2.设置 存储 协调器  (协调 底层和上层)
        //2.1让 协调器 和 modelFile产生关联
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:modelFile];
        
        //2.2设置数据库文件的路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/Mydata.sqlite"];
        NSError *error = nil;
        //2.3设置 存储方式 根据路径创建 数据库文件
        ///将coreData数据  映射到数据库
        
        NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:&error];
        if (!store) {
            //创建 失败
            NSLog(@"creat store falied:%@",error.localizedDescription);
            return nil;
        }
        
        //3.托管对象 /上下文管理对象
        self.context = [[NSManagedObjectContext alloc] init];
        //托管对象 和 协调器 产生 关联
        self.context.persistentStoreCoordinator = coordinator;
        //_context 对数据库 进行增删改查
    }
    return self;
}
//下面 进行 增删改查
//增加一个数据
- (void)insertDataWithName:(NSString *)name age:(int)age {
    //1.给_context 操作的数据 增加一个UserModel实例对象
    
    //用 NSEntityDescription来增加
    UserModel *model = (UserModel *)[NSEntityDescription insertNewObjectForEntityForName:@"UserModel" inManagedObjectContext:self.context];
    model.name = name;
    model.age = @(age);
    model.fName = [name substringToIndex:1];
    
    //保存数据
    [self saveDataWithType:@"addData"];
}
- (void)saveDataWithType:(NSString *)type {
    NSError *error = nil;
    //回写 保存到数据库文件
    if (![self.context save:&error]) {
        //保存失败
        NSLog(@"%@:%@",type,error.localizedDescription);
    }
}
//根据名字删除
- (void)deleteDataWithName:(NSString *)name {
    //根据名字 找到对象
    NSArray *arr = [self fetchDataWithName:name];
    //遍历数组
    for (UserModel *model in arr) {
        [self.context deleteObject:model];
    }
    //保存数据
    [self saveDataWithType:@"deleteData"];
}

//修改数据 根据名字修改年龄
- (void)updateDataWithName:(NSString *)name age:(int)age{
    //1.根据名字 找到对象
    NSArray *arr = [self fetchDataWithName:name];
    //2.遍历数组
    for (UserModel *model in arr) {
        model.age = @(age);
    }
    //3.保存数据
    [self saveDataWithType:@"updateData"];

}

//查询
//查询所有的数据
- (NSArray *)fetchAllData {
    return [self fetchDataWithName:nil];
}
#pragma mark - 根据名字 在数据库中 查找 数据模型对象
//根据名字查找
- (NSArray *)fetchDataWithName:(NSString *)name {
    //1.先设置查找请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //2.设置 查找的数据模型对象
    request.entity = [NSEntityDescription  entityForName:@"UserModel" inManagedObjectContext:_context];
    //3.设置 谓词 (根据条件 找要设置谓词)
    if (name) {
        //name 不是nil 那么就根据名字找 设置谓词
        //要查询 一个对象的 匹配的属性 那么需要设置谓词
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",name];
        request.predicate = predicate;
    }
    //还可以设置排序 从小到大 或者从大到小
    //按照年龄降序 的一个描述
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    //按照 name 进行 升序排列
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
#if 0
    request.sortDescriptors = @[sort1];//按照一个准则排序 age
#else
    //先按照 age 进行降序排 ，如果出现age 相同 那么 再按照name 升序排序
    request.sortDescriptors = @[sort1,sort2];
#endif
   
    //不设置 谓词 那么找所有
    
    //5.执行 查询请求  返回一个数组
    NSArray *resultArr = [_context executeFetchRequest:request error:nil];
    return resultArr;
}

@end
