//
//  JYReportZhuView.m
//  Quaze2DTest
//
//  Created by ioszhb on 2017/8/28.
//  Copyright © 2017年 ioszhb. All rights reserved.
//

#import "JYReportZhuView.h"
#define allH  self.iFrame.size.height
#define allW  self.iFrame.size.width

@interface JYReportZhuView ()


@property (nonatomic, assign, readonly) CGFloat topLb_H;
@property (nonatomic, assign, readonly) CGFloat bott_H;
@property (nonatomic, assign, readonly) CGFloat line_H;
@property (nonatomic, assign, readonly) CGFloat color_H;

@property (nonatomic, assign, readonly) CGFloat topLb_Y;
@property (nonatomic, assign, readonly) CGFloat bott_Y;
@property (nonatomic, assign, readonly) CGFloat line_Y;
@property (nonatomic, assign, readonly) CGFloat color_Y;

@property (nonatomic, assign, readonly) CGFloat top_Gap;
@property (nonatomic, assign, readonly) CGFloat bottom_Gap;


@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, strong) UILabel *bottomLb;
@property (nonatomic, assign) CGRect iFrame;

@end


@implementation JYReportZhuView
@synthesize percent = _percent;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iFrame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.01f;
        [self setUpSubviewsFrame];
    }
    return self;
}

- (void)setUpSubviewsFrame
{
    self.topLb.frame = CGRectMake(0, self.topLb_Y, allW, self.topLb_H);
    self.bottomLb.frame = CGRectMake(0, self.bott_Y, allW, self.bott_H);
    self.lineView.frame = CGRectMake((self.allW-1.0)*0.5,self.line_Y, 1.f, self.line_H);
    CGFloat colorW = 8.f;
    CGFloat colorX = (allW-colorW)*0.5f;
    self.colorView.frame = CGRectMake(colorX, self.color_Y, colorW, self.color_H);
}

#pragma mark -- public getter & setter
- (CGFloat)percent
{
    return _percent ? : 0.5f;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    [self setUpSubviewsFrame];
}



- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    [self setNeedsLayout];
}


#pragma mark -- Private getter & setter

- (UILabel *)topLb
{
    if (_topLb == nil) {
        _topLb = [[UILabel alloc] init];
        _topLb.backgroundColor = [UIColor clearColor];
        _topLb.textAlignment = NSTextAlignmentCenter;
        _topLb.textColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        _topLb.font = [UIFont systemFontOfSize:11.f];
        _topLb.text = @"80%";
        _topLb.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:_topLb];
    }
    return _topLb;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

- (UIView *)colorView
{
    if (_colorView == nil) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor redColor];
        [self addSubview:_colorView];
    }
    return _colorView;
}

- (UILabel *)bottomLb
{
    if (_bottomLb == nil) {
        _bottomLb = [[UILabel alloc] init];
        _bottomLb.backgroundColor = [UIColor clearColor];
        _bottomLb.textAlignment = NSTextAlignmentCenter;
        _bottomLb.textColor = [UIColor colorWithWhite:0.5 alpha:0.8];
        _bottomLb.font = [UIFont systemFontOfSize:11.f];
        _bottomLb.text = @"进件";
        [self addSubview:_bottomLb];
    }
    return _bottomLb;
}

#pragma mark 数据

- (CGFloat)topLb_H
{
    return 24.f;
}

- (CGFloat)bott_H
{
    return 20.f;
}

- (CGFloat)line_H
{
    return (allH - self.topLb_H - self.bott_H - self.top_Gap - self.bottom_Gap - self.color_H);
}

- (CGFloat)color_H
{
    return (allH - self.topLb_H - self.bott_H - self.top_Gap - self.bottom_Gap) * self.percent;
}

- (CGFloat)topLb_Y
{
    return (self.top_Gap);
}

- (CGFloat)bott_Y
{
    return (allH - self.bottom_Gap - self.bott_H);
}

- (CGFloat)line_Y
{
    return (self.top_Gap + self.topLb_H);
}

- (CGFloat)color_Y
{
    return self.line_H + self.line_Y;
}

- (CGFloat)top_Gap
{
    return 20.f;
}

- (CGFloat)bottom_Gap
{
    return 2.f;
}

@end
