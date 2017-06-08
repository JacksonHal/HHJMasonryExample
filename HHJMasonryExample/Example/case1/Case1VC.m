//
//  Case1VC.m
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/8.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Case1VC.h"

@interface Case1VC ()

@property (nonatomic, strong)UILabel            *label1;
@property (nonatomic, strong)UILabel            *label2;

@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)changeLabeText:(UIStepper *)sender;

@end

@implementation Case1VC

/*有关Autolayout的一个公式：viewA-attribute = viewB-attribute * multiplier + constant*/

/*
 Case 1: 并排两个label，宽度由内容决定。父级View宽度不够时，优先显示左边label的内容
 
 遇到这种跟内容压缩、优先级有关的布局，就不得不提Autolayout中的两个重要的属性“Content Compression Resistance”和“Content Hugging”。
 
 Content Compression Resistance = 不许挤我！
 对，这个属性说白了就是“不许挤我”=。=
 这个属性的优先级（Priority）越高，越不“容易”被压缩。也就是说，当整体的空间装不下所有的View的时候，Content Compression Resistance优先级越高的，显示的内容越完整。
 
 
 Content Hugging = 抱紧！
 这个属性的优先级越高，整个View就要越“抱紧”View里面的内容。也就是View的大小不会随着父级View的扩大而扩大。
 分析
 
 
 根据要求，可以将约束分为两个部分：
 整体空间足够时，两个label的宽度由内容决定，也就是说，label的“Content Hugging”优先级很高，而且没有固定的Width属性。
 整体空间不够时，左边的label更不容易被压缩，也就是“Content Compression Resistance”优先级更高。
 
 
 重点：
 label不设置具体的宽度（width）属性，宽度由内容决定。
 显示的优先级由“Content Compression Resistance”属性的高低决定。
 

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpLabel];
}

- (void)setUpLabel {
    _label1 = [[UILabel alloc] init];
    _label1.backgroundColor = [UIColor yellowColor];
    _label1.text = @"Label,";
    _label2 = [[UILabel alloc] init];
    _label2.text = @"Label,";
    _label2.backgroundColor = [UIColor blueColor];
    [_contentView addSubview:_label1];
    [_contentView addSubview:_label2];
    
    /*设置位置约束*/
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(5);//偏移父视图顶部5像素
        make.left.equalTo(_contentView.mas_left).with.offset(2);//偏移父视图左边2像素
        make.height.equalTo(@40);//固定高度为40;
        
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(5);//偏移父视图顶部5像素
        make.left.equalTo(_label1.mas_right).with.offset(2);//左边与label1间隔2像素
        
        //右边的间隔保持大于等于2，注意是lessThanOrEqual
        //这里的“lessThanOrEqualTo”放在从左往右的X轴上考虑会更好理解。
        //即：label2的右边界的X坐标值“小于等于”containView的右边界的X坐标值。
        make.right.lessThanOrEqualTo(_contentView.mas_right).with.offset(-2);//偏移父视图右边至少是-2像素
        make.height.equalTo(@40);
        
    }];
    
    /*设置内容约束*/
    //设置label1的content compression 为1000
    [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //设置label1的content compression 为250
    [_label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置label1和label2的content hugging 为1000
    [_label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [_label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (IBAction)changeLabeText:(UIStepper *)sender {
    if(sender.tag == 100){//增加或减少label1的内容
        _label1.text = [self changeLabelContent:(NSInteger)sender.value];
    }else if (sender.tag == 101){//增加或减少label2的内容
        _label2.text = [self changeLabelContent:(NSInteger)sender.value];
    }
}

- (NSString *)changeLabelContent:(NSInteger)value {
    NSMutableString *mStr= [NSMutableString new];
    
    for (NSInteger i = 0; i<value+1; i++){
        [mStr appendString:@"Label,"];
    }
    return [mStr copy];
    
}


@end
