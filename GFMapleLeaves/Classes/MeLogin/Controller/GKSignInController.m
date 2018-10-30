//
//  GKSignInController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/5.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKSignInController.h"
#import "HMSegmentedControl.h"
#import "GKForgotController.h"

#import "GKSignInCodeView.h"

@interface GKSignInController ()<UINavigationControllerDelegate>
@property(nonatomic,weak)UINavigationController*navController;
@property (nonatomic,strong) UIImageView *navBarHairlineImageView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;


@end

@implementation GKSignInController

needNavBarShow;
navBarLineHidden;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarHairlineImageView.hidden = YES;
    self.navigationController.delegate = self;
    self.navController = self.navigationController;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
    self.navigationController.delegate = nil; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    WEAKSELF;
    //定义一个imageview来替代nav下的黑线
    UIImageView * navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.navBarHairlineImageView = navBarHairlineImageView;
    
    CGFloat  segmentedControlHeight = 45;
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, segmentedControlHeight)];
    self.segmentedControl.sectionTitles = @[@"验证码登录", @"密码登录"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:GKMediumFont(16)};
//    self.segmentedControl.selectionIndicatorColor = UIColorFromHex(0x085DF7);
//    self.segmentedControl.selectionIndicatorColor = GFOrangeCokor;
    self.segmentedControl.selectionIndicatorColor = GFOrangeCokor;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -20);
    //阴影
    self.segmentedControl.layer.shadowColor = UIColorFromHex(0x000000).CGColor;
    self.segmentedControl.layer.shadowOffset = CGSizeMake(0, 1);
    self.segmentedControl.layer.shadowOpacity = 0.1;
    [self.view addSubview:self.segmentedControl];
    self.title = @"验证码登录";
    
    GKSignInCodeView * codeView = [[GKSignInCodeView alloc] initWithFrame:CGRectMake(0, segmentedControlHeight, SCREEN_WIDTH, SCREEN_HEIGHT - K_HEIGHT_STATUSBAR - K_HEIGHT_NAVBAR - segmentedControlHeight)];
    [self.view addSubview:codeView];
    
#warning 测试数据
    codeView.phoneTF.text = @"18575857329";
    codeView.codeTF.text = @"1234";
    codeView.pwdTF.text = @"1234";
    
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            weakSelf.title = @"验证码登录";
            codeView.pwdView.hidden = YES;
            codeView.codeView.hidden = NO;
            codeView.forgotBtn.hidden = YES;
        }else{
            weakSelf.title = @"密码登录";
            codeView.pwdView.hidden = NO;
            codeView.codeView.hidden = YES;
            codeView.forgotBtn.hidden = NO;
        }
    }];
    [codeView.forgotBtn addTarget:self action:@selector(forgotBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)forgotBtnClick{
    [self.navController pushViewController:[GKForgotController new] animated:YES];
}

@end
