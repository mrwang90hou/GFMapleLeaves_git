//
//  DCMediaTopToolView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMediaTopToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) void(^rightItemClickBlock)(UIButton *sender);

/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;

@end
