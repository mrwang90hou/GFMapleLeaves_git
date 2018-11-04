//
//  DCCenterTopToolView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/11.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCenterTopToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;

@end
