//
//  YJTabBar.m
//  YJTabBarPer
//
//  Created by houdage on 15/11/17.
//  Copyright © 2015年 YJHou. All rights reserved.
//

#import "YJTabBar.h"

#import "UIButton+Badge.h"
//#import "UIControl+Custom.h"
@interface YJTabBar()

@property (nonatomic, weak) UIButton *plusButton;



@property (nonatomic, weak) UIButton *selectedButton;

@end
static YJTabBar *_instance = nil;
@implementation YJTabBar

+ (instancetype) shareYJTabBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YJTabBar alloc]init];
    });
    return _instance;
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    for (UITabBarItem * item in _items) {
        
        self.btn = [YJTabBarButton buttonWithType:UIButtonTypeCustom];
        self.btn.item = item;
        
        self.btn.tag = self.buttons.count;
        
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (self.btn.tag == 0) {
            [self btnClick:self.btn];
             
        }
        
        [self addSubview:self.btn];
        [self.buttons addObject:self.btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    for (YJTabBarButton *btn in _buttons) {
        if (btn == button) {
            break;
        }
        btn.selected = NO;
        
    }
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


- (UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"ic_fabu"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_fabu"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_fabu"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_fabu"] forState:UIControlStateHighlighted];
     
        [btn sizeToFit];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        _plusButton = btn;
        
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}

// 点击加号按钮的时候调用
- (void)plusClick{
    // modal出控制器
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
// 调整子控件的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    // 设置添加按钮的位置
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5 -5);
    self.plusButton.clipsToBounds = YES;
    self.plusButton.layer.cornerRadius = self.plusButton.frame.size.width/2;
    self.plusButton.layer.masksToBounds = YES;
    self.plusButton.layer.borderWidth = 5;
    self.plusButton.layer.borderColor = [UIColor whiteColor].CGColor;

    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(w * 0.5, h * 0.5 - 5) radius:self.plusButton.frame.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    shape.path = path.CGPath;
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.strokeColor = [UIColor whiteColor].CGColor;

    [self.layer addSublayer:shape];
    
    
}

//- (void)drawRect:(CGRect)rect{
////    super.rect = rect
//CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//     CGContextMoveToPoint(context, width/5*2, 30);
//    
//    CGContextAddArcToPoint(context, width/5*2 + width/5/2, 0, width/5*3 ,30, 30);
//    CGContextStrokePath(context);
//}
@end
