//
//  GCHttpDataTool.h
//  goockr_dustbin
//
//  Created by csl on 2016/11/23.
//  Copyright © 2016年 csl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpCommon.h"
#import "GCHttpTool.h"

@interface GCHttpDataTool : NSObject


/**
 注册
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) registerWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;

/**
 密码登录
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) pwdLoginWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//  删除功能接口【验证码登录】【获取验证号登录验证码】【获取忘记密码验证码】【忘记密码】【重设密码】
#pragma mark -GET数据请求
/**
 猜你喜欢列表

 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) getGuestLikeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;



/**
 首页5张图片数据（今日值得买，今日关注。。。。）
 
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) getMenuListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 首页广告Baner图片

 @param dict 传入参数
 @param success  成功回调
 @param failure 失败回调
 */
+ (void) getADListWithDictWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 今日值得买

 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) getTodayBuyWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;



/**
 视频购买
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getVideoListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 9块9包邮
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getNineListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 超级划算
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getJHSListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 限时抢购
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getLimitListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 分类列表信息
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getCatListCodeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 通过分类名称点击进入列表信息
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getCatnameListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;


/**
 搜索商品
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void) getSearchGoodsWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;

/**
 客服信息
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getServiceInfoWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;

/**
 动态列表
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getLiveListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;



/**
 商品详情接口
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getGoodsDetailWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;


/**
 商品详情[图片列表]接口
 
 @param dict 传入字典
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
+ (void)getGoodsDetailPagePICWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;








@end
