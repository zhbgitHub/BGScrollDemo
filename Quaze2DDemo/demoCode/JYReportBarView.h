//
//  JYReportBarView.h
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/29.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

/*****************************
 暂时仅仅支持initWithFrame:方法的创建.
 *****************************/

#import <UIKit/UIKit.h>

@interface JYReportBarView : UIView


/**
 X轴方向上,控件view距离superView左边的间距
 */
@property (nonatomic, assign) CGFloat levelGap;

/**
 所有柱状图,高度百分比...
 */
@property (nonatomic, strong) NSArray<NSNumber *> *percentArray;


/**
 柱状图的个数
 */
@property (nonatomic, assign) NSInteger barrelCount;


/**
 最大放大比例(0~1)
 */
@property (nonatomic, assign, readonly) CGFloat  maxScale;

@end
