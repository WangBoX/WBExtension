//
//  SFWaterFlowLayout.h
//  MoonGood
//
//  Created by 蔡龙君 on 2017/11/6.
//  Copyright © 2017年 MoonGood. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFWaterFlowLayout;

@protocol SFWaterFlowLayoutDelegate <NSObject>
@required

/**
 决定cell的高度必须实现
 
 @param waterFlowLayout 布局本身
 @param index 索引
 @param width 宽度
 @return cell的高度
 */
- (CGFloat)waterFlowLayout:(SFWaterFlowLayout *)waterFlowLayout heightForRowAtIndex:(NSInteger)index itemWidth:(CGFloat)width;
@optional
///决定cell的列数
- (NSInteger)waterFlowLayoutCloumnCount:(SFWaterFlowLayout *)waterFlowLayout;
///决定cell 的列的距离
- (CGFloat)waterFlowLayoutColumMargin:(SFWaterFlowLayout *)waterFlowLayout;
///决定cell 的行的距离
- (CGFloat)waterFlowLayoutRowMargin:(SFWaterFlowLayout *)waterFlowLayout;
///决定cell 的边缘间距
- (UIEdgeInsets)waterFlowLayoutEdgeInset:(SFWaterFlowLayout *)waterFlowLayout;
///决定cell 的边缘间距
/**
 collectionView的滚动范围

 @param waterFlowLayout waterFlowLayout
 @param collectionViewContentSize collectionViewContentSize
 */
- (void)waterFlowLayout:(SFWaterFlowLayout *)waterFlowLayout collectionViewContentSize:(CGSize)collectionViewContentSize;
@end
@interface SFWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic, weak) id<SFWaterFlowLayoutDelegate> delegate;
- (instancetype)initWithDelegate:(id<SFWaterFlowLayoutDelegate>)delegate;
- (NSInteger)colCount;
- (CGFloat)colMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)currentEdgeInsets;
@end
