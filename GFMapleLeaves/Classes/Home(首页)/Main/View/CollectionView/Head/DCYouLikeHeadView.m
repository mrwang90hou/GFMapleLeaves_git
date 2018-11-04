//
//  DCYouLikeHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCYouLikeHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCYouLikeHeadView ()

@end

@implementation DCYouLikeHeadView

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
    _likeImageView = [[UIImageView alloc] init];
//    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    _likeImageView.contentMode = UIViewContentModeScaleToFill;
//    [_likeImageView setImage:[UIImage imageNamed:HomeBottomViewGIFImage]];
    [self addSubview:_likeImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
}

#pragma mark - Setter Getter Methods


@end
