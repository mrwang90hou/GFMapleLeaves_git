//
//  GKSignUpCodeView.m
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKSignUpCodeView.h"

@implementation GKSignUpCodeView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];

        WEAKSELF;
        UIView * hintView = [UIView new];
        [self addSubview:hintView];
        [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf).with.offset(15);
            make.left.right.equalTo(weakSelf);
            make.height.mas_equalTo(50);
        }];
        hintView.backgroundColor = [UIColor whiteColor];

//        UIImageView * phoneIconImageView = [UIImageView new];
//        [hintView addSubview:phoneIconImageView];
//        [phoneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(hintView).with.offset(FixWidthNumber(17.5));
//            make.centerY.equalTo(hintView);
//            make.size.mas_equalTo(CGSizeMake(22, 22));
//        }];
//        phoneIconImageView.contentMode = UIViewContentModeScaleAspectFit;
//        phoneIconImageView.image = [UIImage imageNamed:@"login_icon_phone_nub"];
//
//        UIView * lineView = [UIView new];
//        [hintView addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(hintView).with.offset(15);
//            make.right.equalTo(hintView).with.offset(-15);
//            make.bottom.mas_equalTo(hintView).with.offset(-1);
//            make.height.mas_equalTo(1);
//        }];
//        lineView.backgroundColor = UIColorFromHex(0xF0F0F0);
//
//        UIButton * countryBtn = [UIButton new];
//        [hintView addSubview:countryBtn];
//        [countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(phoneIconImageView.mas_right).with.offset(10);
//            make.centerY.equalTo(hintView);
//            make.size.mas_equalTo(CGSizeMake(30, 26));
//        }];
//        [countryBtn setTitle:@"+86" forState:UIControlStateNormal];
//        [countryBtn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
//        countryBtn.titleLabel.font = GKBlodFont(14);
//
//        UIImageView * arrowImageView = [UIImageView new];
//        [hintView addSubview:arrowImageView];
//        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(countryBtn.mas_right).with.offset(10);
//            make.centerY.equalTo(countryBtn);
//            make.size.mas_equalTo(CGSizeMake(10, 10));
//        }];
//        arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
//        arrowImageView.image = [UIImage imageNamed:@"my_register_invitation_normal"];

        UILabel * hintLabel = [UILabel new];
        [hintView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hintView).with.offset(FixWidthNumber(17.5));
            make.right.mas_equalTo(hintView).with.offset(-15);
            make.height.centerY.equalTo(hintView);
        }];
        hintLabel.text = @"请输入邀请码";
        hintLabel.font = GKMediumFont(16);
        self.hintLabel = hintLabel;
        
        
        UIView * codeView = [UIView new];
        [self addSubview:codeView];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(hintView);
            make.top.mas_equalTo(hintView.mas_bottom);
        }];
        codeView.backgroundColor = [UIColor whiteColor];

        UIImageView * codeImageView = [UIImageView new];
        [codeView addSubview:codeImageView];
        [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeView).with.offset(FixWidthNumber(17.5));
            make.centerY.equalTo(codeView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        codeImageView.contentMode = UIViewContentModeScaleAspectFit;
        codeImageView.image = [UIImage imageNamed:@"my_register_invitation_normal"];
        self.codeImageView = codeImageView;
        
        
        UIView * codeLineView = [UIView new];
        [codeView addSubview:codeLineView];
        [codeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(codeView).with.offset(15);
            make.right.equalTo(codeView).with.offset(-15);
            make.bottom.mas_equalTo(codeView).with.offset(-1);
            make.height.mas_equalTo(1);
        }];
        codeLineView.backgroundColor = UIColorFromHex(0xF0F0F0);

        UITextField * codeTF = [UITextField new];
        [codeView addSubview:codeTF];
        [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeImageView.mas_right).with.offset(FixWidthNumber(11.5));
            make.right.mas_equalTo(codeView).with.offset(-20);
            make.centerY.equalTo(codeView);
        }];
        codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        codeTF.placeholder = @"请输入邀请码";
        codeTF.font = GKMediumFont(16);
        self.codeTF = codeTF;
        
        GKButton * codeBtn = [GKButton new];
        [codeView addSubview:codeBtn];
        [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(codeTF.mas_right).with.offset(200);
            make.centerY.equalTo(codeView);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(codeView).with.offset(-20);
        }];
        codeBtn.backgroundColor = [UIColor whiteColor];
        [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeBtn setTitleColor:UIColorFromHex(0x085DF7) forState:UIControlStateNormal];
        codeBtn.titleLabel.font = GKMediumFont(12);
        codeBtn.layer.borderColor = UIColorFromHex(0x085DF7).CGColor;
        codeBtn.layer.borderWidth = 1;
        codeBtn.layer.cornerRadius = 5;
        codeBtn.layer.masksToBounds = YES;
        [codeBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [codeBtn setHidden:true];
        self.codeBtn = codeBtn;
        
        
        GKButton * nextBtn = [GKButton new];
        [self addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(codeView.mas_bottom).with.offset(44);
            make.left.mas_equalTo(weakSelf).with.offset(20);
            make.right.mas_equalTo(weakSelf).with.offset(-20);
            make.height.mas_equalTo(44);
        }];
        [nextBtn setupCircleButton];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        nextBtn.titleLabel.font = GKMediumFont(16);
        self.nextBtn = nextBtn;
    }
    return self;
}

- (void)codeBtnClick:(UIButton *)btn{
    __block NSInteger time = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.clickLayer removeFromSuperlayer];
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [btn setTitleColor:UIColorFromHex(0x085DF7) forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //颜色渐变
                CAGradientLayer *layer = [CAGradientLayer layer];
                layer.frame = CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height);
                layer.startPoint = CGPointMake(0, 0);
                layer.endPoint = CGPointMake(1, 1);
//                layer.colors = @[(id)UIColorFromHex(0x2584FF).CGColor,(id)UIColorFromHex(0x226DFF).CGColor,(id)UIColorFromHex(0x1F53FF).CGColor];//UIColorFromHex(0xFF1493)
                layer.colors = @[(id)GFOrangeCokor.CGColor,(id)GFOrangeCokor.CGColor,(id)GFOrangeCokor.CGColor];
                if (self.clickLayer ==nil) {
                    [btn.layer insertSublayer:layer atIndex:0];
                    self.clickLayer = layer;
                }
                //设置按钮显示读秒效果
                [btn setTitle:[NSString stringWithFormat:@"%.2d秒重新获取", seconds] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                btn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
