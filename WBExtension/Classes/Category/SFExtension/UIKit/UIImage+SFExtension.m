//
//  UIImage+SFExtension.m
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/26.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "UIImage+SFExtension.h"
#import <Accelerate/Accelerate.h>
#import "WBConfig.h"


@implementation UIImage (SFExtension)
#pragma mark -
#pragma mark - 控件截图
+ (UIImage *)sf_imageWithcaptureView:(UIView *)view {
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 将控件上的图层渲染上下文
    [view.layer renderInContext:ctx];
    
    // 生成图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -
#pragma mark - 快速生成二维码
+ (UIImage *)sf_createQRCodeWithInputData:(NSData *)inputData size:(CGFloat)size
{
    return [UIImage sf_createQRCodeWithInputData:inputData centerImage:nil size:size];
}

#pragma mark -
#pragma mark - 快速生成中间有图片的二维码
+ (UIImage *)sf_createQRCodeWithInputData:(NSData *)inputData  centerImage:(UIImage *)centerImage size:(CGFloat)size
{
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.设置相关属性
    [filter setDefaults];
    // 3.设置输入源
    [filter setValue:inputData forKeyPath:@"inputMessage"];
    // 4.获取输出结果(直接使用该图片显示到view上会比较模糊)
    CIImage *outputImage = [filter outputImage];
    // 5.图片处理
    CGAffineTransform transform = CGAffineTransformMakeScale(20, 20);
    outputImage = [outputImage imageByApplyingTransform:transform];
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    //    UIImage *image =  [UIImage cf_createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    if (centerImage) {
        
        UIImageView *imageView =[self imageViewWithImage:image centerImage:centerImage];
        
        return [UIImage sf_imageWithcaptureView:imageView]; // 控件截图
    }else {
        return image;
    }
}
+ (UIImageView *)imageViewWithImage:(UIImage *)image centerImage:(UIImage *)centerImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    UIImageView *centerImageView = [[UIImageView alloc]init];
    
    CGFloat centerImageHW = 120; // 设置默认宽高
    // 居中显示
    CGFloat centerImageX = (imageView.bounds.size.width - centerImageHW) * 0.5;
    CGFloat centerImageY = (imageView.bounds.size.height - centerImageHW) * 0.5;;
    // 设置frame
    centerImageView.frame = CGRectMake(centerImageX, centerImageY, centerImageHW, centerImageHW);
    centerImageView.image = centerImage;
    centerImageView.layer.borderWidth = 3; // 默认边框宽度
    centerImageView.layer.cornerRadius = 20;// 默认圆角半径
    centerImageView.layer.borderColor = [UIColor lightTextColor].CGColor;//默认边框颜色
    centerImageView.layer.masksToBounds = YES;
    [imageView addSubview:centerImageView];
    return imageView;
}
//对图片尺寸进行压缩
+ (UIImage*)sf_imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage *)sf_blurImage:(UIImage *)image blur:(CGFloat)blur {
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        DebugLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        DebugLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

// 按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
- (UIImage *)sf_imageCompressForTargetSize:(CGSize)size {
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        DebugLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}


// 指定宽度按比例缩放
- (UIImage *)sf_imageCompressForTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    return [self sf_imageCompressForTargetSize:size];
}

- (UIImage *)sf_drawRectWithRadius:(CGFloat)radius size:(CGSize)size borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    // 获取宽高最小值,保证是正圆
    CGFloat ovalWH = MIN(size.width, size.height);
    CGRect rect = CGRectMake(0, 0, ovalWH, ovalWH);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(ovalWH, ovalWH)];
    CGContextAddPath(ref, path.CGPath);
    CGContextClip(ref);
    [self drawInRect:rect];
    // 创建内边框路径
    UIBezierPath * ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    // 设置边框颜色
    [borderColor setStroke];
    // 设置边框宽度
    ovalPath.lineWidth = borderWidth;
    // 绘制边框
    [ovalPath stroke];
    CGContextDrawPath(ref, kCGPathFillStroke);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
