//
//  DCUserMgHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/18.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCUserMgHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCUserMgHeadView ()

@property (weak, nonatomic) IBOutlet UIView *headBgView;

@property (weak, nonatomic) IBOutlet UIButton *headButton;

@end

@implementation DCUserMgHeadView

#pragma mark - Intial
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [DCSpeedy dc_setUpBezierPathCircularLayerWithControl:self.headButton size:CGSizeMake(self.headButton.dc_width * 0.5, self.headButton.dc_height * 0.5)];
    self.headBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTouch)];
    [self.headBgView addGestureRecognizer:tapGest];
    
}

#pragma mark - 头部点击
- (IBAction)headButtonClick {
    !_headButtonClickBlock ? : _headButtonClickBlock();
}

#pragma mark - 二维码点击
- (IBAction)qrCodeClick {
    !_erCodeClickBlock ? : _erCodeClickBlock();
}
#pragma mark - 我的主页点击
- (IBAction)homePageClick {
    !_myHomeClickBlock ? : _myHomeClickBlock();
}

#pragma mark - 头部View点击
- (void)headViewTouch
{
    !_headViewTouchBlock ? : _headViewTouchBlock();
}
@end
