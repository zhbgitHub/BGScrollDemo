//
//  JYReportBarView.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/29.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "JYReportBarView.h"
#import "JYReportBallView.h"
#import "JYReportZhuView.h"




#define zhuViewTag 787
#define allH  self.iFrame.size.height
#define allW  self.iFrame.size.width
#define halfH  self.iFrame.size.height * 0.5f
#define halfW  self.iFrame.size.width * 0.5f

@interface JYReportBarView () <JYReportBallViewDelegate>
@property (nonatomic, strong, readonly) JYReportBallView *ball_view;
@property (nonatomic, strong) NSArray<JYReportZhuView *> *barrel_array;
@property (nonatomic, assign, readonly) CGFloat  zhuView_W;
@property (nonatomic, assign) NSInteger  zhuView_previousTag;
@property (nonatomic, assign) BOOL  isChange;
@property (nonatomic, assign) CGRect  iFrame;
@end


@implementation JYReportBarView
@synthesize barrelCount = _barrelCount;
@synthesize ball_view   = _ball_view;
@synthesize percentArray = _percentArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iFrame = frame;
        [self ball_view];
        [self barrel_array];
    }
    return self;
}



#pragma mark -- ballView.delegate
- (void)reportBallDoMoving:(CGFloat)ballCenterX
{
    self.isChange = YES;
    double beiChu = ballCenterX - self.levelGap - self.ball_view.ballR;
    int quMo = round(beiChu/self.ball_view.pointGap);
    if (quMo != self.zhuView_previousTag) {
        JYReportZhuView *previousView = [self viewWithTag:_zhuView_previousTag+zhuViewTag];
        previousView.transform = CGAffineTransformIdentity;
        previousView.topLb.transform = CGAffineTransformIdentity;
        previousView.colorView.transform = CGAffineTransformIdentity;
        self.zhuView_previousTag = quMo;
    }
    
    JYReportZhuView *currentView = [self viewWithTag:quMo+zhuViewTag];
    CGFloat delta = fabs((currentView.center.x - ballCenterX));
    CGFloat sdd = fabs(self.ball_view.pointGap*0.5-delta);//对应最大比例
    CGFloat scaleW = (sdd/self.ball_view.pointGap*0.5)*(self.maxScale-1.f)+1.f;
    CGFloat scaleY = (sdd/self.ball_view.pointGap*0.5)*15+1.f;
    currentView.transform = CGAffineTransformMakeTranslation(0,-scaleY);
    currentView.topLb.transform = CGAffineTransformMakeScale(scaleW, scaleW);
    currentView.colorView.transform = CGAffineTransformMakeScale(scaleW, 1);
}

#pragma mark --Public getter & setter

- (void)setPercentArray:(NSArray<NSNumber *> *)percentArray
{
    _percentArray = percentArray;
    for (NSInteger i = 0; i < self.barrel_array.count; i++) {
        CGFloat number = [percentArray[i] floatValue];
        JYReportZhuView *subView = self.barrel_array[i];
        subView.percent = number;
    }
}

- (NSArray<NSNumber *> *)percentArray
{
    return _percentArray ? : [self demoValues];
}

- (CGFloat)levelGap
{
    return _levelGap ? : 20.f;
}

- (void)setBarrelCount:(NSInteger)barrelCount
{
    _barrelCount = barrelCount;
    self.ball_view.pointCount = barrelCount;
    [self.barrel_array makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.barrel_array = nil;
}

- (NSInteger)barrelCount
{
    return _barrelCount ? : 5;
}

- (CGFloat)maxScale
{
    return 4.f;
}


#pragma mark --Private getter & setter
- (JYReportBallView *)ball_view
{
    if (_ball_view == nil) {
        _ball_view = [[JYReportBallView alloc] init];
        _ball_view.delegate = (id)self;
        _ball_view.levelGap = self.levelGap;
        _ball_view.pointCount = self.barrelCount;
        [self addSubview:_ball_view];
        _ball_view.frame = CGRectMake(0, allH-35.f, allW, 35.f);

    }
    return _ball_view;
}

- (NSArray<JYReportZhuView *> *)barrel_array
{
    if (_barrel_array == nil) {
        NSInteger count = self.barrelCount;
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger i = 0; i < count; i++) {
            CGFloat h = allH - 35.f;
            CGFloat w = self.zhuView_W;
            CGFloat x = self.levelGap+self.ball_view.ballR-w*0.5+self.ball_view.pointGap*i;
            CGFloat y = CGRectGetMinY(self.ball_view.frame) - h + 10;
            JYReportZhuView *zhuView = [[JYReportZhuView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            zhuView.tag = zhuViewTag + i;
            [self addSubview:zhuView];
            [tmpArr addObject:zhuView];
        }
        _barrel_array = [tmpArr copy];
    }
    return _barrel_array ;
}

- (CGFloat)zhuView_W
{
    return self.ball_view.ballR*2.f + 15.f;
}

- (NSInteger)zhuView_previousTag
{
    return _zhuView_previousTag ? : 0;
}


#pragma mark --Private method
- (NSArray *)demoValues
{
    NSInteger count = self.barrelCount;
    NSMutableArray *defaulValues = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i<count; i++) {
        [defaulValues addObject:@((float)arc4random_uniform(101)/100.f)];
    }
    return [defaulValues copy];
}


@end
