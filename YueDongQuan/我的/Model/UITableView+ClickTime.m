//
//  UITableViewCell+ClickTime.m
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/27.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import "UITableView+ClickTime.h"
#import <objc/runtime.h>
@interface UITableView()

@property (nonatomic, assign) NSTimeInterval custom_CellAcceptEventTime;

@end

@implementation UITableView (ClickTime)

+ (void) load{
    
    Method systemMethod = class_getInstanceMethod(self, @selector(tableView:didSelectRowAtIndexPath:));
    SEL sysSEL = @selector(tableView:didSelectRowAtIndexPath:);
    Method customMethod = class_getInstanceMethod(self, @selector(custom_tableView:didSelectRowAtIndexPath:));
    SEL customSEL = @selector(custom_tableView:didSelectRowAtIndexPath:);
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
}

- (NSTimeInterval) custom_CellAcceptEventInterval{
    return [objc_getAssociatedObject(self, "UITableView_custom_CellAcceptEventInterval") doubleValue];
}

- (void) setCustom_CellAcceptEventInterval:(NSTimeInterval)custom_CellAcceptEventInterval{
    
    objc_setAssociatedObject(self,
                             "UITableView_custom_CellAcceptEventInterval",
                             @(custom_CellAcceptEventInterval),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval) custom_CellAcceptEventTime{
    return [objc_getAssociatedObject(self, "UITableView_CellAcceptEventTime") doubleValue];
}

- (void) setCustom_CellAcceptEventTime:(NSTimeInterval)custom_CellAcceptEventTime{
    objc_setAssociatedObject(self,
                             "UITableView_custom_CellAcceptEventTime",
                             @(custom_CellAcceptEventTime),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)custom_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.custom_CellAcceptEventInterval <= 0) {
        self.custom_CellAcceptEventInterval = 1.5;
    }
    
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970
                           - self.custom_CellAcceptEventTime >= self.custom_CellAcceptEventInterval);
    
    if (self.custom_CellAcceptEventInterval > 0) {
        self.custom_CellAcceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    if (needSendAction) {
        [self custom_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
@end
