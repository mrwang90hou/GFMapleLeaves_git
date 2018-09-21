//
//  GKForgotController.m
//  Record
//
//  Created by L on 2018/7/5.
//  Copyright © 2018年 L. All rights reserved.
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
