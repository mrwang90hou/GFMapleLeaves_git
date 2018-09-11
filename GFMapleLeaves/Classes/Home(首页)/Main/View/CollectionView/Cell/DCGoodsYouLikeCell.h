//
//  DCGoodsYouLikeCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCRecommendItem;

@interface DCGoodsYouLikeCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)DCRecommendItem *youLikeItem;
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/* 领券 */
@property (strong , nonatomic)UIButton *getTicketButton;

///** 找相似点击回调 */
//@property (nonatomic, copy) dispatch_block_t lookSameBlock;

/** 领券点击回调 */
@property (nonatomic, copy) dispatch_block_t getTicketBlock;

@end
