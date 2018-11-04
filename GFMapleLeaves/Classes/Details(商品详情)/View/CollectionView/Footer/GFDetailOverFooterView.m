//
//  GFDetailOverFooterView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/21.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFDetailOverFooterView.h"

// Controllers

// Models

// Views
#import "DCLIRLButton.h"
// Vendors

// Categories

// Others

@interface GFDetailOverFooterView ()

/* 底部上拉提示 */
@property (strong , nonatomic)DCLIRLButton *overMarkButton;

@end

@implementation GFDetailOverFooterView

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
    self.backgroundColor = DCBGColor;
    _overMarkButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    [_overMarkButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
//    [_overMarkButton setTitle:@"上拉查看图文详情" forState:UIControlStateNormal];
    _overMarkButton.titleLabel.font = PFR12Font;
    [_overMarkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_overMarkButton];
    
    _overMarkButton.frame = CGRectMake(0, 0, self.dc_width, self.dc_height);
}

#pragma mark - Setter Getter Methods


@end
