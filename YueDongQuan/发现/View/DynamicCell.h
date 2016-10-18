//
//  DynamicCell.h
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"


@interface DynamicCell : UITableViewCell
@property (nonatomic,strong) CellModel * model;



+ (CGFloat)cellHeightWithStr:(NSString *)str imgs:(NSArray *)imgs;

+ (DynamicCell *)dynamicCellWithTable:(UITableView *)table;
@end
