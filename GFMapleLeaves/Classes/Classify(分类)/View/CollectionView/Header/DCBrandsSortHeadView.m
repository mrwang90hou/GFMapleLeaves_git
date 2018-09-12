//
//  DCBrandsSortHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCBrandsSortHeadView.h"

// Controllers

// Models
#import "DCClassMianItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCBrandsSortHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end

@implementation DCBrandsSortHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR13Font;
    _headLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_headLabel];
    
    _headLabel.frame = CGRectMake(DCMargin, 0, self.dc_width, self.dc_height);
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(DCClassMianItem *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = headTitle.title;
}

@end
