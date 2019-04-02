//
//  ZJRefeshFooter.m
//  ZJHJ-C
//
//  Created by WBO on 2017/8/28.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "ZJRefeshFooter.h"
#import "WBConfig.h"
@interface ZJRefeshFooter ()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *logo;
@end

@implementation ZJRefeshFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:@"e5e5e5"];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_imgBlue_78x78"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.frame = self.bounds;
    self.logo.size = CGSizeMake(40, 40);
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h*0.3 + self.logo.mj_h * 0.3);
    
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.logo.frame), kSCREEN_WIDTH, 40);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:{
            self.logo.hidden = YES;
            self.label.hidden = YES;
        }break;
        case MJRefreshStatePulling:{
            self.logo.hidden = NO;
            self.label.hidden = NO;
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
            animation.duration = 0.25;
            animation.cumulative = YES;
            animation.repeatCount = MAXFLOAT;
            [self.logo.layer addAnimation:animation forKey:@"logoTrans"];
            self.label.text = @"加载中...";
            
        }break;

        case MJRefreshStateRefreshing:{
            self.logo.hidden = NO;
            self.label.hidden = NO;
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
            animation.duration = 0.25;
            animation.cumulative = YES;
            animation.repeatCount = MAXFLOAT;
            [self.logo.layer addAnimation:animation forKey:@"logoTrans"];
            self.label.text = @"加载中...";
            
        }break;
        case MJRefreshStateNoMoreData:{
            self.logo.hidden = YES;
            self.label.text = @"没有更多数据了～";
        }break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}


@end
