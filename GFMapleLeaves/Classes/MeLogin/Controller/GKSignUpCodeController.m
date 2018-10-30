//
//  GKSignUpCodeController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKSignUpCodeController.h"
#import "GKSignUpController.h"
#import "GKSignUpCodeView.h"

@interface GKSignUpCodeController ()
//@property(nonatomic,weak)UINavigationController*navController;

@property (nonatomic,strong)UITextField * codeTF;

@property (nonatomic,strong)GKSignUpCodeView * signUpCodeView;

@end

@implementation GKSignUpCodeController

//needNavBarShow;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    self.navigationController.delegate = self;
//    self.navController = self.navigationController;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    self.navigationController.delegate = nil;
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleDefault;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
//    self.navigationController.navigationBar.hidden = false;
    GKSignUpCodeView * signUpCodeView = [[GKSignUpCodeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:signUpCodeView];
    [signUpCodeView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    self.phoneTF = signUpView.hintLabel;
//    signUpView.codeTF.text = @"M3d56L";
    [signUpCodeView.codeTF addTarget:self action:@selector(passConTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.signUpCodeView = signUpCodeView;
    self.codeTF = signUpCodeView.codeTF;
    
//#warning 测试数据
//    self.phoneTF.text = @"18575857329";
//    self.codeTF.text = @"1";
}

//注意：事件类型是：`UIControlEventEditingChanged`
-(void)passConTextChange:(id)sender{
//    UITextField* target=(UITextField*)sender;
//    NSLog(@"%@",target.text);
    if (![self.signUpCodeView.codeTF.text isEqualToString:@""]) {
        self.signUpCodeView.codeImageView.image = [UIImage imageNamed:@"my_register_invitation_selected"];
    }else{
        self.signUpCodeView.codeImageView.image = [UIImage imageNamed:@"my_register_invitation_normal"];
    }
    
    
}
- (void)nextBtnClick{
    if(self.codeTF.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入邀请码"];
        }else
    {
        [SVProgressHUD  showWithStatus:@"正在验证"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"Success"];
            [self.navigationController pushViewController:[GKSignUpController new] animated:YES];
        });
    }
}
@end
