//
//  GKTFCell.m
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKTFCell.h"

@implementation GKTFCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        WEAKSELF;
        
        UIView * countryView = [UIView new];
        [self addSubview:countryView];
        [countryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.mas_equalTo(weakSelf).with.offset(-15);
            make.left.mas_equalTo(weakSelf).with.offset(15);
        }];
        countryView.backgroundColor = [UIColor whiteColor];
        countryView.layer.borderColor = UIColorFromHex(0xE1E1E1).CGColor;
        countryView.layer.borderWidth = .5;
        countryView.layer.cornerRadius = 5;
        countryView.layer.masksToBounds = YES;
        
        UIButton * eyeBtn = [UIButton new];
        [countryView addSubview:eyeBtn];
        [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(countryView);
            make.right.mas_equalTo(countryView).with.offset(-15);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        eyeBtn.hidden = YES;
        self.eyeBtn = eyeBtn;
        [self.eyeBtn setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
        [self.eyeBtn setImage:[UIImage imageNamed:@"icon_so"] forState:UIControlStateSelected];
        [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        GKTextField * typeTF = [GKTextField new];
        [countryView addSubview:typeTF];
        [typeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(countryView); 
        }];
        typeTF.placeholder = @"请输入手机号码";
        [typeTF setLeftMargin:10];
        typeTF.font = GKMediumFont(16);
        typeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        typeTF.secureTextEntry = NO;
        self.phoneTF = typeTF;
    }
    return self;
}

- (void)eyeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        self.phoneTF.secureTextEntry = NO;
    }else{
        self.phoneTF.secureTextEntry = YES;
    }
}

@end
