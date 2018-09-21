

//
//  DCCenterBeaShopCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCCenterBeaShopCell.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCenterBeaShopCell ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *controlButton;

@end

@implementation DCCenterBeaShopCell

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

    _bottomView.backgroundColor = DCBGColor;
    
    [DCSpeedy dc_chageControlCircularWith:_controlButton AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
}

#pragma mark - Setter Getter Methods


@end
