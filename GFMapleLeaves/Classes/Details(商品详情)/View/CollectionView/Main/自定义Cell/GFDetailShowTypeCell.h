//
//  GFDetailShowTypeCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GFDetailShowTypeCell : UICollectionViewCell

/** 是否有指示箭头 */
@property (nonatomic,assign)BOOL isHasindicateButton;
/* 指示按钮 */
@property (strong , nonatomic)UIButton *indicateButton;
/* 标题 */
@property (strong , nonatomic)UILabel *leftTitleLable;
/* 图片 */
@property (strong , nonatomic)UIImageView *iconImageView;
/* 内容 */
@property (strong , nonatomic)UILabel *contentLabel;
/* 提示 */
@property (strong , nonatomic)UILabel *hintLabel;

@end
