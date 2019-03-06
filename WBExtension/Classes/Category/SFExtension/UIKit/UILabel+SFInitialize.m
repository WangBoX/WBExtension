//
//  UILabel+SFInitialize.m
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/25.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "UILabel+SFInitialize.h"

@implementation UILabel (SFInitialize)
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment; {
    UILabel * label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = font;
    if (text) {
        label.text = text;
        [label sizeToFit];
    }
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    return [self labelWithText:nil textColor:textColor font:font textAlignment:textAlignment];
}
@end
