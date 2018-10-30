//
//  GKSetPasswordView.h
//  Record
//
//  Created by mrwang90hou on 2018/9/5.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKSetPasswordView : UIView
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UITextField *againPwdTF;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) GKButton *signUpBtn;

@end
