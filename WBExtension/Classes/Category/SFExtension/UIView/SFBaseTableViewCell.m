//
//  SFBaseTableViewCell.m
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/25.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import "SFBaseTableViewCell.h"
@implementation SFBaseTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * reusableIdentifier = [NSString stringWithFormat:@"%@ReusableIdentifier",self];
    
    return [self cellWithTableView:tableView reusableIdentifier:reusableIdentifier];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView reusableIdentifier:(NSString *)reusableIdentifier {
    SFBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    DebugLog(@"%@",self);
}
- (void)configWithData:(id)data {
    
}

@end
