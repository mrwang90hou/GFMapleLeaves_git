//
//  GFCheckBabyDetailsCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/10/29.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFCheckBabyDetailsCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GFCheckBabyDetailsCell ()



@end

@implementation GFCheckBabyDetailsCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.leftTitleLable.text = @"查看宝贝详情";
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"nav_btn_down_icon"];
//    self.iconImageView.image = [UIImage imageNamed:@"nav_btn_back_default"];
//    self.iconImageView.image = [UIImage imageNamed:@"nav_btn_back_default_down"];
//    [self.iconImageView setHidden:YES];
    [self.indicateButton setUserInteractionEnabled:NO];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //重写leftTitleLableFrame
    [self.leftTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(self);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
}


-(void)setDetailsImageHidden:(Boolean *)bl{
    if (!bl) {
        self.indicateButton.transform = CGAffineTransformMakeRotation(M_PI/2);
    }else{
        self.indicateButton.transform = CGAffineTransformIdentity;
    }
}
#pragma mark - Setter Getter Methods

@end
