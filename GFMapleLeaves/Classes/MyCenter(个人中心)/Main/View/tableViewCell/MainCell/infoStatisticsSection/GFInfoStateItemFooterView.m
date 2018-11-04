//
//  GFInfoStateItemFooterView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/20.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFInfoStateItemFooterView.h"

@implementation GFInfoStateItemFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    _footerImageView = [[UIImageView alloc] init];
    [self addSubview:_footerImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_footerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(self)setOffset:DCMargin];
//        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
}

@end
