//
//  NSBundle+WBExtension.m
//  AFNetworking
//
//  Created by WangBo on 2019/4/1.
//

#import "NSBundle+WBExtension.h"
#import "WBCoreDevice.h"

@implementation NSBundle (WBExtension)
+ (instancetype)WB_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WBCoreDevice class]] pathForResource:@"WBExtension" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)WB_image:(NSString *)key
{
    UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self WB_refreshBundle] pathForResource:key ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    }
    return arrowImage;
}

@end
