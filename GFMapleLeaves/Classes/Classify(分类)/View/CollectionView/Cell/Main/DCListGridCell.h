//
//  DCListGridCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/13.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCRecommendItem;

@interface DCListGridCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)DCRecommendItem *youSelectItem;

/** 冒号点击回调 */
@property (nonatomic, copy) dispatch_block_t colonClickBlock;

@end
