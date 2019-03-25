//
//  WBTextSettingCell.h
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@import YYText;
@import Masonry;

#define kCellIdentifier_SettingTextCell @"TextSettingCell"



typedef NS_ENUM(NSUInteger, TextSettingType) {
    TextSettingTypeOneLine = 0,
    TextSettingTypeOneView
};


@interface WBTextSettingCell : UITableViewCell<UITextFieldDelegate, UITextFieldDelegate, YYTextViewDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *textValue;
@property (nonatomic, assign) NSInteger textLimit;
@property (nonatomic, assign) TextSettingType textSettingType;

@property (nonatomic, copy) void (^textValueChangeBlock)(NSString *text);

- (void)setTextWithTextValue:(NSString *)text
                   TextLimit:(NSInteger)textLimit
         WithTextChangeBlock:(void(^)(NSString *textValue))block;

@end


