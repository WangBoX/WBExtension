//
//  SFTagView.m
//  TESTDEMO
//
//  Created by 蔡龙君 on 2017/10/17.
//  Copyright © 2017年 蔡龙君. All rights reserved.
//

#import "SFTagView.h"
#import "UIView+SFFrame.h"


@interface SFTagView()
@property (nonatomic, strong) NSArray<NSString *> * items;
@property (nonatomic, strong) NSMutableArray * labelWidthArray;
@property (nonatomic, strong) SFTagViewConfig * config;
@property (nonatomic, assign) CGFloat maxWidth;
@end

@implementation SFTagView
- (instancetype)initWithItems:(NSArray<NSString *> *)items maxWidth:(CGFloat)maxWidth {
    if (self = [super init]) {
        _items = items;
        _maxWidth = maxWidth;
        [self initializeSubviews];
    }
    return self;
}
/// 初始化子控件
- (void)initializeSubviews {
    
    for (NSString * title in _items) {
        UILabel * label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"  %@  ", title];
        [self configLabel:label];
        [self addSubview:label];
    }
}
/// 更新配置
- (void)updateWithConfig:(void(^)(SFTagViewConfig *))config {
    if (config) {
        config(self.config);
        /// 清空宽度数组
        [self.labelWidthArray removeAllObjects];
        for (UIView * view in self.subviews) {
            UILabel * label = (UILabel *)view;
            [self configLabel:label];
        }
        // 添加需要重新布局标记
        [self setNeedsLayout];
        // 重新布局
        [self layoutIfNeeded];
    }
}

- (void)configLabel:(UILabel *)label {
    
    label.textColor = self.config.textColor;
    label.layer.cornerRadius = self.config.tagCornerRadius;
    label.layer.borderColor = self.config.tagBorderColor.CGColor;
    label.layer.borderWidth = self.config.tagBorderWidth;
    label.font = self.config.textFont;
    [label sizeToFit];
    // 保存宽度 宽度取整
    [self.labelWidthArray addObject:@(ceilf(label.bounds.size.width))];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        CGFloat labelWidth = [self.labelWidthArray[i] floatValue];
        UIView * view = self.subviews[i];
        if (i > 0) {
            // 去除上一个控件的宽度最大X + 列间距
            UIView * lastView = self.subviews[i - 1];
            
            
            x =  lastView.sf_maxX + self.config.columnMargin;
            // 如果x + 宽度 > 控件宽度就换行
            if (x + labelWidth > self.maxWidth) {
                x = 0;
                // 添加行间距
                y = ceilf(lastView.sf_maxY + self.config.rowMargin);
            }
        }
        view.frame =  CGRectMake(x, y, labelWidth, ceilf(view.sf_height));
    }
    
    /// 取出最后一个控件获取高度
    UIView * view = self.subviews.lastObject;
    if (view) {
        CGRect tmpRect = self.frame;
        tmpRect.size.height = view.sf_maxY;
        self.frame = tmpRect;
        self.height = view.sf_maxY;
    }
}


- (NSMutableArray *)labelWidthArray {
    if (!_labelWidthArray) {
        _labelWidthArray = [[NSMutableArray alloc] init];
    }
    return _labelWidthArray;
}
- (SFTagViewConfig *)config {
    if (!_config) {
        _config = [SFTagViewConfig defaultConfig];
    }
    return _config;
}

@end

@implementation SFTagViewConfig
+ (instancetype)defaultConfig {
    SFTagViewConfig * config = [SFTagViewConfig new];
    config.textFont = FontLight(kWIDTH(12));
    config.textColor = HexColor(@"0xFF96");
    config.tagBorderColor =  HexColor(@"0xFF96");
    config.tagBorderWidth = 0.5f;
    config.tagCornerRadius = kCornerRadius;
    config.rowMargin = 10;
    config.columnMargin = 10;
    return config;
}
@end
