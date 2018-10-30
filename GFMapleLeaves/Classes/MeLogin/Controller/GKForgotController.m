//
//  GKForgotController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/5.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKForgotController.h"
#import "GKForgotView.h"
@interface GKForgotController ()

@end

@implementation GKForgotController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"忘记密码";
    GKForgotView * forgotView = [[GKForgotView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:forgotView];
    
}

@end
