//
//  WBConfig.h
//  WBExtension
//
//  Created by WangBo on 2019/3/6.
//

#ifndef WBConfig_h
#define WBConfig_h


#ifdef DEBUG
#define DebugLog(format, ...) NSLog((@"调试：[函数名:%s]" "[行号:%d]\n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DebugLog(xx, ...)
#endif
/**************************** Config ****************************/
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppBunbleID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] // 获取APP包名
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]   // 获取APP名字
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] // 获取当前版本
// 获取当前语言
#define kCURRENT_LANGUAGR ([[NSLocale preferredLanguages] objectAtIndex:0])
// 判断是否为iPhone
#define SFiSiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define SFiSiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define isEmpty(x) [NSObject isEmpty:x]
#define kCornerRadius 3
#define RMB @"¥"


#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kdefaultUserAvatar [UIImage imageNamed:@"default_user_icon"]
#define kdefaultShopAvatar [UIImage imageNamed:@"my_shop_home_dianpumourentoux_icon"]
#define kdefaultGoodsAvatar [UIImage imageNamed:@"default_goods_icon"]



/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/**************************** Frame ****************************/
#define kSCREEN_BOUNDS [UIScreen mainScreen].bounds
// 获取屏幕宽度与高度
#define kSCREEN_WIDTH \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kSCREEN_SIZE \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)


// 由角度转换弧度
#define SFDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度转换角度
#define SFRadianToDegrees(radian) (radian * 180.0) / (M_PI)

// 屏幕宽度比例
#define kWidthScale ((kSCREEN_WIDTH / 375))
// 屏幕高度比例
#define kHeightScale ((kSCREEN_HEIGHT / 667))
// 获取宽度比例
#define kWidthRatio  (kSCREEN_WIDTH / 375.0)
// 获取高度比例
#define kHeightRatio (kSCREEN_HEIGHT / 667.0)

// 根据2x/ 3x 计算宽高
// #define XXScreenRatio ((XXScreenWidth == 414) ? 1 : (375 / 414.0))
// 适配宽度
#define kWIDTH(width)  (ceilf((width) * kWidthRatio))
// 适配高度
#define kHEIGHT(height) (ceilf((height) * kHeightRatio))

/// 状态栏高度
#define kStatusBarHeight (isX ? 40 : 20)
#define kPidding                     20.f
#define kMargin                      10.f
#define kNAVBAR_HEIGHT               (isX? 88 : 44)
#define kTABVBAR_HEIGHT               (isX? 83 : 49)
/**************************** iPhoneX & iOS 11****************************/
#define SafeAreaTopHeight (kSCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (kSCREEN_WIDTH == 812.0 ? 44 : 0)

#define  AdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

/**************************** Color ****************************/
#define kMainDeepGrayColor [UIColor colorWithHexString:@"6b6358"]
#define kMainLightGrayColor [UIColor colorWithHexString:@"a8a6a2"]
#define kMainbackgroundColor [UIColor colorWithHexString:@"F5F6F7"]//背景色
#define kLayerBorderColor [UIColor colorWithHexString:@"eaeaea"]//描边背景色
#define kMainRedColor [UIColor colorWithHexString:@"c40000"]//主题红色
#define kBlackColr [UIColor colorWithHexString:@"333333"]//黑色
#define kDesTextColr [UIColor colorWithHexString:@"7d828a"]//描述文字颜色

#define kLineColor  [UIColor colorWithHexString:@"eaeaea"]//分割线灰色
#define kCellPressColor  [UIColor colorWithHexString:@"fafafa"]//点击的灰色效果颜色

/**************************** 设备相关 ****************************/
#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define isX ([UIScreen mainScreen].bounds.size.height == 812)

#define kDevice_Is_iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6sPlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

//dispatch_async_main_safe(^{
//
//});
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#define kTipAlert(_title_, _msg_, _cancel_, _done_,...)     [[[UIAlertView alloc] initWithTitle[NSString stringWithFormat:(_title_), ##__VA_ARGS__] message:[NSString stringWithFormat:(_msg_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:[NSString stringWithFormat:(_cancel_), ##__VA_ARGS__] otherButtonTitles:[NSString stringWithFormat:(_done_), ##__VA_ARGS__]] show]


#endif /* WBConfig_h */
