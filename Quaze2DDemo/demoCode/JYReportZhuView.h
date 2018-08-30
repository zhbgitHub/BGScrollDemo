//
//  JYReportZhuView.h
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYReportZhuView : UIView

@property (nonatomic, copy)     NSString    *topTitle;
@property (nonatomic, copy)     NSString    *bottomTitle;
@property (nonatomic, strong)   UILabel     *topLb;
@property (nonatomic, strong)   UIView      *colorView;



/**
 中间柱状图的高度百分率..需要外层请求数据完毕后给我设置...0~1)
 */
@property (nonatomic, assign) CGFloat percent;

/**
 中间柱状图的宽度比例/中间柱状图的底部y比例,,,需要外层滚动时,给我设置...0~1)
 */
@property (nonatomic, assign) CGFloat scale;

@end
