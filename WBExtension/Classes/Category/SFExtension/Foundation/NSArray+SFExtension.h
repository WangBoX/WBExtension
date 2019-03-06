//
//  NSArray+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SFExtension)

/**
 数组随机排序

 @return 随机数组
 */
- (NSArray *)shuffleArray;
- (NSString *)toJSONString;
- (NSString *)toPrettyPrintedJSONString;
- (NSData *)toJSONData;
@end
@interface NSMutableArray (SFExtension)

/**
 随机数组
 */
- (void)shuffle;
@end
