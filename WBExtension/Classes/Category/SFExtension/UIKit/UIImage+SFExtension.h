//
//  UIImage+SFExtension.h
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/26.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SFExtension)
+ (UIImage *)sf_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size;
/**
 *  快速生成中间有图片的二维码
 *
 *  @param inputData   输入源(需要转换成二维码的数据)
 *  @param centerImage 显示在中间的图片(默认尺寸90 * 90) 边框宽度:5 圆角半径:10 边框颜色:白色
 *  @param size        生成二维码的宽高
 *
 */
+ (UIImage *)sf_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size;

//对图片尺寸进行压缩
+ (UIImage*)sf_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)sf_blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 等比例缩放
 
 @param size        需要显示的区域
 
 @return 新的图片
 */
- (UIImage *)sf_imageCompressForTargetSize:(CGSize)size ;

/**
 按固定宽度等比缩放图片
 @param targetWidth 需要固定的宽度
 
 @return 新的图片
 */
- (UIImage *)sf_imageCompressForTargetWidth:(CGFloat)targetWidth;


- (UIImage *)sf_drawRectWithRadius:(CGFloat)radius size:(CGSize)size borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
