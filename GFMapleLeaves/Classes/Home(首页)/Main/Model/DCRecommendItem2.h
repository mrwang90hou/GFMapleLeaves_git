//
//  DCRecommendItem2.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCRecommendItem2 : NSObject
//
///** 图片URL */
//@property (nonatomic, copy) NSString *image_url;
///** 商品标题 */
//@property (nonatomic, copy) NSString *main_title;
///** 商品小标题 */
//@property (nonatomic, copy) NSString *goods_title;
///** 商品价格 */
//@property (nonatomic, copy) NSString *price;
///** 剩余 */
//@property (nonatomic, copy) NSString *stock;
///** 属性 */
//@property (nonatomic, copy) NSString *nature;
/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;

/**
 *  状态码（1成功，0失败或没有数据返回）
 */
@property (nonatomic, copy) NSString *code;
/**
 *  宝贝ID
 */
@property (nonatomic, copy) NSString *itemid;
/**
 *  宝贝标题
 */
@property (nonatomic, copy) NSString *itemtitle;
/**
 *  宝贝推荐语
 */
@property (nonatomic, copy) NSString *itemdesc;
/**
 *  在售价
 */
@property (nonatomic, copy) NSString *itemprice;
/**
 *  宝贝月销量
 */
@property (nonatomic, copy) NSString *itemsale;
/**
 *  当天销量
 */
@property (nonatomic, copy) NSString *todaysale;

/**
 *  宝贝主图原始图像（由于图片原图过大影响加载速度，建议加上后缀_310x310.jpg，如https://img.alicdn.com/imgextra/i2/3412518427/TB26gs7bb7U5uJjSZFFXXaYHpXa_!!3412518427.jpg_310x310.jpg）
 */
@property (nonatomic, copy) NSString *itempic;
/**
 *  宝贝券后价
 */
@property (nonatomic, copy) NSString *itemendprice;
/**
 *  店铺类型： 天猫店（B） 淘宝店（C）
 */
@property (nonatomic, copy) NSString *shoptype;
/**
 *  优惠券链接
 */
@property (nonatomic, copy) NSString *couponurl;
/**
 *  优惠券金额
 */
@property (nonatomic, copy) NSString *couponmoney;
/**
 *  商品视频ID（id大于0的为有视频单，视频拼接地址http://cloud.video.taobao.com/play/u/1/p/1/e/6/t/1/+videoid+.mp4）
 */
@property (nonatomic, copy) NSString *videoid;
/**
 *  预计可得（宝贝价格 * 佣金比例 / 100）
 */
@property (nonatomic, copy) NSString *tkmoney;

@end
