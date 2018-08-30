//
//  JYBallProgressView.h
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/30.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYBallProgressView : UIView
@property (nonatomic, assign) CGFloat           lineWidth;  // 圆的线宽
@property (nonatomic, assign) CFTimeInterval    duration;   // 秒
@property (nonatomic, assign) CGFloat           percent;    // 百分比
@property (nonatomic, strong) NSArray<UIColor *>*colors;    // 颜色组(CGColor)


/**
 startAnimation必须在设置frame之后调用..
 */
- (void)startAnimation;
- (void)endAnimation;
@end
