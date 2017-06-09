//
//  Case3VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/8.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case3VC.h"

@interface Case3VC ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (nonatomic, assign) CGFloat       maxWidth;


@end

@implementation Case3VC

/*
 要求：子View的宽度始终是父级View的一半（或者任意百分比）
 
 viewA-attribute = viewB-attribute * multiplier + constant
 这个是Autolayout里面一个约束的不同属性的基本组合关系，替换成宽度的话，就是下面这样：
 子View的宽度 = 父级View宽度 * 系数 + 常数；
 
 在Masonry里面，其实有个函数“multipliedBy”，就是用来设置multipler属性的（跟原本的NSLayoutConstraint的对应）
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    _maxWidth = _widthConstraint.constant;//记录父视图最大的宽度；
    [self setUpViews];
}

- (void)setUpViews {
    UIView  *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor redColor];
    [self.view addSubview:subView];
    
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView.mas_top);//贴近父视图的顶端
        make.left.equalTo(_containerView.mas_left);//贴近父视图的左边
        make.height.equalTo(_containerView.mas_height);//与父视图同高
        make.width.equalTo(_containerView.mas_width).multipliedBy(0.5);//约束子视图的宽度是父视图的宽度的一半
    }];
}

/*
 
 preferredMaxLayoutWidth
 多行标签的首选最大宽度（以点为单位）。
 当应用布局约束时，此属性会影响标签的大小。 在布局期间，如果文本超出此属性指定的宽度，则附加文本将流向一个或多个新行，从而增加标签的高度。
 */

- (IBAction)changePercentage:(UISlider *)sender {
    _widthConstraint.constant = _maxWidth*sender.value;
}
@end
