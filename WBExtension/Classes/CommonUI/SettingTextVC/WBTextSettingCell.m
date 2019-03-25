//
//  WBTextSettingCell.m
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "WBTextSettingCell.h"
#import "NSString+Common.h"

@implementation WBTextSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_textField) {
            _textField = [[UITextField alloc] init];
            _textField.placeholder = @"未填写";
            _textField.font =  [UIFont systemFontOfSize:14];
            _textField.textAlignment = NSTextAlignmentLeft;
            _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//            _textField.delegate = self;
//            [_textField addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
            [self.contentView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(20);
                make.right.equalTo(self.contentView.mas_right).with.offset(-20);
                make.centerY.equalTo(self.contentView.mas_centerY);
            }];
            
            // 添加监听
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textFieldDidChanged:)
                                                         name:UITextFieldTextDidChangeNotification
                                                       object:self.textField];
        }
        if (!_textView) {

            _textView = [[UITextView alloc] init];
            _textView.font =  [UIFont systemFontOfSize:14];
            _textView.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_textView];
            [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            // 添加监听
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textViewDidChanged:)
                                                         name:UITextViewTextDidChangeNotification
                                                       object:_textView];
        }
    }
    return self;
}

// 以下为限制字符
- (void)textFieldDidChanged:(NSNotification *)notification {
    _textValue = [NSString textFieldDidChangedTextLimit:_textLimit textField:_textField];
    
    if (_textValue) {
        _textValueChangeBlock(_textValue);
    }
}
// 以下为限制字符
- (void)textViewDidChanged:(NSNotification *)notification {
    _textValue = [NSString textViewDidChangedTextLimit:_textLimit textView:_textView];
    
    if (_textValue) {
        _textValueChangeBlock(_textValue);
    }
}
- (void)setTextSettingType:(TextSettingType)textSettingType{
    _textSettingType = textSettingType;
    if (_textSettingType == TextSettingTypeOneLine) {
        _textView.hidden = YES;
        _textField.hidden = NO;
    }else{
        _textView.hidden = NO;
        _textField.hidden = YES;
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setTextWithTextValue:(NSString *)text
                   TextLimit:(NSInteger)textLimit
         WithTextChangeBlock:(void (^)(NSString *))block{
    
    if (_textSettingType == TextSettingTypeOneLine) {
        _textView.hidden = YES;
        _textField.hidden = NO;
        [_textView resignFirstResponder];
        [_textField becomeFirstResponder];
    }else{
        _textView.hidden = NO;
        _textField.hidden = YES;
        [_textField resignFirstResponder];
        [_textView becomeFirstResponder];
    }
    _textLimit = textLimit;
    if ([text isEqualToString:@"未填写"]) {
        _textValue = nil;
    }else{
        _textValue = text;
    }
    _textValueChangeBlock = block;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_textSettingType == TextSettingTypeOneLine) {
        _textField.text = _textValue;
    }else{
        _textView.text = _textValue;
    }
}

//- (void)textValueChange:(UITextField *)sender{
//    _textValue = [NSString textFieldDidChangedTextLimit:_textLimit textField:sender];
//
//    if (_textValue) {
//        _textValueChangeBlock(_textValue);
//    }
//}



@end








