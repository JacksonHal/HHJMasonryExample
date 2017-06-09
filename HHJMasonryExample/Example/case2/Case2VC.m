//
//  Case2VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/8.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case2VC.h"

static const CGFloat     SIZE_H = 32;

@interface Case2VC ()

@property (nonatomic, strong)UIView             *containerView;
@property (nonatomic, strong)NSMutableArray     *imageViewsArray;
@property (nonatomic, strong)NSMutableArray     *constraintsArray;
@property (nonatomic, strong)NSArray            *imageNamesArray;

- (IBAction)switchAction:(UISwitch *)sender;

@end

@implementation Case2VC


/*
 四个图标并排显示，隐藏、显示其中任意个，整体保持居中。
 
 分析:
 首先就是整体居中，为了实现这个，最简单的办法就是将四个图片“装进”一个容器View里面，然后让这个容器View在整个页面中居中即可。这样就不用控制每个图片的居中效果了。
 然后就是显示与隐藏。在这里我直接控制图片ImageView的宽度，宽度为0的时候不就“隐藏”了吗。

 之所以这么设置，主要目的有以下几点：
 1.尽量减少无效的约束，保证约束不多也不少。
 2.内部的每个imageView约束其实都只有四个：left、centerY、width和height，这样有个好处，就是可以在循环里面依次添加约束，大大减少代码量。
 3.最右边的imageView还要单独设置跟容器View的右边约束，是为了不用设置容器View的width，保证容器View是刚好包含内部的View的，这样整体才是居中的。

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageViewsArray = [NSMutableArray new];
    _constraintsArray = [NSMutableArray new];
    _imageNamesArray = @[@"bluefaces_1",@"bluefaces_2",@"bluefaces_3",@"bluefaces_4"];
    
    [self setUpViews];
}

- (void)setUpViews {
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_containerView];
    
    //设置容器视图的位置
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(200);//相对父视图顶部的偏移量
        make.height.equalTo(@(SIZE_H));//设置容器视图的高度
        make.centerX.equalTo(self.view.mas_centerX);//设置水平居中
        
        //注意：只设置高度，不设置宽度，让子view来控制其宽度；
    }];
    
    
    //填充子view  四个子view循环创建
    for (NSInteger i=0; i<4; i++) {
        UIImageView  *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNamesArray[i]]];
        [_containerView addSubview:imageview];
        [_imageViewsArray addObject:imageview];
    }
    
    //子视图的尺寸
    CGSize imageSize = CGSizeMake(SIZE_H, SIZE_H);
    
    //分别设置每个imageView的宽高、左边、垂直中心约束，注意约束的对象
    //每个View的左边约束和左边的View的右边相等
    UIView  __block *lastView = nil;
    MASConstraint   __block *widthContraint = nil;
    NSInteger   imagesCount = _imageViewsArray.count;
    //设置子视图的约束
    [_imageViewsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = (UIImageView *)obj;
       [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           //make.top.equalTo(_containerView.mas_top).width.offset(0);//顶部的位置
           //make.width.equalTo(@(imageSize.width));//宽
           widthContraint = make.width.equalTo(@(imageSize.width));
           make.height.equalTo(@(imageSize.height));//高
           make.centerY.equalTo(_containerView.mas_centerY);
           //判断左边是否有子view，如果有，就以左边的子view为参照，如果没有就以父视图为参照。
           make.left.equalTo(lastView ? lastView.mas_right : imageView.superview.mas_left);
           if (idx == imagesCount-1) {
               make.right.equalTo(imageView.superview.mas_right);
           }
           [_constraintsArray addObject:widthContraint];
           lastView = imageView;
       }];
    }];
}

- (IBAction)switchAction:(UISwitch *)sender {
    
    MASConstraint *widtConstraint = self.constraintsArray[sender.tag-200];
    if (sender.on) {
        widtConstraint.equalTo(@(SIZE_H));
    }else {
        widtConstraint.equalTo(@(0));
    }
}
@end
