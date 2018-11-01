//
//  GFHTTPSearchTool.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RequestTool.h"

#import "HttpCommon.h"
//#import "MQError.h"

@interface GFHTTPSearchTool : NSObject


/**
 猜猜客户喜欢的内容【猜你喜欢列表】
 @param dict 传入参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void) getGuessGuestlikeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


+ (BOOL)valueStatus:(NSDictionary *)responseDictionary;
//
//
///**
// 密码登录
//
// @param dict 传入参数
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void) pwdLoginWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
///**
// 获取验证号登录验证码
//
// @param dict 传入参数
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void) getLoginSmsCodeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 获取忘记密码验证码
//
// @param dict 传入参数
// @param success  成功回调
// @param failure 失败回调
// */
//+ (void) getForgetSmsCodeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 忘记密码
//
// @param dict 传入参数
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void) forgetPwdWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 注册
//
// @param dict 传入参数
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void) registerWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//+ (void) registerBeforeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
///**
// 重设密码(user.verify)
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) resetPasswordWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 绑定设备
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) bindingWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 获取设备列表
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) deviceListWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 设备权限转移
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) deviceChangeUserWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 获取设备权限转移验证码
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) deviceChangeUserSmsCodeWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 获取选中的设备
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) selectDeviceWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
//
///**
// 更换选中的设备
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void) changeSelectDeviceWithDict:(NSDictionary *)dict success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
//
///**
// 删除已绑定的设备
//
// @param dict 传入字典
// @param success 请求成功的回调
// @param failure 请求失败的回调
// */
//+ (void)delDeviceRefWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure;
//
//







@end
