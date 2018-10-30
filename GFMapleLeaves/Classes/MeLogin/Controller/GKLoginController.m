//
//  GKLoginController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKLoginController.h"
#import "GKSignUpCodeController.h"
#import "GKSignInController.h"

@implementation GKLoginController
//needNavBarHidden;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    self.navigationController.navigationBarHidden = true;
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
//    self.navigationController.delegate = self;
//    self.navController = self.navigationController;
//    self.edgesForExtendedLayout = UIRectEdge.None//方法1
//    self.navigationController?.navigationBar.translucent = false//方法2
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
//    self.navigationController.delegate = nil;
//    self.navigationController.navigationBarHidden = true;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault]; [self.navigationController.navigationBar setShadowImage:nil];
//    [self.navigationController.navigationBar setBarTintColor:DCBGColor];
//    [self.navigationController.navigationBar setBarTintColor:GFPink2Cokor];
//    [self.navigationController.navigationBar setBarTintColor:GFRedCokor];
//    [self.navigationController.navigationBar setBarTintColor:GFYellowCokor];
    [self.navigationController.navigationBar setBarTintColor:GFOrgangeCokor];
    
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:0.6]];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"登陆成功！" object:nil];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -页面逻辑方法
- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissViewController) name:@"登陆成功！" object:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    // 设置导航栏标题颜色，字体大小，背景不透明，背景颜色
//    NSMutableDictionary *titleParams = [[NSMutableDictionary alloc] init];
//    RGB(200,85,55,0.6)
//    [titleParams setObject:GFOrangeCokor forKey:NSForegroundColorAttributeName];
//    [titleParams setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
//    [self.navigationController.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
    [self.navigationController.navigationBar setTranslucent:NO];//设置为半透明状态
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:0]];
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    self.title = @"登录";
    WEAKSELF;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,10,40,40)];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"RedEnvelopepasswordclose"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    
//    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ptgd_icon_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
//    [self.navigationItem setRightBarButtonItem:closeBtn];
    
//    UIImageView * bgImageView = [UIImageView new];
//    [self.view addSubview:bgImageView];
//    WEAKSELF;
//    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(weakSelf.view);
//    }];
//    bgImageView.image = [UIImage imageNamed:@"login_bg"];
//    bgImageView.hidden = true;
    
    UIView *uiView = [[UIView alloc]init];
    [self.view addSubview:uiView];
    uiView.backgroundColor = [UIColor redColor];
    [uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.left.right.bottom.equalTo(weakSelf.view);
        make.center.equalTo(weakSelf.view);
        make.height.mas_equalTo(@2);
        make.width.equalTo(weakSelf.view);
    }];
    [uiView setAlpha:0.0];
    UIImageView * logoImage = [UIImageView new];
    [self.view addSubview:logoImage];
    logoImage.image = [UIImage imageNamed:@"小枫叶Logo.png"];
    
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(weakSelf.view);
        make.bottom.equalTo(uiView.mas_top).offset(-40);
        make.centerX.equalTo(weakSelf.view);
    }];
    UILabel * nameLabel = [UILabel new];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImage.mas_bottom).with.offset(2);
        make.centerX.equalTo(weakSelf.view);
        make.height.mas_equalTo(37);
    }];
    nameLabel.text = @"小枫叶";
    nameLabel.font = GKBlodFont(25);
    nameLabel.textColor = [UIColor grayColor];
    
    UIButton * weChatBtn = [UIButton new];
    [self.view addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view).with.offset(15);
        make.right.mas_equalTo(weakSelf.view).with.offset(-15);
        make.top.mas_equalTo(uiView.mas_bottom).with.offset(15);
//        make.top.equalTo(uiView);
        make.size.mas_equalTo(CGSizeMake(ScreenW - 30, 28));
//        make.height.mas_equalTo(@45);
//        make.width.mas_equalTo(90);
        }];
    weChatBtn.frame = CGRectMake(15, 35, ScreenW - 30, 30);
    
//    weChatBtn.backgroundColor = RGB(235, 103, 98);
    weChatBtn.backgroundColor = RGB(225, 80, 59);
//    weChatBtn.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
//    weChatBtn.layer.borderWidth = 1;
//    weChatBtn.layer.cornerRadius = 5;
//    weChatBtn.layer.masksToBounds = YES;
    [weChatBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [weChatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [weChatBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.2]];
    [weChatBtn addTarget:self action:@selector(signInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [DCSpeedy dc_setUpBezierPathCircularLayerWithControl:weChatBtn size:CGSizeMake(DCMargin, DCMargin)];
    
    UILabel *signLabel = [[UILabel alloc]init];
    [signLabel setText:@"/"];
    [signLabel setTextColor:[UIColor orangeColor]];
    [signLabel setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(weakSelf.view).with.offset(15);
        //        make.bottom.mas_equalTo(weakSelf.view).with.offset(-60);
        //        make.size.mas_equalTo(CGSizeMake(FixWidthNumber(165), 44));
        make.centerX.mas_equalTo(weChatBtn).with.offset(0);
        make.top.mas_equalTo(weChatBtn.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(FixWidthNumber(16), 44));
    }];
    
    UIButton * signUpBtn = [UIButton new];
    [self.view addSubview:signUpBtn];
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.view).with.offset(15);
//        make.bottom.mas_equalTo(weakSelf.view).with.offset(-60);
//        make.size.mas_equalTo(CGSizeMake(FixWidthNumber(165), 44));
//        make.top.equalTo(signLabel);
        make.centerY.equalTo(signLabel);
        make.right.mas_equalTo(signLabel.mas_left).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(FixWidthNumber(40), 44));
    }];
//    signUpBtn.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
//    signUpBtn.layer.borderWidth = 1;
//    signUpBtn.layer.cornerRadius = 5;
//    signUpBtn.layer.masksToBounds = YES;
    [signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [signUpBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    signUpBtn.titleLabel.textColor = RGB(245, 178, 58);
//    [signUpBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.2]];
    [signUpBtn addTarget:self action:@selector(signUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    //修改某个范围内的字体大小
////    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(7,2)];
//    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(2,1)];
//    //修改某个范围内字的颜色
////    [title addAttribute:NSForegroundColorAttributeName value:GLColor(62, 190, 219, 1)  range:NSMakeRange(7,2)];
////    [title addAttribute:NSForegroundColorAttributeName value:RGB(235, 103, 98) range:NSMakeRange(2,2)];
    [signUpBtn setAttributedTitle:title forState:UIControlStateNormal];
    [signUpBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    UIButton * signInBtn = [UIButton new];
    [self.view addSubview:signInBtn];
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(signLabel);
        make.centerY.equalTo(signLabel);
        make.left.mas_equalTo(signLabel.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(FixWidthNumber(40), 44));
    }];
//    signInBtn.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
//    signInBtn.layer.borderWidth = 1;
//    signInBtn.layer.cornerRadius = 5;
//    signInBtn.layer.masksToBounds = YES;
    [signInBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [signInBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    signInBtn.titleLabel.textColor = RGB(245, 178, 58);
//    [signInBtn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.2]];
    [signInBtn addTarget:self action:@selector(signInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    NSMutableAttributedString *title2 = [[NSMutableAttributedString alloc] initWithString:@"登录"];//修改某个范围内的字体大小
    //    [title addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(7,2)];
//    [title2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(2,1)];
    //修改某个范围内字的颜色
    //    [title addAttribute:NSForegroundColorAttributeName value:GLColor(62, 190, 219, 1)  range:NSMakeRange(7,2)];
//    [title2 addAttribute:NSForegroundColorAttributeName value:RGB(235, 103, 98) range:NSMakeRange(2,1)];
    NSRange titleRange2 = {0,[title2 length]};
    [signInBtn setAttributedTitle:title2 forState:UIControlStateNormal];
    [title2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange2];
    [signInBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
}

- (void)signUpBtnClick{
//    [SVProgressHUD showInfoWithStatus:@"signUpBtnClick"];
    GKSignUpCodeController *nv = [[GKSignUpCodeController alloc]init];
    [self.navigationController pushViewController:nv animated:YES];
}

- (void)signInBtnClick{
    [self.navigationController pushViewController:[GKSignInController new] animated:YES];
}
#pragma mark - 退出当前界面
- (void)dismissViewController {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
