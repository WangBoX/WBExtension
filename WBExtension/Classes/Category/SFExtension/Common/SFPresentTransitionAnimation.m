//
//  SFPresentTransitionAnimation.m
//  ZJHJ-C
//
//  Created by 花菜 on 2017/10/13.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "SFPresentTransitionAnimation.h"

@implementation SFPresentTransitionAnimation

/// 定义动画效果
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //转场的容器图，动画完成之后会消失
    UIView *containerView =  [transitionContext containerView];
    UIView *fromView = nil;
    UIView *toView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    //对应关系
    BOOL isPresent = (toViewController.presentingViewController == fromViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if (isPresent) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width, 0);
        [containerView addSubview:toView];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresent) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width*0.3*-1, 0);
        }
    } completion:^(BOOL finished) {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        
        if (isCancelled)
            [toView removeFromSuperview];
        
        [transitionContext completeTransition:!isCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

@end
