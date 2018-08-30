//
//  JYBallProgressView.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/30.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "JYBallProgressView.h"

@interface JYBallProgressView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation JYBallProgressView
@synthesize colors = _colors;

#pragma mark - 1. public method

- (void)startAnimation
{
    // 获取当前的layer--强转-> (CAGradientLayer *),然后设置渐变layer以及其颜色值
    CAGradientLayer *gradientLayer = (CAGradientLayer *)[self layer];
    [gradientLayer setColors:self.colors];
    
    // 设置渐变layer的mask
    self.layer.mask = self.circleLayer;
    
    //开启layer动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = self.duration;
    animation.repeatCount       = MAXFLOAT;
    animation.fromValue         = [NSNumber numberWithDouble:0];
    animation.toValue           = [NSNumber numberWithDouble:M_PI*2];
    [self.layer addAnimation:animation forKey:nil];
}

- (void)endAnimation
{
    [self.layer removeAllAnimations];
}

#pragma mark -- system

/**
 将当前view的layer替换成渐变色layer
 
 @return CAGradientLayer class
 */
+ (Class)layerClass
{
    return [CAGradientLayer class];
}

#pragma mark -- public getters and setters
- (CGFloat)lineWidth
{
    return _lineWidth ? : 1.f;
}

- (CFTimeInterval)duration
{
    return _duration ? : 5.0;
}

- (void)setPercent:(CGFloat)percent
{
    self.circleLayer.strokeEnd = percent;
}

- (NSArray *)colors
{
    if (_colors == nil) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSInteger hue = 0; hue <= 360; hue += 10) {
            [temp addObject:(id)[UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
        }
        _colors = [temp copy];
    }
    return _colors;
}

- (void)setColors:(NSArray<UIColor *> *)colors
{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *subObj in colors) {
        [temp addObject:(id)(subObj.CGColor)];
    }
    _colors = [temp copy];
}

#pragma mark -- private getters and setters
- (CAShapeLayer *)circleLayer
{
    if (_circleLayer == nil) {
        _circleLayer = [CAShapeLayer layer];
        // 生产出一个圆的路径
        CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat circleRadius = self.bounds.size.width/2.0 - 2*self.lineWidth;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:circleRadius startAngle:M_PI endAngle:-M_PI clockwise:NO];
        // 生产出一个圆形路径的Layer
        _circleLayer.path          = circlePath.CGPath;
        _circleLayer.strokeColor   = [UIColor whiteColor].CGColor;
        _circleLayer.fillColor     = [[UIColor clearColor] CGColor];
        _circleLayer.lineWidth     = self.lineWidth;
        // 可以设置出圆的完整性
        _circleLayer.strokeStart = 0;
        _circleLayer.strokeEnd = 1.0;
    }
    return _circleLayer;
}


@end
