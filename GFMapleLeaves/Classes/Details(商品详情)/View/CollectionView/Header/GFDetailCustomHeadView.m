//
//  GFDetailCustomHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
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
//    self.backgroundColor = [UIColor whiteColor];
    
//    _guessMarkLabel = [[UILabel alloc] init];
//    _guessMarkLabel.text = @"猜你喜欢";
//    _guessMarkLabel.font = PFR15Font;
//    [self addSubview:_guessMarkLabel];
    
    UIView *uiView = [[UIView alloc]init];
    [self addSubview:uiView];
    [uiView setBackgroundColor:[UIColor whiteColor]];
    [uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.right.equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    
    _guessMarkImage = [[UIImageView alloc]initWithImage:SETIMAGE(@"home_icon_guestyoulike")];
    [uiView addSubview:_guessMarkImage];
    [_guessMarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(uiView);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    
    
    
//    _guessMarkLabel.frame = CGRectMake(DCMargin, 0, 200, self.dc_height);
    
}

#pragma mark - Setter Getter Methods


@end
