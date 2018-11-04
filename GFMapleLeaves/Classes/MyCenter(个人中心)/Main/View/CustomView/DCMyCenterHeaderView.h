//
//  DCMyCenterHeaderView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMyCenterHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *myIconButton;

/* 头像点击回调 */
@property (nonatomic, copy) dispatch_block_t headClickBlock;
/** 二维码点击回调 */
@property (nonatomic, copy) dispatch_block_t qrClickBlock;
/** 我的朋友点击回调 */
@property (nonatomic, copy) dispatch_block_t myFriendClickBlock;
/** 朋友圈点击回调 */
@property (nonatomic, copy) dispatch_block_t friendCircleClickBlock;

/** 查看会员点击 */
@property (nonatomic, copy) dispatch_block_t seePriceClickBlock;

@end
