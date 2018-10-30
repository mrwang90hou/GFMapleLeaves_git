//
//  GKChangePhoneController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/3.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKChangePhoneController.h"
 
#import "GKCheckCodeCell.h"
#import "GKCountrySelectCell.h"
#import "GKTFCell.h"

@interface GKChangePhoneController ()
@property (nonatomic,strong) GKButton * codeBtn;
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * codeTF;
@property (nonatomic,strong)UIButton * saveBtn;
@property (nonatomic,strong)UILabel * footerLabel;

@end

@implementation GKChangePhoneController

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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        GKCountrySelectCell *cell = [[GKCountrySelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKCountrySelectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        GKTFCell *cell = [[GKTFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKTFCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.phoneTF = cell.phoneTF;
        [cell.phoneTF addTarget:self action:@selector(nameChange) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else{
        GKCheckCodeCell *cell = [[GKCheckCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKCheckCodeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.codeTF = cell.codeTF;
        self.codeBtn = cell.codeBtn;
        [cell.codeTF addTarget:self action:@selector(nameChange) forControlEvents:UIControlEventEditingChanged];
        [cell.codeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
        headerLabel.text = @"手机号码归属地";
    }else if (section == 1) {
        headerLabel.text = @"安全手机号码";
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
    footerLabel.text = @"验证码错误";
    footerLabel.textColor = UIColorFromHex(0xFF4055);
    footerLabel.font = GKMediumFont(12); 
    footerLabel.textAlignment = NSTextAlignmentLeft;
    footerLabel.hidden = YES;
    self.footerLabel = footerLabel;
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) return 30;
     return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 2) return 10;
    else return 33;
}

- (void)getCodeBtnClick{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)saveBtnClick{
    if ([self IsPhoneNumber:self.phoneTF.text] == YES) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[GKMeDetailController class]]) {
                    GKMeDetailController * popVC =(GKMeDetailController *)controller;
                    [self.navigationController popToViewController:popVC animated:YES];
                }
            }
        });
    }else{
        [SVProgressHUD showErrorWithStatus:@"无效手机号码"];
    }
    
}

- (void)nameChange{
    if (self.phoneTF.text.length > 0 && self.codeTF.text.length > 0){
        [self.saveBtn setTitleColor:SAVE_COLOR forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.saveBtn.userInteractionEnabled = YES;
    }else{
        [self.saveBtn setTitleColor:UIColorFromHex(0xCCCCCC) forState:UIControlStateNormal];
        self.saveBtn.userInteractionEnabled = NO;
    }
}

- (BOOL)IsPhoneNumber:(NSString *)number{
    NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}
@end
