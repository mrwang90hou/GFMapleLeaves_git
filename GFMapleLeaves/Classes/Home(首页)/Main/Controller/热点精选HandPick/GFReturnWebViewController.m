//
//  GFReturnWebViewController.m
//  GFMapleLeaves
//
//  Created by 王宁 on 2018/11/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFReturnWebViewController.h"


@interface GFReturnWebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GFReturnWebViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == DCBGColor)return;
    self.navigationController.navigationBar.barTintColor = DCBGColor;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, ScreenH-K_HEIGHT_NAVBAR)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.webViewUrl]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

@end
