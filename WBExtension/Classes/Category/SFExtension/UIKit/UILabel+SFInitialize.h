//
//  UILabel+SFInitialize.h
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/25.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SFInitialize)
+ (instancetype)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;
@end
