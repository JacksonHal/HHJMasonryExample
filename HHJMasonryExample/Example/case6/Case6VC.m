//
//  Case6VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/13.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case6VC.h"
#import "Case6View.h"
@interface Case6VC ()

@end

@implementation Case6VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义view的baseLine";
    
    [self createView];
}


- (void)createView {
    NSArray *imageArry = @[@"dog_small", @"dog_middle", @"dog_big"];
    
    Case6View *view1 = [Case6View newItemWithImage:[UIImage imageNamed:imageArry[0]] text:@"Auto layout is a system"];
    Case6View *view2 = [Case6View newItemWithImage:[UIImage imageNamed:imageArry[1]] text:@"Auto Layout is a system that lets you lay out"];
    Case6View *view3 = [Case6View newItemWithImage:[UIImage imageNamed:imageArry[2]] text:@"Auto Layout is a system that lets you lay out your app’s user interface"];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    
    //约束第一个view的位置
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.view.mas_top).with.offset(300);
    }];
    
    //view2与view1的baseLine对齐
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view1.mas_right).with.offset(20);
        make.baseline.equalTo(view1.mas_baseline);
    }];
    
    //view3与view1的baseLine对齐
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2.mas_right).with.offset(20);
        make.baseline.equalTo(view2.mas_baseline);
    }];
}


@end
