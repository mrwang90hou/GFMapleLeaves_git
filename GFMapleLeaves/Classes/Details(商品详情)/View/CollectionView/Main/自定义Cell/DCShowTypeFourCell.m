//
//  DCShowTypeFourCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/26.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCShowTypeFourCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCShowTypeFourCell ()



@end

@implementation DCShowTypeFourCell

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
    self.leftTitleLable.text = @"领券";
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"biaoqian"];
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

#pragma mark - Setter Getter Methods

@end
