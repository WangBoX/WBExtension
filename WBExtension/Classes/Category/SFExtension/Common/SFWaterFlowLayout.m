//
//  SFWaterFlowLayout.m
//  MoonGood
//
//  Created by 蔡龙君 on 2017/11/6.
//  Copyright © 2017年 MoonGood. All rights reserved.
//

#import "SFWaterFlowLayout.h"
#import "WBConfig.h"

/** 列数 */
static const NSInteger defaultColCount = 3;
/** 每一列间距 */
#define defaultColMargin kWIDTH(10)
/** 每一行间距 */
#define defaultRowMargin kWIDTH(10)
/** 边缘间距 */
#define defaultInsets UIEdgeInsetsMake(kWIDTH(10), kWIDTH(10), kWIDTH(10), kWIDTH(10))

@interface SFWaterFlowLayout ()
/** 布局属性数组 */
@property(nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property(nonatomic, strong) NSMutableArray *colHeights;

@end
@implementation SFWaterFlowLayout
- (instancetype)initWithDelegate:(id<SFWaterFlowLayoutDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}
#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray =  [NSMutableArray array];
        
    }
    return _attrsArray;
}

- (NSMutableArray *)colHeights {
    if (!_colHeights) {
        _colHeights =  [NSMutableArray array];
        
    }
    return _colHeights;
}

/**
 * 初始化操作
 */
- (void)prepareLayout {
    [super prepareLayout];
    // 如果刷新布局就会重新调用prepareLayout这个方法,所以要先把高度数组清空
    [self.colHeights removeAllObjects];
    
    // 每一列的高度都需要加上顶部偏移量
    for ( NSInteger i = 0; i < self.colCount; i++) {
        [self.colHeights addObject:@(self.currentEdgeInsets.top)];
    }
    //
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    [self.attrsArray removeAllObjects];
    
    for ( NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        // 获取indexPath对应cell的布局属性
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attr];
    }
    
}
/**
 *  返回indexPath位置cell的布局属性
 *
 *  @param indexPath indexPath
 *
 *  @return UICollectionViewLayoutAttributes
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 找出高度最短的那一列
    NSInteger destCol = 0;
    CGFloat minColHeight = [self.colHeights.firstObject doubleValue];
    
    for ( NSInteger i = 0; i < self.colCount; i++) {
        CGFloat colHeight = [self.colHeights[i] floatValue];
        if (minColHeight > colHeight) {
            minColHeight = colHeight;
            destCol = i;
        }
    }
    // 计算每个item宽度
    // (collectionView宽度 - 左右间距 - 列间距) / 总列数
    CGFloat w = (self.collectionView.frame.size.width - self.currentEdgeInsets.left - self.currentEdgeInsets.right - (self.colCount - 1) * self.colMargin) / self.colCount;
    // 使用代理决定外部cell的高度
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowAtIndex:indexPath.item itemWidth:w];
    CGFloat x = self.currentEdgeInsets.left + destCol * (w + self.colMargin);
    CGFloat y = minColHeight;
    if (y != self.currentEdgeInsets.top) {
        y += self.rowMargin;
    }
    attr.frame = CGRectMake(x, y, w, h);
    self.colHeights[destCol] = @(y + h);
    return attr;
}

/**
 *  这个方法返回值是个数组,存放的是UICollectionViewLayoutAttributes对象
 *  UICollectionViewLayoutAttributes对象决定了cell的排布方式
 *  @param rect rect description
 *
 *  @return  value description
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

/**
 *  决定collectionView的可滚动范围
 *
 *  @return return value description
 */
- (CGSize)collectionViewContentSize {
    CGFloat maxHeight = [self.colHeights.firstObject floatValue];
    
    for ( NSInteger i = 0; i < self.colCount; i++) {
        CGFloat value = [self.colHeights[i] floatValue];
        if (maxHeight < value) {
            maxHeight = value;
        }
    }
    
    CGSize  size = CGSizeMake(0, maxHeight + self.currentEdgeInsets.bottom);
    
    if (_delegate && [_delegate respondsToSelector:@selector(waterFlowLayout:collectionViewContentSize:)]) {
        [_delegate waterFlowLayout:self collectionViewContentSize:size];
    }
    
    return size;
}
/// 当 collectionView的显示范围发生变化时,会调用此方法来决定是否重新刷新 UI
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark -
#pragma mark - getter
- (NSInteger)colCount {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutCloumnCount:)]) {
        return  [self.delegate waterFlowLayoutCloumnCount:self];
    }
    else{
        return defaultColCount;
    }
    
}

- (CGFloat)colMargin {
    
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumMargin:)]) {
        return  [self.delegate waterFlowLayoutColumMargin:self];
    }
    else{
        return defaultColMargin;
    }
}

- (CGFloat)rowMargin {
    
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowMargin:)]) {
        return  [self.delegate waterFlowLayoutRowMargin:self];
    }
    else{
        return defaultRowMargin;
    }
}

- (UIEdgeInsets)currentEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutEdgeInset:)]) {
        return  [self.delegate waterFlowLayoutEdgeInset:self];
    }
    else {
        return defaultInsets;
    }
}
@end
