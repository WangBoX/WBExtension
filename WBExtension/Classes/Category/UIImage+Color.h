//
//  UIImage+Color.h
//  QP_iOS
//
//  Created by ios on 16/6/24.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 压缩图片

 @param image image
 @return NSData
 */
+(NSData *)imageCompressData:(UIImage *)image;

//截图，获取UIImage
- (UIImage *)snapUIView:(UIView *)view ;

//高斯暗模糊效果
- (UIImage *)imageByBlurDark;
@end








