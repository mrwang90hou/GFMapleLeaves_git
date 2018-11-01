//
//  GFHotRecommendedHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/11/1.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFHotRecommendedHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GFHotRecommendedHeadView ()

@end

@implementation GFHotRecommendedHeadView

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
    _titleImageView = [[UIImageView alloc] init];
    _titleImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_titleImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
        [make.bottom.mas_equalTo(self)setOffset:0];
    }];
}

#pragma mark - Setter Getter Methods


@end
