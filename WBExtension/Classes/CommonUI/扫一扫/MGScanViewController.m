//
//  MGScanViewController.m
//  MoonGood
//
//  Created by 蔡龙君 on 2017/12/6.
//  Copyright © 2017年 MoonGood. All rights reserved.
//

#import "MGScanViewController.h"
#import "LBXScanViewStyle.h"
#import "WBConfig.h"
#import "UIImage+Color.h"
#import "WBCamera.h"

@import Masonry;
@interface MGScanViewController ()

#pragma mark - 底部几个功能：开启闪光灯、相册
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;

@property (nonatomic, strong) UIButton * dissMissButton;
@property (nonatomic, copy) ScanResultsBlock scanResultsBlock;

@end

@implementation MGScanViewController

- (void)scanResultCompletion:(ScanResultsBlock)complte{
    
    self.scanResultsBlock = complte;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
    
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        self.view.backgroundColor = [UIColor blackColor];
    
        //设置扫码后需要扫码图像
        self.isNeedScanImage = YES;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawBackBtn];;
    [self drawBottomItems];
    [self.view bringSubviewToFront:self.dissMissButton];
}


- (void)drawBackBtn {
    UIImage *img1 = [NSBundle WB_image:@"qrcode_scan_back_nor@2x"];
    
    UIButton * dissMissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dissMissButton addTarget:self action:@selector(dissMissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [dissMissButton setImage:img1 forState:UIControlStateNormal];
    [self.view addSubview:dissMissButton];
    [dissMissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kWIDTH(kPidding));
        make.top.equalTo(self.mas_topLayoutGuide);
        make.width.height.mas_equalTo(kWIDTH(40));
    }];
    self.dissMissButton = dissMissButton;
}

- (void)drawBottomItems
{
    if (_bottomItemsView) {
        
        return;
    }
    
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                   CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:_bottomItemsView];
    
    
    self.btnFlash = [[UIButton alloc]init];
    [_btnFlash setImage:[NSBundle WB_image:@"qrcode_scan_flash_nor@2x"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto = [[UIButton alloc]init];
    [_btnPhoto setImage:[NSBundle WB_image:@"qrcode_scan_photo_nor@2x"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[NSBundle WB_image:@"qrcode_scan_photo_down@2x"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    [self.btnFlash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        make.centerY.equalTo(self.bottomItemsView.mas_centerY);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(87);
    }];
    [self.btnPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(20);
        make.centerY.equalTo(self.bottomItemsView.mas_centerY);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(87);
    }];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    //设置了委托的处理
    
    self.scanResultsBlock(array);
    
    
    [self dissMissButtonAction];
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)dissMissButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    
    if ([WBCamera checkPhotoLibraryAuthorizationStatus]) {
        [self openLocalPhoto:NO];
    }else{
        [NSObject showHudTipStr:@"没有相册权限，请前往设置开启"];
    }
    
}

//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[NSBundle WB_image:@"qrcode_scan_off@2x"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[NSBundle WB_image:@"qrcode_scan_flash_nor@2x"] forState:UIControlStateNormal];
}





@end
