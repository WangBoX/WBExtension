//
//  SFNewFeatureView.m
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/20.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "SFNewFeatureView.h"
#import "UIView+SFFrame.h"

NSString * const ZJUserShowMyLiCaiTotalAssetsKey = @"ZJUserCountieyeCodeKey";

NSString * const ZJBundleShortVersionString = @"CFBundleShortVersionString";

NSString * const ZJVersionStringKey = @"ZJVersionStringKey";

NSString * const ZJPushId = @"ZJPushId";

static NSInteger maxImageCount = 3;
@interface SFNewFeatureView ()<UIScrollViewDelegate>
/** 进入主界面 */
@property(nonatomic, strong) UIButton *enterButton;
/** 分页控件 */
@property(nonatomic, strong) UIPageControl *pageControl;
/** 内容视图 */
@property(nonatomic, strong) UIScrollView *contentView;
@end
@implementation SFNewFeatureView

- (void)initialize {
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.delegate = self;
    [self addSubview:self.pageControl];
    [self.enterButton addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    for ( NSInteger i = 0; i < maxImageCount; i++) {
        NSString * imageName = [NSString stringWithFormat:@"new_feature_%zd",i + 1];
        UIImage * image = [UIImage imageNamed:imageName];
        UIImageView * iv = [[UIImageView alloc]initWithImage:image];
        
        iv.frame = CGRectMake(i * width, 0, width, height);
        [self.contentView addSubview:iv];
    }
    self.contentView.contentSize = CGSizeMake((maxImageCount + 1) * width, height);
}

- (void)enterAction {
    [self removeFromSuperview];
}
- (UIButton *)enterButton {
    if (!_enterButton) {
        _enterButton =  [[UIButton alloc] init];
        [self addSubview:_enterButton];
        [_enterButton setBackgroundImage:[UIImage imageNamed:@"new_feature_button_icon"] forState:UIControlStateNormal];
        [_enterButton sizeToFit];
        _enterButton.hidden = YES;
    }
    return _enterButton;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl =  [[UIPageControl alloc] init];
        _pageControl.numberOfPages = maxImageCount;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.3];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.userInteractionEnabled = NO;
        [_pageControl sizeToFit];
    }
    return _pageControl;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView =  [[UIScrollView alloc] init];
        [self addSubview:_contentView];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.pageControl.currentPage = page;
    self.enterButton.hidden = YES;
    self.pageControl.hidden = page == scrollView.subviews.count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (page == scrollView.subviews.count) {
        [self enterAction];
    }
    if (self) {
        _enterButton.hidden = page != scrollView.subviews.count - 1;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.enterButton.sf_centerX = self.sf_centerX;
    self.enterButton.sf_y = kSCREEN_HEIGHT - 35 - 35;
    self.pageControl.sf_centerX = self.sf_centerX;
    self.pageControl.sf_y = self.enterButton.sf_maxY;
}


@end
