//
//  DCNavSearchBarView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCNavSearchBarView : UIView


/* 二维码按钮 */
@property (strong , nonatomic)UIButton *voiceImageBtn;
/* 占位文字 */
@property (strong , nonatomic)UILabel *placeholdLabel;

/** 二维码点击回调Block */
@property (nonatomic, copy) dispatch_block_t qrCodeButtonClickBlock;
/** 搜索 */
@property (nonatomic, copy) dispatch_block_t searchViewBlock;


/**
 intrinsicContentSize
 */
@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
