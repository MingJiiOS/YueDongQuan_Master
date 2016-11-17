//
//  UIControl+Custom.h
//  按钮重复点击
//
//  Created by 黄方果 on 16/9/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Custom)
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;// 可以用这个给重复点击加间隔

@end
