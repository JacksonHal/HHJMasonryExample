//
//  Case4TVCell.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/9.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case4TVCell.h"
#import "Case4DataModel.h"

@interface Case4TVCell ()

@property (nonatomic, strong)UIImageView    *headiconImage;
@property (nonatomic, strong)UILabel        *titleLabel;
@property (nonatomic, strong)UILabel        *contentLabel;
@property (nonatomic, strong)Case4DataModel *model;


@end

@implementation Case4TVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubView];
    }
    return self;
}
- (void)configDataWithModel:(Case4DataModel *)model {
    _model = model;
    _headiconImage.image = model.image;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
}

- (void)createSubView {
    self.tag = 1000;
    _headiconImage = [UIImageView new];
    [self.contentView addSubview:_headiconImage];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    //_headiconImage的位置约束
    [_headiconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@45);
        make.left.and.top.equalTo(self.contentView).with.offset(8);
        
    }];
    
    //_titleLabel的位置约束
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.contentView).with.offset(8);
        make.left.equalTo(_headiconImage.mas_right).with.offset(8);
        make.right.equalTo(self.contentView).with.offset(-8);
        
    }];
    
    //_contentLabel的约束
    /*
     计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
     */
    CGFloat maxLayoutWidth = SCREEN_WIDTH-8*3-45;
    
    _contentLabel.preferredMaxLayoutWidth = maxLayoutWidth;
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
        make.left.equalTo(_headiconImage.mas_right).with.offset(8);
        make.right.equalTo(self.contentView).with.offset(-8);
        make.bottom.equalTo(self.contentView).with.offset(-8);
        
    }];
    
    //根据内容高度适配
    [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}


@end
