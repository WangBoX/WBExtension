//
//  WBSettingTextViewController.h
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTextSettingCell.h"

typedef void(^doneBlock)(NSString *textValue);

@interface WBSettingTextViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSString *textValue;
@property (nonatomic, assign) TextSettingType textType;
@property (nonatomic, assign) NSInteger textLimit;
@property (nonatomic, strong) doneBlock doneBlock;



/**
 设置文本接口

 @param title 页面title
 @param textType 文本模式
 @param textLimit 文本限制字数
 @param text 初始化文本
 @param block 修改后的block
 @return vc
 */
+ (instancetype)settingTextVCWithTitle:(NSString *)title
                       TextSettingType:(TextSettingType)textType
                             TextLimit:(NSInteger)textLimit
                             textValue:(NSString *)text doneBlock:(doneBlock)block;



@end
