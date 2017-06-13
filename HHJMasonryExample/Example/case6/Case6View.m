//
//  Case6View.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/13.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case6View.h"

@interface Case6View ()

@property (strong, nonatomic) UIView *baseView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *text;

@end

@implementation Case6View

+ (instancetype)newItemWithImage:(UIImage *)image text:(NSString *)text {
    Case6View *item = [Case6View new];
    item.image = image;
    item.text = text;
    [item initView];
    
    return item;
}

#pragma mark - Private methods

- (void)initView {
    self.backgroundColor = [UIColor lightGrayColor];
    
    // ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_image];
    self.baseView = imageView;
    
    // Label
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = _text;
    label.textColor = [UIColor whiteColor];
    
    [self addSubview:imageView];
    [self addSubview:label];
    
    // ImageView
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(4);
        make.top.equalTo(self.mas_top).with.offset(4);
        make.right.equalTo(self.mas_right).with.offset(-4);
    }];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    // Label
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(imageView.mas_width);
        make.left.equalTo(imageView.mas_left);
        make.top.equalTo(imageView.mas_bottom).with.offset(4);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
    }];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

//返回自定义baseline的view
- (UIView *)viewForLastBaselineLayout {
    return _baseView;
}
@end
