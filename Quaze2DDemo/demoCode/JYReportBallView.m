
//
//  JYReportBallView.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "JYReportBallView.h"
#import "JYReportZhuView.h"
#import "JYTestView.h"

#define allH  self.bounds.size.height
#define allW  self.bounds.size.width
#define halfH  self.bounds.size.height * 0.5f
#define halfW  self.bounds.size.width * 0.5f

@interface JYReportBallView ()
@property (nonatomic, strong) UIView    *ballView;
@property (nonatomic, assign) CGFloat   ball_centerX;
@property (nonatomic, assign) BOOL      isMoveBall;

@property (nonatomic, strong) CAShapeLayer *shapLayer;
@end


@implementation JYReportBallView
@synthesize ball_centerX = _ball_centerX;
@synthesize levelGap = _levelGap;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.ballView.frame = CGRectMake(self.levelGap, halfH-self.ballR, 2*self.ballR, 2*self.ballR);
    [self setUpshapLayer];
}

#pragma mark --system event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self];
    if (CGRectContainsPoint(self.ballView.frame, point)) {
        self.isMoveBall = YES;
    }
    else {
        self.isMoveBall = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    if (self.isMoveBall == YES) {
        UITouch *touch = [touches anyObject];
        CGPoint curP = [touch locationInView:self];
        CGPoint preP = [touch previousLocationInView:self];
        CGFloat offsetX = curP.x - preP.x;
        CGPoint oldCenter = self.ballView.center;
        self.ball_centerX = oldCenter.x + offsetX;
        self.ballView.center = CGPointMake(self.ball_centerX, oldCenter.y);
        [self setUpshapLayer];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEndedOrCancelled];

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self touchesEndedOrCancelled];
}

- (void)touchesEndedOrCancelled
{
    if (self.isMoveBall == YES) {
        double beiChu = self.ball_centerX - self.levelGap - self.ballR;
        NSInteger quMo = round(beiChu/self.pointGap);
        CGPoint oldCenter = self.ballView.center;
        self.ball_centerX = quMo*self.pointGap + self.levelGap + self.ballR;
        self.ballView.center = CGPointMake(self.ball_centerX, oldCenter.y);
        [self setUpshapLayer];
//        if ([self.delegate respondsToSelector:@selector(reportBallDidMoved:)]) {
//            [self.delegate reportBallDidMoved:self.ball_centerX];
//        }
    }
}

#pragma mark --Private method

- (void)setUpshapLayer
{
    CGFloat bigR = self.ballR * 1.3;
    CGFloat smallR = self.ballR;
    double radian = acos((smallR/(smallR + bigR)));
    double leftXCha = sin(radian) * (smallR + bigR);
    CGFloat leftX = self.ball_centerX - leftXCha;
    CGFloat leftY = halfH - smallR;
    
    CGFloat rightX = self.ball_centerX + leftXCha;
    CGFloat rightY  = halfH - smallR;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, halfH)];
    [bezier addLineToPoint:CGPointMake(leftX, halfH)];
    
    [bezier addArcWithCenter:CGPointMake(leftX, leftY) radius:smallR startAngle:M_PI_2 endAngle:M_PI_2-radian clockwise:0];
    [bezier addArcWithCenter:CGPointMake(self.ball_centerX, halfH) radius:bigR startAngle:-M_PI_2-radian endAngle:radian-M_PI_2 clockwise:1];
    [bezier addArcWithCenter:CGPointMake(rightX, rightY) radius:smallR startAngle:radian+M_PI_2 endAngle:M_PI_2 clockwise:0];
    
    [bezier addLineToPoint:CGPointMake(allW, halfH)];
    self.shapLayer.path = bezier.CGPath;
    self.shapLayer.strokeColor = [UIColor brownColor].CGColor;
    self.shapLayer.fillColor = [UIColor clearColor].CGColor;

    //对外
    if ([self.delegate respondsToSelector:@selector(reportBallDoMoving:)]) {
        [self.delegate reportBallDoMoving:self.ball_centerX];
    }
}

#pragma mark --Private getter & setter
- (UIView *)ballView
{
    if (_ballView == nil) {
        _ballView = [[UIView alloc] init];
        _ballView.backgroundColor = [UIColor redColor];
        _ballView.layer.cornerRadius = self.ballR;
        _ballView.layer.masksToBounds = YES;
        [self addSubview:_ballView];
    }
    return _ballView;
}

- (CAShapeLayer *)shapLayer
{
    if (_shapLayer == nil) {
        _shapLayer = [CAShapeLayer layer];
        _shapLayer.backgroundColor = [UIColor yellowColor].CGColor;
        [self.layer insertSublayer:_shapLayer atIndex:0];
    }
    return _shapLayer;
}

- (CGFloat)ball_centerX
{
    return _ball_centerX ? : (self.levelGap + self.ballR);
}

- (void)setBall_centerX:(CGFloat)ball_centerX
{
    if (ball_centerX < (self.levelGap + self.ballR)) {
        _ball_centerX = (self.levelGap + self.ballR);
    }
    else if (ball_centerX > (allW-self.levelGap-self.ballR)) {
        _ball_centerX = (allW-self.levelGap-self.ballR);
    }
    else {
        _ball_centerX = ball_centerX;
    }
}

#pragma mark --Public getter & setter

- (CGFloat)ballR
{
    return 10.f;
}

/**
 一个历程的长度,相邻中心点的距离
 
 @return float
 */
- (CGFloat)pointGap
{
    return (allW-2*(self.levelGap + self.ballR))/(self.pointCount-1);
}

/**
 view左|右<->superView左|右的距离
 
 @return float,默认30.f
 */
- (CGFloat)levelGap
{
    return _levelGap ? : 30.f;
}

- (NSInteger)pointCount
{
    return _pointCount ? : 3;
}

@end
