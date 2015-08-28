//
//  UserModel.h
//  CoreDataDemo
//
//  Created by LZXuan on 15-4-19.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserModel : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fName;

@end
