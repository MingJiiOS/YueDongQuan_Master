//
//  UITableViewCell+ClickTime.h
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/27.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ClickTime)


@property (nonatomic, assign) NSTimeInterval custom_CellAcceptEventInterval;// 可以用这个给重复点击加间隔

@end
