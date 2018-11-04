//
//  GFPlatformRulesViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/24.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFPlatformRulesViewController.h"

@interface GFPlatformRulesViewController()

@end

@implementation GFPlatformRulesViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    self.title = @"平台规则";
    [self.view setBackgroundColor:TABLEVIEW_BG];
    
}
-(void)setupUI{
    
    //背景图片
    UIView *bgView = [[UIView alloc]init];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //规则1
    UITextView *rulesTV = [[UITextView alloc]init];
    [rulesTV setText:@"规则1："];
    rulesTV.editable = NO;
    [rulesTV setFont:GKFont(16)];
    [self.view addSubview:rulesTV];
    [rulesTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



@end
