//
//  WBSettingTextViewController.m
//  QP_iOS
//
//  Created by ios on 16/6/27.
//  Copyright © 2016年 WBO. All rights reserved.
//

#import "WBSettingTextViewController.h"
#import "NSString+Common.h"
#import "WBConfig.h"


#define TEXTLIMIT 10

@interface WBSettingTextViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *myTextValue;

@end

@implementation WBSettingTextViewController

+ (instancetype)settingTextVCWithTitle:(NSString *)title
                       TextSettingType:(TextSettingType)textType
                             TextLimit:(NSInteger)textLimit
                             textValue:(NSString *)text doneBlock:(doneBlock)block{
    WBSettingTextViewController *setVC = [[WBSettingTextViewController alloc] init];
    setVC.title = title;
    setVC.textValue = text ? text:@"";
    setVC.textType = textType;
    setVC.textLimit = textLimit;
    setVC.doneBlock = block;
    return setVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    _myTextValue = [_textValue mutableCopy];
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = kMainbackgroundColor;
    [_myTableView registerClass:[WBTextSettingCell class] forCellReuseIdentifier:kCellIdentifier_SettingTextCell];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
}

- (void)setupNav{
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClick)];
    [self.navigationItem setRightBarButtonItem:doneBtn animated:YES];
    [self.navigationItem.rightBarButtonItem setTintColor:kMainDeepGrayColor];
}

- (void)doneBtnClick{
    
    if (self.doneBlock) {
        self.doneBlock(_myTextValue);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    return;
    
}

#pragma delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    WBTextSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_SettingTextCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textSettingType = _textType;
    [cell setTextWithTextValue:_textValue TextLimit:_textLimit WithTextChangeBlock:^(NSString *textValue) {
        weakSelf.myTextValue =textValue;
    }];
    
    cell.textField.delegate = self;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = 0.f;
    switch (_textType) {
        case TextSettingTypeOneLine:
            h = 44.f;
            break;
        case TextSettingTypeOneView:
            h = 200.f;
            break;
        default:
            h = 44.f;
            break;
    }
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _myTableView = nil;
}

@end
