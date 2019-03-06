//
//  SFTagView.h
//  TESTDEMO
//
//  Created by 蔡龙君 on 2017/10/17.
//  Copyright © 2017年 蔡龙君. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFTagViewConfig;
@interface SFTagView : UIView

- (instancetype)initWithItems:(NSArray<NSString *> *)items maxWidth:(CGFloat)maxWidth;
- (void)updateWithConfig:(void(^)(SFTagViewConfig *))config;
@end


@interface SFTagViewConfig : NSObject
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) UIColor * tagBorderColor;
@property (nonatomic, assign) CGFloat tagBorderWidth;
@property (nonatomic, assign) CGFloat tagCornerRadius;
@property (nonatomic, strong) UIFont * textFont;
/// 行间距
@property (nonatomic, assign) CGFloat  rowMargin;
/// 列间距
@property (nonatomic, assign) CGFloat  columnMargin;
+ (instancetype)defaultConfig;
@end
