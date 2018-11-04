//
//  GFGuessLike.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GFGuessLikeItem :NSObject



@property (nonatomic , copy) NSString              * dataNumber;



@end


@interface GFGuessLike : NSObject


/** 总计条数  */
@property (nonatomic, assign ,readonly) int totalPages;
/** 当前页条数  */
@property (nonatomic, assign ,readonly) int perPage;
/** 当前页数  */
@property (nonatomic, assign ,readonly) int currentPage;
/** 最后页码值  */
@property (nonatomic, assign ,readonly) int lastPage;

@property (nonatomic, copy ,readonly) NSArray<GFGuessLikeItem *> * gfGuessLikeItem;


/** 商品ID */
@property (nonatomic, assign ,readonly) int goodsID;
/** 商品ItemsID */
@property (nonatomic, assign ,readonly) int goodsItemID;
/** 商品Items标题  */
@property (nonatomic, copy ,readonly) NSString *goodsTitle;
/** 商品小标题 */
@property (nonatomic, copy ,readonly) NSString *goodsShortTitle;
/** 商品描述 */
@property (nonatomic, copy ,readonly) NSString *goodsDescribe;
/** 商品价格 */
@property (nonatomic, assign ,readonly) double goodsPrice;
/** 商品销量 */
@property (nonatomic, assign ,readonly) int goodsSale;
/** 商品销量2 */
@property (nonatomic, assign ,readonly) int goodsSale2;
/** 商品今日销量 */
@property (nonatomic, assign ,readonly) int goodsTodaySale;
/** 商品图片URL */
@property (nonatomic, copy ,readonly) NSString *goodsPicUrl;
/** 商品图片复制 */
@property (nonatomic, copy ,readonly) NSString *goodsiPicCopy;

/** 淘宝天猫？tbcat */
@property (nonatomic, copy ,readonly) NSString *tbcat;
/** 商品最终价格 */
@property (nonatomic, assign ,readonly) double goodsEndPrice;

/** 商铺类型 */
@property (nonatomic, copy ,readonly) NSString *shopType;
/** 优惠券 URL 链接 */
@property (nonatomic, copy ,readonly) NSString *couponUrl;
/** 优惠券 价格 */
@property (nonatomic, assign ,readonly) double couponMoney;
//"couponmoney": 10,
//"is_brand": 0,            商标？
//"is_live": 0,             在线？




/** 说明文章 */
@property (nonatomic, copy ,readonly) NSString *shoptype;

/** 商品最终价格 */
//@property (nonatomic, assign ,readonly) double goodsEndPrice;
/** 商品最终价格 */
//@property (nonatomic, assign ,readonly) double goodsEndPrice;
/** 商品最终价格 */
//@property (nonatomic, assign ,readonly) double goodsEndPrice;


/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 属性 */
@property (nonatomic, copy ,readonly) NSString *nature;
/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;




@end


