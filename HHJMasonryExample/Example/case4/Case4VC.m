//
//  Case4VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/9.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case4VC.h"

@interface Case4VC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView        *mainTableView;
@property (nonatomic, strong) NSMutableArray            *dataArray;

@end

@implementation Case4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -UITableviewDelegate & UITableviewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
