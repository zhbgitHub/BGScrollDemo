
//
//  JYTestView.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "JYTestView.h"

@implementation JYTestView


- (void)drawRect:(CGRect)rect {
    //1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat y = rect.size.height/2;

    for (int i =0; i<9; i++) {
        CGFloat x = (self.marginX+self.ballR)+self.pointGap*i;
        CGContextAddArc(ctx, x, y, 8, 0, M_2_PI, 1);
    }
    
    [[UIColor redColor] set];
    CGContextFillPath(ctx);
}


@end
