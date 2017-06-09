//
//  Case4DataModel.h
//  HHJMasonryExample
//
//  Created by meixiang02 on 2017/6/9.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Case4DataModel : NSObject

@property (nonatomic, copy)NSString         *title;
@property (nonatomic, copy)NSString         *content;
@property (nonatomic, strong)UIImage        *image;

@property (nonatomic, assign)CGFloat        cellHeight;

@end
