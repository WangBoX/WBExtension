//
//  NavHeadTitleView.m
//  ZJHJ-C
//
//  Created by WBO on 2017/10/16.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "NavHeadTitleView.h"
#import "WBConfig.h"

@import Masonry;
#define kLeftBtnW 60
#define kRightBtnW 60

@implementation NavHeadTitleView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.headBgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor=kMainDeepGrayColor;
        self.headBgView.alpha=0;
        [self addSubview:self.headBgView];
        
        
        self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.backgroundColor=[UIColor clearColor];
        self.leftBtn.frame=CGRectMake(0, (isX ? 30 : 20),  kLeftBtnW, frame.size.height-20);
        [self.leftBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self.leftBtn setImage:[UIImage imageNamed:@"nav_choose"] forState:UIControlStateNormal];
        [self addSubview:self.leftBtn];
        
        self.backgroundColor=[UIColor clearColor];
        self.titleLabel=[[YYLabel alloc]initWithFrame:CGRectZero];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftBtn.mas_centerY);
            make.left.equalTo(self).offset(kLeftBtnW);
            make.right.equalTo(self).offset(-kRightBtnW);
        }];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        [self.leftBtn setImage:[UIImage imageNamed:@"nav_scan"] forState:UIControlStateNormal];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-kRightBtnW, (isX ? 30 : 20), kRightBtnW, frame.size.height-20);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.rightBtn];
        
    }
    return self;
}

//返回按钮
-(void)backClick{
    if ([_delegate respondsToSelector:@selector(navHeaderback)] ) {
        [_delegate navHeaderback];
    }
}
//右边按钮
-(void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(navHeaderRightAction)]) {
        [_delegate navHeaderRightAction];
    }
}
@end
