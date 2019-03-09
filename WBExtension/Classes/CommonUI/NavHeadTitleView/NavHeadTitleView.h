//
//  NavHeadTitleView.h
//  ZJHJ-C
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import <UIKit/UIKit.h>
@import YYText;

@protocol NavHeadTitleViewDelegate <NSObject>
@optional
- (void)navHeaderback;
- (void)navHeaderRightAction;
@end
@interface NavHeadTitleView : UIView

@property(nonatomic,assign)id<NavHeadTitleViewDelegate>delegate;
@property(nonatomic,strong)UIImageView * headBgView;
@property(nonatomic,strong)YYLabel *titleLabel;
@property(nonatomic,strong)UIButton * leftBtn;
@property(nonatomic,strong)UIButton * rightBtn;

@end
