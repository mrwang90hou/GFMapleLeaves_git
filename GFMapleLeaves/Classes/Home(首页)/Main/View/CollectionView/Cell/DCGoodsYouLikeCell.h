//
//  DCGoodsYouLikeCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRecommendItem2.h"
@class DCRecommendItem2;

@interface DCGoodsYouLikeCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)DCRecommendItem2 *youLikeItem;
/* 相同 */
//@property (strong , nonatomic)UIButton *sameButton;
/* 领券 */
@property (strong , nonatomic)UIButton *getTicketButton;
/* 展示图的 View */
@property (strong , nonatomic)UIView *view;
/* 底部佣金条 */
@property (strong , nonatomic)UIView *bottomView;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 佣金 */
@property (strong , nonatomic)UILabel *commissionLabel;
/* 标题图片(天猫、淘宝) */
@property (strong , nonatomic)UIImageView *goodsTitleImage;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 淘宝价格 */
@property (strong , nonatomic)UILabel *beforeDownPriceLabel;
/* 月销量 */
@property (strong , nonatomic)UILabel *mothSalesVolume;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 视频播放btn */
@property (nonatomic,strong) UIButton *videoBtn;
///** 找相似点击回调 */
//@property (nonatomic, copy) dispatch_block_t lookSameBlock;

/** 领券点击回调 */
@property (nonatomic, copy) dispatch_block_t getTicketBlock;

@end
