//
//  UIView+SFAnimation.m
//  MoonGood
//
//  Created by 蔡龙君 on 2017/11/1.
//  Copyright © 2017年 MoonGood. All rights reserved.
//

#import "UIView+SFAnimation.h"

@implementation UIView (SFAnimation)
- (void)sf_shakeAnimation {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.removedOnCompletion = YES;
    animation.duration = 0.5;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"transformAni"];
}
@end
