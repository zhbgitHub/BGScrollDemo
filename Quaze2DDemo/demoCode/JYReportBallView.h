//
//  JYReportBallView.h
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JYReportBallViewDelegate <NSObject>
@optional
- (void)reportBallDoMoving:(CGFloat)ballCenterX;
- (void)reportBallDidMoved:(CGFloat)ballCenterX;
@end



@interface JYReportBallView : UIView

@property (nonatomic, weak) id<JYReportBallViewDelegate> delegate;


/**
 滚球的半径,只读,默认值10.f
 */
@property (nonatomic, assign, readonly) CGFloat ballR;

/**
 一个历程的长度,相邻中心点的距离,只读.
 */
@property (nonatomic, assign, readonly) CGFloat pointGap;

/**
 X轴方向上,控件view距离superView左边的间距
 */
@property (nonatomic, assign) CGFloat levelGap;


/**
 中心定点-个数,默认5
 */
@property (nonatomic, assign) NSInteger pointCount;

@end
