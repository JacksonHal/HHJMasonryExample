//
//  Case4VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/9.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case4VC.h"
#import "Common.h"
#import "Case4TVCell.h"
#import "Case4DataModel.h"

@interface Case4VC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView        *mainTableView;
@property (nonatomic, strong) NSArray            *dataArray;
@property (nonatomic, strong) Case4TVCell               *tempCell;

@end

@implementation Case4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self createData];
}

- (void)createData {
    NSMutableArray *tempData = [NSMutableArray new];
    for (NSInteger i = 0; i<30; i++) {
        Case4DataModel *model = [[Case4DataModel alloc] init];
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"bluefaces_%ld",i%4+1]];
        model.title = [NSString stringWithFormat:@"Label_%ld",i+1];
        model.content = [Common getText:@"label," withRepeat:(int)(i*2+1)];
        [tempData addObject:model];
    }
    _dataArray = tempData;
    
    [_mainTableView reloadData];
    
}

- (void)setUpTableView {
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.estimatedRowHeight = 80;
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    if (IOS_VERSION >7.0) {
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
    }

#endif
    
    [_mainTableView registerClass:[Case4TVCell class] forCellReuseIdentifier:NSStringFromClass([Case4TVCell class])];
    
}

#pragma mark -UITableviewDelegate & UITableviewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Case4TVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4TVCell class]) forIndexPath:indexPath];
    //if (_dataArray.count > indexPath.row) {
        [cell configDataWithModel:_dataArray[indexPath.row]];
    //}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    #ifdef IOS_8_NEW_FEATURE_SELF_SIZING
        // iOS 8 的Self-sizing特性
        return UITableViewAutomaticDimension;
    #else
    
    if (!_tempCell) {
        _tempCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4TVCell class]) forIndexPath:indexPath];
        _tempCell.tag = -1000;
    }
    
    Case4DataModel *model = _dataArray[indexPath.row];
    
    //判断高度是否计算过
    if (model.cellHeight<=0) {
        [_tempCell configDataWithModel:model];
        //根据当前cell的内容，计算相应的cell的高度，
        model.cellHeight = [_tempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate: %ld, height: %g", (long) indexPath.row, model.cellHeight);
    }else {
        NSLog(@"Get: %ld, height: %g", (long) indexPath.row, model.cellHeight);
    }
    return model.cellHeight;
#endif
}


@end
