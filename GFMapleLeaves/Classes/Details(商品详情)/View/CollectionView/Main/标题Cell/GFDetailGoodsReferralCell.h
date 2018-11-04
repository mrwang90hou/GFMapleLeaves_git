//
//  GFDetailGoodsReferralCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/31.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRecommendItem2.h"

@interface GFDetailGoodsReferralCell : UICollectionViewCell

/* 优惠按钮 */
@property (strong , nonatomic)UIButton *preferentialButton;

/** 分享按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t shareButtonClickBlock;

/*******************************************/

/* 标题图片(天猫、淘宝) */
@property (strong , nonatomic)UIImageView *goodsTitleImage;
/* 商品标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 淘宝|好货 */
//@property (strong , nonatomic)UILabel * goodgoodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 满减 */
@property (strong , nonatomic)UIButton *downPriceBtn;       //【异常点】
/* 淘宝,天猫 价格 */
@property (strong , nonatomic)UILabel *beforeDownPriceLabel;
/* 月销量 */
@property (strong , nonatomic)UILabel *mothSalesVolume;
/* 好评率 */
@property (strong , nonatomic)UILabel *goodsRateRLabel;     //【异常点】
/* 券 */
@property (strong , nonatomic)UIButton *getTicketButton;

/* 商品信息详细信息 */
@property (strong , nonatomic)DCRecommendItem2 *goodsDetailsItem;



@end
