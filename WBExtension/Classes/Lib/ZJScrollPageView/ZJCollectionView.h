//
//  ZJScrollView.h
//  ZJScrollPageView
//
//  Created by zhongjinghuijin on 16/10/24.
//  Copyright © 2016年 zhongjinghuijin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCollectionView : UICollectionView

typedef BOOL(^ZJScrollViewShouldBeginPanGestureHandler)(ZJCollectionView *collectionView, UIPanGestureRecognizer *panGesture);

- (void)setupScrollViewShouldBeginPanGestureHandler:(ZJScrollViewShouldBeginPanGestureHandler)gestureBeginHandler;

@end
