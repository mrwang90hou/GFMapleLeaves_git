//
//  GKMeHeaderView.m
//  Record
//
//  Created by mrwang90hou on 2018/9/2.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKMeHeaderView.h"

@implementation GKMeHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * bgImageView = [UIImageView new];
        [self addSubview:bgImageView];
        WEAKSELF;
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(weakSelf);
        }];
        bgImageView.image = [UIImage imageNamed:@"bg_personal_center"];
        bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIButton * nameBtn = [UIButton new];
        [self addSubview:nameBtn];
        [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf).with.offset(-30);
            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 24));
        }];
        nameBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        nameBtn.titleLabel.textColor = [UIColor whiteColor];
        [nameBtn setTitle:@"立即登录" forState:UIControlStateNormal] ;
        nameBtn.titleLabel.font = GKBlodFont(16);
        self.nameBtn = nameBtn;
        
        UIImageView * iconImageView = [UIImageView new];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(nameBtn.mas_top).with.offset(-15);
            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        iconImageView.layer.cornerRadius = 35;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.shouldRasterize = YES;
        iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        iconImageView.layer.borderWidth = 2;
        iconImageView.layer.borderColor = UIColorFromHex(0xFFFFFF).CGColor;
        iconImageView.image = [UIImage imageNamed:@"userDefault"];
        
        UILabel * vcTitleLabel = [UILabel new];
        [self addSubview:vcTitleLabel];
        [vcTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(iconImageView.mas_top).with.offset(-22);
            make.centerX.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 24));
        }];
        vcTitleLabel.textAlignment = NSTextAlignmentCenter;
        vcTitleLabel.textColor = [UIColor whiteColor];
        vcTitleLabel.text = @"我的";
        vcTitleLabel.font = GKBlodFont(17);
    }
    return self;
}
@end
