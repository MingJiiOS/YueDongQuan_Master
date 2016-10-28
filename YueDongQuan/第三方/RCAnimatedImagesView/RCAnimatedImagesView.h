//
//  RCAnimatedImagesView.h
//  RCloudMessage
//
//  Created by 杜立召 on 15/3/18.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kJSAnimatedImagesViewDefaultTimePerImage 20.0f

@protocol RCAnimatedImagesViewDelegate;
//动画执行方向 right：向右 left：向左
typedef enum {
    right,
    left
}type;

@interface RCAnimatedImagesView : UIView

@property(nonatomic, assign) id<RCAnimatedImagesViewDelegate> delegate;

@property(nonatomic, assign) NSTimeInterval timePerImage;

@property (nonatomic,assign) type diectType;

- (void)startAnimating;
- (void)stopAnimating;

- (void)reloadData;

@end

@protocol RCAnimatedImagesViewDelegate
- (NSUInteger)animatedImagesNumberOfImages:
    (RCAnimatedImagesView *)animatedImagesView;
- (UIImage *)animatedImagesView:(RCAnimatedImagesView *)animatedImagesView
                   imageAtIndex:(NSUInteger)index;

@end
