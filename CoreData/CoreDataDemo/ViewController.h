//
//  ViewController.h
//  CoreDataDemo
//
//  Created by LZXuan on 15-4-19.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
- (IBAction)addClick:(id)sender;
- (IBAction)deleteClick:(id)sender;
- (IBAction)updateClick:(UIButton *)sender;
- (IBAction)fetchClick:(UIButton *)sender;

@end

