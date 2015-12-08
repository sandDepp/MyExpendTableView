//
//  ViewController.m
//  MyExpendTableView
//
//  Created by 沙莎 on 15/12/8.
//  Copyright © 2015年 沙莎. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableIndexSet *_sectionSet;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionSet = [[NSMutableIndexSet alloc]init];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!indexPath.row) {
        cell.textLabel.text = @"section";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.textLabel.text = @"row";
        NSInteger  rows  = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        float proportion = (float)indexPath.row/rows;
        NSLog(@"%f",proportion);
        cell.backgroundColor = [UIColor colorWithRed:(float)(proportion * 255)/255.0f green:0.2f blue:0.2f alpha:1.0f];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    /*注意判断是否在集合中*/
    if ([_sectionSet containsIndex:section]) {
        return (section*2)+2;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     /*是否点击的为第一行*/
    if (!indexPath.row) {
        
        [tableView beginUpdates];
        
         /*是否展开的标志*/
        BOOL currentExpendFlag = [_sectionSet containsIndex:indexPath.section];
        
         /*行数*/
        NSInteger rows;
        
        /*rows的赋值必须在集合操作之后*/
        if (currentExpendFlag) {
        
            rows  = [self tableView:tableView numberOfRowsInSection:indexPath.section];
             [_sectionSet removeIndex:indexPath.section];
        }else{
              [_sectionSet addIndex:indexPath.section];
            rows  = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        }
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        /*从1开始－－记得啦*/
        for (int i = 1; i < rows; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i  inSection:indexPath.section];
            [tmpArray addObject:index];
        }
        
        if (currentExpendFlag) {
            
            [tableView deleteRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationFade];
            
        }else{
    
            [tableView insertRowsAtIndexPaths:tmpArray withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView endUpdates];
    }
    
   
}
@end
