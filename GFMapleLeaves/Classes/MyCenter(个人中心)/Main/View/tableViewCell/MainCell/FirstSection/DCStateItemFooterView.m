//
//  DCStateItemFooterView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCStateItemFooterView.h"

@implementation DCStateItemFooterView


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
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
}

@end
