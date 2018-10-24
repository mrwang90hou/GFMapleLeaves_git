//
//  GFGuessLike.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/21.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GFGuessLikeItem :NSObject



@property (nonatomic , copy) NSString              * dataNumber;


/*第1组：【录像设置】 5个
 录像分辨率
 录音
 开机自动录像
 碰撞触发灵敏度
 循环录像
 */
@property (nonatomic , copy) NSString              * videoResolution;
@property (nonatomic , copy) NSString              * recordingOrNot;
@property (nonatomic , copy) NSString              * videoAuto;
@property (nonatomic , copy) NSString              * accidentSensitivity;
@property (nonatomic , copy) NSString              * loopVideo;

/*第2组：【拍照设置】 3个
 拍照分辨率
 连拍
 时间水印
 */

@property (nonatomic , copy) NSString              * imageResolution;
@property (nonatomic , copy) NSString              * shoots;
@property (nonatomic , copy) NSString              * logoTimeStamp;
@property (nonatomic , copy) NSString              * logoTimeStampDebug;
/*第3组：【通用设置】 5个
 关机延时录像
 停车监控
 闪烁频率
 高动态HDR
 屏幕翻转
 */

@property (nonatomic , copy) NSString              * shutdownDelayVideo;
@property (nonatomic , copy) NSString              * parkingMonitoring;
@property (nonatomic , copy) NSString              * flickerFrequency;
@property (nonatomic , copy) NSString              * highDynamicHDR;
@property (nonatomic , copy) NSString              * screenRotation;

/*第4组：【设备设置】 5个
 固件版本
 SD卡信息
 Wi-Fi设置
 同步时间
 恢复出厂设置
 */
@property (nonatomic , copy) NSString              * firmwareVersion;
@property (nonatomic , copy) NSString              * sdCardInformation;
@property (nonatomic , copy) NSString              * wi_fiSettings;
@property (nonatomic , copy) NSString              * synchronizeTime;
@property (nonatomic , copy) NSString              * factoryDataReset;

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


            //"guide_article": null,
            //"videoid": "0",
            //"activity_type": "普通活动",
            //"clickurl": null,
            //"userid": "4013954355",
            //"sellernick": "豫硕旗舰店",
            //"online_users": null,
            //"tktype": "营销计划",
            //"tkrates": 20,
            //"cuntao": 0,
            //"tkmoney": 5.76,
            //"tkurl": "",
            //"couponreceive2": 14500,
            //"couponnum": 50000,
            //"couponexplain": "单笔满38元可用",
            //"couponstarttime": 1536076800,
            //"couponendtime": 1536335999,
            //"start_time": null,
            //"end_time": null,
            //"starttime": 1536076800,
            //"isquality": 0,
            //"report_status": 0,
            //"general_index": null,
            //"seller_name": null,
            //"original_img": null,
            //"original_article": null,
            //"is_explosion": null,
            //"couponsurplus": "24000",
            //"couponreceive": "26000",
            //"todaycouponreceive": null,
            //"planlink": null,
            //"discount": null,
            //"me": null,
            //"status": 1,
            //"activityid": null,
            //"coupon_condition": null




@end


