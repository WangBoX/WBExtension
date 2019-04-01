//
//  MGScanViewController.h
//  MoonGood
//
//  Created by 蔡龙君 on 2017/12/6.
//  Copyright © 2017年 MoonGood. All rights reserved.
//


#import <LBXScan/LBXScanViewController.h>
@import LBXScan;

typedef void(^ScanResultsBlock)(NSArray<LBXScanResult*>* results);

@interface MGScanViewController : LBXScanViewController


- (void)scanResultCompletion:(ScanResultsBlock)complte;

@end
