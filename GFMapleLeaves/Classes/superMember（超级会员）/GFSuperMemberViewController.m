//
//  GFSuperMemberViewController.m
//  GFMapleLeaves
//
//  Created by L on 2018/9/11.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFSuperMemberViewController.h"


@interface GFSuperMemberViewController()

@end

@implementation GFSuperMemberViewController

#pragma mark - LazyLoad


#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"待开发。。。";
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [SVProgressHUD showInfoWithStatus:@"待开发..."];
}
@end

