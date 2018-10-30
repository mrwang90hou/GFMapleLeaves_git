//
//  GFDetailGoodsReferralCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/10/31.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFDetailGoodsReferralCell : UICollectionViewCell

/* 商品标题 */
//@property (strong , nonatomic)UILabel *goodTitleLabel;
/* 商品价格 */
//@property (strong , nonatomic)UILabel *goodPriceLabel;
/* 商品小标题 */
//@property (strong , nonatomic)UILabel *goodSubtitleLabel;

/* 优惠按钮 */
@property (strong , nonatomic)UIButton *preferentialButton;

/** 分享按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t shareButtonClickBlock;

/*******************************************/

/* 淘宝 logo */
@property (strong , nonatomic)UIImageView *tbLogoImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 淘宝|好货 */
//@property (strong , nonatomic)UILabel * goodGridLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 满减 */
@property (strong , nonatomic)UIButton *downPriceBtn;
/* 天猫价格 */
@property (strong , nonatomic)UILabel *tCatPriceLabel;
/* 月销量 */
@property (strong , nonatomic)UILabel *mothSalesVolumeLabel;
/* 好评率 */
@property (strong , nonatomic)UILabel *goodsRateRLabel;
/* 券 */
@property (strong , nonatomic)UIButton *ticketBtn;




@end
