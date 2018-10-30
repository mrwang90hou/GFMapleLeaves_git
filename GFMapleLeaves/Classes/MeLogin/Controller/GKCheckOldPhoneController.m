//
//  GKCheckOldPhoneController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/3.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKCheckOldPhoneController.h"
#import "GKChangePhoneController.h"

#import "GKCheckCodeCell.h"

@interface GKCheckOldPhoneController ()
@property (nonatomic,strong) GKButton * codeBtn;
@property (nonatomic,strong)UITextField * nameTF;
@property (nonatomic,strong)UIButton * saveBtn;
@end

@implementation GKCheckOldPhoneController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机";
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GKCheckCodeCell *cell = [[GKCheckCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKCheckOldPhoneController"];
    self.codeBtn = cell.codeBtn;
    self.nameTF = cell.codeTF;
    [cell.codeTF addTarget:self action:@selector(nameChange) forControlEvents:UIControlEventEditingChanged];
    [cell.codeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    headerLabel.text = @"为了保护账号安全，需要验证手机是有效性的，请使用安全手机\n185******75获取验证码";
    headerLabel.numberOfLines = 0;
    headerLabel.textColor = UIColorFromHex(0x999999);
    headerLabel.font = GKMediumFont(12); 
    headerLabel.textAlignment = NSTextAlignmentLeft;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
    [self.navigationController pushViewController:[GKChangePhoneController new] animated:YES];
}

- (void)nameChange{
    if (self.nameTF.text.length > 0){
        [self.saveBtn setTitleColor:SAVE_COLOR forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.saveBtn.userInteractionEnabled = YES;
    }else{
        [self.saveBtn setTitleColor:UIColorFromHex(0xCCCCCC) forState:UIControlStateNormal];
        self.saveBtn.userInteractionEnabled = NO;
    }
}
@end
