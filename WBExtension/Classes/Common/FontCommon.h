//
//  FontCommon.h
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/5.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#ifndef FontCommon_h
#define FontCommon_h

// 平方特细
#define CHINESE_PingFangThin(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Thin" size:(a)];\
font? font: [UIFont systemFontOfSize:(a)];\
})

#define FontThin(size) CHINESE_PingFangThin(size)

// 平方细体
#define CHINESE_PingFangLight(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Light" size:(a)];\
font? font: [UIFont systemFontOfSize:(a)];\
})

#define FontLight(size) CHINESE_PingFangLight(size)

// 平方常规
#define CHINESE_PingFangRegular(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:(a)];\
font? font: [UIFont systemFontOfSize:(a)];\
})
#define FontRegular(size) CHINESE_PingFangRegular(size)

// 平方中粗
#define CHINESE_PingFangMedium(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Medium" size:(a)];\
font? font: [UIFont boldSystemFontOfSize:(a)];\
})
#define FontMedium(size) CHINESE_PingFangMedium(size)


// 平方特粗

#define CHINESE_PingFangSemibold(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Semibold" size:(a)];\
font? font: [UIFont systemFontOfSize:(a)];\
})
#define FontSemibold(size) CHINESE_PingFangSemibold(size)


#endif /* FontCommon_h */
