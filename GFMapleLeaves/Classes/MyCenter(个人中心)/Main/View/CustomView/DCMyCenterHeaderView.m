

//
//  DCMyCenterHeaderView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCMyCenterHeaderView.h"

@interface DCMyCenterHeaderView()

@property (weak, nonatomic) IBOutlet UIButton *seeMyPriceButton;

@end

@implementation DCMyCenterHeaderView

#pragma mark - initialize
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //圆角
    [DCSpeedy dc_chageControlCircularWith:_myIconButton AndSetCornerRadius:_myIconButton.dc_width * 0.5 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
    _seeMyPriceButton.backgroundColor = RGB(252, 246, 213);
    [DCSpeedy dc_chageControlCircularWith:_seeMyPriceButton AndSetCornerRadius:10 SetBorderWidth:1 SetBorderColor:_seeMyPriceButton.backgroundColor canMasksToBounds:YES];
    
}
//复制 点击事件
- (IBAction)copyBtnAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"点击复制！"];
}

//编辑名称点击事件
- (IBAction)editBtnAction:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"点击编辑！"];
}
#pragma mark - 头像点击
- (IBAction)headButtonClick {
    !_headClickBlock ? : _headClickBlock();
}

#pragma mark - 朋友圈点击
- (IBAction)friendsCircleClick {
    !_friendCircleClickBlock ? : _friendCircleClickBlock();
}

#pragma mark - 我的好友点击
- (IBAction)myFriendClick {
    !_myFriendClickBlock ? : _myFriendClickBlock();
}

#pragma mark - 二维码点击
- (IBAction)qrCodeClick {
    !_qrClickBlock ? : _qrClickBlock();
}
- (IBAction)seeMyPriceClick {
    !_seePriceClickBlock ? : _seePriceClickBlock();
}

@end
