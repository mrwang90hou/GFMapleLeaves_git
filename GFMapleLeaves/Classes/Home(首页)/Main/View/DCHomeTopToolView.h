//
//  DCHomeTopToolView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/28.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCHomeTopToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;

/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;
/** 二维码按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t qrCodeButtonClickBlock;


@end
