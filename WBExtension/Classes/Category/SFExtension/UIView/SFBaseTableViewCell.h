//
//  SFBaseTableViewCell.h
//  ZJHJ-C
//
//  Created by 蔡龙君 on 2017/9/25.
//  Copyright © 2017年 zhongjinghuijin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFBaseTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView reusableIdentifier:(NSString *)reusableIdentifier;
- (void)initialize;
- (void)configWithData:(id)data;
@end
