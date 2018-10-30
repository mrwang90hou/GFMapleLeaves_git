//
//  GKChangePassWordController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKChangePassWordController.h"
#import "GKTFCell.h"

@interface GKChangePassWordController ()
@property (nonatomic,strong)UIButton * saveBtn;

@property (nonatomic,strong)UITextField * oldTF;
@property (nonatomic,strong)UITextField * theNewTF;
@property (nonatomic,strong)UITextField * theNewTwoTF;

@property (nonatomic,strong)UILabel * oldPwdFooterLabel;
@property (nonatomic,strong)UILabel * theNewPwdFooterLabel;


@end

@implementation GKChangePassWordController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改绑定手机";
    self.view.backgroundColor = TABLEVIEW_BG;
    self.tableView.scrollEnabled = NO;
    
    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];
    [saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = GKMediumFont(17);
    self.saveBtn = saveBtn;
    [self nameChange];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)nameChange{
    if (self.oldTF.text.length > 0 && self.theNewTF.text.length > 0 && self.theNewTwoTF.text.length > 0){
        [self.saveBtn setTitleColor:SAVE_COLOR forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.saveBtn.userInteractionEnabled = YES;
    }else{
        [self.saveBtn setTitleColor:UIColorFromHex(0xCCCCCC) forState:UIControlStateNormal];
        self.saveBtn.userInteractionEnabled = NO;
    }
}

- (void)saveBtnClick{
    
    if ([self.oldTF.text isEqualToString:self.theNewTF.text]) {
        self.theNewPwdFooterLabel.text = @"新密码不能与原密码一致";
        self.theNewPwdFooterLabel.hidden = NO;
    }else if(![self.theNewTF.text isEqualToString:self.theNewTwoTF.text]){
        self.theNewPwdFooterLabel.text = @"两次输入的新密码不一致";
        self.theNewPwdFooterLabel.hidden = NO;
    }else{
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        self.theNewPwdFooterLabel.hidden = YES;
        self.oldPwdFooterLabel.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKTFCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKTFCell"];
    if (cell == nil) {
        cell = [[GKTFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKTFCell"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.eyeBtn.hidden = NO;
    [cell.phoneTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cell.phoneTF.superview).with.offset(-50);
    }];
    
    if (indexPath.section == 0) {
        cell.phoneTF.placeholder = @"请输入旧密码";
        cell.phoneTF.secureTextEntry = YES;
        self.oldTF = cell.phoneTF;
    }else if (indexPath.section == 1) {
        cell.phoneTF.placeholder = @"请输入新密码";
//        cell.eyeBtn.selected = YES;
        cell.phoneTF.secureTextEntry = YES;
        self.theNewTF = cell.phoneTF;
    }else{
        cell.phoneTF.placeholder = @"再次确认密码";
//        cell.eyeBtn.selected = YES;
        cell.phoneTF.secureTextEntry = YES;
        self.theNewTwoTF = cell.phoneTF;
    }
    [cell.phoneTF addTarget:self action:@selector(nameChange) forControlEvents:UIControlEventEditingChanged];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    UILabel * headerLabel = [UILabel new];
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(headerView);
        make.left.mas_equalTo(headerView).with.offset(15);
        make.right.mas_equalTo(headerView).with.offset(-15);
    }];
    
    if (section == 0) {
        headerLabel.text = @"旧密码";
    }else if (section == 1) {
        headerLabel.text = @"新密码";
    }
    
    headerLabel.numberOfLines = 0;
    headerLabel.textColor = UIColorFromHex(0x2C2C2C);
    headerLabel.font = GKMediumFont(12);
    headerLabel.textAlignment = NSTextAlignmentLeft;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    UILabel * footerLabel = [UILabel new];
    [footerView addSubview:footerLabel];
    [footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(footerView);
        make.left.mas_equalTo(footerView).with.offset(25);
        make.right.mas_equalTo(footerView).with.offset(-25);
    }];
    if (section == 0) {
        footerLabel.text = @"输入的原密码不匹配";
        self.oldPwdFooterLabel = footerLabel;
    }else if (section == 2) {
        footerLabel.text = @"两次输入的新密码不一致";
        self.theNewPwdFooterLabel = footerLabel;
    }
    
    footerLabel.textColor = UIColorFromHex(0xFF4055);
    footerLabel.font = GKFont(12);
    footerLabel.textAlignment = NSTextAlignmentLeft;
    footerLabel.hidden = YES;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) return .1;
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 2) return 10;
    else return 33;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
