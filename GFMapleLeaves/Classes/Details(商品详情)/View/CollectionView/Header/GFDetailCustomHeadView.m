//
//  GFDetailCustomHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/21.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFDetailCustomHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GFDetailCustomHeadView ()

/* 猜你喜欢 */
//@property (strong ,nonatomic) UILabel *guessMarkLabel;
@property (strong ,nonatomic) UIImageView *guessMarkImage;


@end

@implementation GFDetailCustomHeadView

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
    
//    _guessMarkLabel = [[UILabel alloc] init];
//    _guessMarkLabel.text = @"猜你喜欢";
//    _guessMarkLabel.font = PFR15Font;
//    [self addSubview:_guessMarkLabel];
    _guessMarkImage = [[UIImageView alloc]initWithImage:SETIMAGE(@"home_icon_guestyoulike")];
    [self addSubview:_guessMarkImage];
    [_guessMarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
    
    
    
    
//    _guessMarkLabel.frame = CGRectMake(DCMargin, 0, 200, self.dc_height);
    
}

#pragma mark - Setter Getter Methods


@end
