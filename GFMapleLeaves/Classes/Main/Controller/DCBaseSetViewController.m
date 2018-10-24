
//
//  DCBaseSetViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCBaseSetViewController.h"

// Controllers
#import "DCTabBarController.h"
// Models

// Views

// Vendors

// Categories

// Others

@interface DCBaseSetViewController ()



@end

@implementation DCBaseSetViewController

#pragma mark - LazyLoad

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self setUpAcceptNote];
}

#pragma mark - 接受跟换控制
- (void)setUpAcceptNote
{
    WEAKSELF
    [[NSNotificationCenter defaultCenter]addObserverForName:LOGINSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakSelf.tabBarController.selectedIndex = DCTabBarControllerPerson; //跳转到我的界面
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setBackgroundColor:TABLEVIEW_BG];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
