//
//  Case5VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/13.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case5VC.h"

// 注释掉这个宏定义，就直接使用length值做约束，否则的话，使用新的mas_topLayoutGuide和mas_bottomLayoutGuide
#define MAS_NEW

@interface Case5VC ()

@property (nonatomic, strong)UIView         *topView;
@property (nonatomic, strong)UIView         *bottomView;

@end

@implementation Case5VC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController setToolbarHidden:NO animated:YES];
    [self createView];
}


- (void)createView {
    _topView = [UIView new];
    _topView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@44);
        //新版的Masonry 增加了一个UIViewController的catagory ：MASAdditions，增加了mas_topLayoutGuide和mas_bottomLayoutGuide两个方法，这样的话，我们就可以优雅的使用topLayoutGuide和bottomLayoutGuide了~
#ifdef MAS_NEW
        make.top.equalTo(self.mas_topLayoutGuide);
#endif
        
    }];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(@44);
        //方法二：
        //新版的Masonry 增加了一个UIViewController的catagory ：MASAdditions，增加了mas_topLayoutGuide和mas_bottomLayoutGuide两个方法，这样的话，我们就可以优雅的使用topLayoutGuide和bottomLayoutGuide了~
#ifdef MAS_NEW
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
#endif
    }];
}



- (IBAction)showOrHiddenNavigationBar:(UIButton *)sender {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    [self updateViewConstraints];
}

- (IBAction)showOrHiddenTabBar:(UIButton *)sender {
    [self.navigationController setToolbarHidden:!self.navigationController.toolbarHidden animated:YES];
    [self updateViewConstraints];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateViewConstraints {
    //方法一：
#ifndef MAS_NEW
    //直接使用length来重新约束
   [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
       //直接利用其length属性，避免iOS、SDK版本升级后topLayoutGuide不再是UIView
       make.top.equalTo(self.topLayoutGuide).with.offset(self.topLayoutGuide.length);
   }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLayoutGuide).with.offset(-self.bottomLayoutGuide.length);
    }];
#endif

    
    [super updateViewConstraints];
}
@end
