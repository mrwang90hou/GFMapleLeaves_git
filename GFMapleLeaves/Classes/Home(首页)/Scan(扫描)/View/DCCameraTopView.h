//
//  DCCameraTopView.h
//  STOExpressDelivery
//
//  Created by mrwang90hou on 2018/9/26.
//Copyright © 2018年 STO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCameraTopView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;


@end
