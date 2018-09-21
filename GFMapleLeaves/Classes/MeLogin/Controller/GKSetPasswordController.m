//
//  GKSetPasswordController.m
//  Record
//
//  Created by L on 2018/7/5.
//  Copyright © 2018年 L. All rights reserved.
//

#import "GKSetPasswordController.h"
#import "GKLoginController.h"

#import "GKSetPasswordView.h"

@interface GKSetPasswordController ()
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UITextField *againPwdTF;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) GKButton *signUpBtn;
@end

@implementation GKSetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置密码";
    
    GKSetPasswordView * setPwdView = [[GKSetPasswordView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:setPwdView];
    self.pwdTF = setPwdView.pwdTF;
    self.againPwdTF = setPwdView.againPwdTF;
    self.tipLabel = setPwdView.tipLabel;
    self.signUpBtn = setPwdView.signUpBtn;
    [setPwdView.signUpBtn addTarget:self action:@selector(signUpBtnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)signUpBtnClick{
    if (self.pwdTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
    }else if (self.againPwdTF.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
    }else{
        if (![self.pwdTF.text isEqualToString:self.againPwdTF.text]) {
            self.tipLabel.hidden = NO;
        }else{
            self.tipLabel.hidden = YES;
            [SVProgressHUD  showWithStatus:@"请稍后..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showSuccessWithStatus:@"注册成功,正在返回登录界面..."];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        for (UIViewController *controller in self.navigationController.viewControllers) {
                            if ([controller isKindOfClass:[GKLoginController class]]) {
                                GKLoginController * popVC =(GKLoginController *)controller;
                                [self.navigationController popToViewController:popVC animated:YES];
                            }
                        }
                    });
            });
        }
    }
}
@end
