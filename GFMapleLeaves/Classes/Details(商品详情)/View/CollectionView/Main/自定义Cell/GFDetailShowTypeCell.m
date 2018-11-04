//
//  GFDetailShowTypeCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/21.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFDetailShowTypeCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GFDetailShowTypeCell ()

@end

@implementation GFDetailShowTypeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _leftTitleLable = [[UILabel alloc] init];
    _leftTitleLable.font = PFR14Font;
    _leftTitleLable.textColor = [UIColor lightGrayColor];
    [self addSubview:_leftTitleLable];
    
    _iconImageView = [[UIImageView alloc] init];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR14Font;
    [self addSubview:_contentLabel];
    
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_hintLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:UIControlStateNormal];
    _isHasindicateButton = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_leftTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    if (_isHasindicateButton) {
        [self addSubview:_indicateButton];
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.right.mas_equalTo(self)setOffset:-DCMargin];
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self);
        }];
    }
}

#pragma mark - Setter Getter Methods


@end
