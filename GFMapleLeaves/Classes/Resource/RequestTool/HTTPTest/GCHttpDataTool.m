//
//  GCHttpDataTool.m
//  goockr_dustbin
//
//  Created by csl on 2016/11/23.
//  Copyright © 2016年 csl. All rights reserved.
//

#import "GCHttpDataTool.h"

#import "AFNetworking.h"




@implementation GCHttpDataTool



+(void)registerWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",Register_URL];
    NSLog(@"当前URL请求【注册】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
    
}


+ (void)pwdLoginWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",Login_URL];
    NSLog(@"当前URL请求【密码登录】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
    
}

+(void)getGuestLikeWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@?",GuestLike_URL];
    // Step1:拼接请求的参数
    for (NSString *key in [dict allKeys]) {
        urlString = [NSString stringWithFormat:@"%@%@=%@&", urlString, key, [dict objectForKey:key]];
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"当前URL请求【猜你喜欢列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+(void)getMenuListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@",MenuList_URL];
    NSLog(@"当前URL请求【首页5张图片数据（今日值得买，今日关注。。。。）】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

    
}

+(void)getADListWithDictWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",ADList_URL];
    NSLog(@"当前URL请求【首页广告Baner图片】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}




+(void)getTodayBuyWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",TodayBuy_URL];
    NSLog(@"当前URL请求【今日值得买】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}

+(void)getHandPinkWithDict:(NSDictionary *)dict typeNumber:(NSInteger)type success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSArray *arrStr =  @[@"今日关注",@"视频购买",@"限时抢购",@"超级划算",@"9块9包邮"];
    NSArray *typeURL = @[TodayBuy_URL,VideoList_URL,LimitList_URL,CJHSList_URL,NineList_URL];
    NSString *urlString=[NSString stringWithFormat:@"%@?",[typeURL objectAtIndex:type]];
    // Step1:拼接请求的参数
    for (NSString *key in [dict allKeys]) {
        urlString = [NSString stringWithFormat:@"%@%@=%@&", urlString, key, [dict objectForKey:key]];
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"当前URL请求【%@】为：%@",[arrStr objectAtIndex:type],urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
    
}

+(void)getVideoListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",VideoList_URL];
    NSLog(@"当前URL请求【视频购买】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}


+(void)getNineListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",NineList_URL];
    NSLog(@"当前URL请求【9块9包邮】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        NSLog(@"error.code = %d , error.msg = %@",error.code,error.msg);
//        [ hud hudUpdataTitile:@"绑定产品成功" hideTime:KHudSuccessShowShortTime];
        failure(error);
        
    }];
}


+ (void)getJHSListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CJHSList_URL];
    NSLog(@"当前URL请求【超级划算】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];

}


+(void)getLimitListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",LimitList_URL];
    NSLog(@"当前URL请求【限时抢购】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getCatListCodeWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CatList_URL];
    NSLog(@"当前URL请求【分类列表信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

+ (void)getCatnameListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",CatNameList_URL];
    NSLog(@"当前URL请求【通过分类名称点击进入列表信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getSearchGoodsWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",Search_URL];
    NSLog(@"当前URL请求【搜索商品】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

+ (void)getServiceInfoWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",ServiceInfo_URL];
    
    NSLog(@"当前URL请求【客服信息】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

+ (void)getLiveListWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
    NSString *urlString=[NSString stringWithFormat:@"%@",LiveList_URL];
    
    NSLog(@"当前URL请求【动态列表】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    
    [GCHttpTool GET:urlString parameters:dict success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
    
}

+ (void)getGoodsDetailWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
//    NSString *urlString=[NSString stringWithFormat:@"%@",GoodsDetail_URL];
    
    // Step1:拼接请求的参数
    NSString *url = [NSString stringWithFormat:@"%@?", GoodsDetail_URL];
    for (NSString *key in [dict allKeys]) {
        url = [NSString stringWithFormat:@"%@%@=%@&", url, key, [dict objectForKey:key]];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"当前URL请求【商品详情接口】为：%@",url);
    NSLog(@"parameters参数为：%@",dict);
    
    [GCHttpTool GET:url parameters:nil success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}


+ (void)getGoodsDetailPagePICWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(MQError *))failure
{
//    NSString *urlString=[NSString stringWithFormat:@"%@",GoodsDetailPIC_URL];
    // Step1:拼接请求的参数
    NSString *url = [NSString stringWithFormat:@"%@?", GoodsDetailPIC_URL];
    for (NSString *key in [dict allKeys]) {
        url = [NSString stringWithFormat:@"%@%@=%@&", url, key, [dict objectForKey:key]];
//        url = [NSString stringWithFormat:@"%@%@=%@&", url, key, [NSString stringWithFormat:@"%@",[dict objectForKey:key]]];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"当前URL请求【商品详情[图片列表]接口】为：%@",url);
    NSLog(@"parameters参数为：%@",dict);
//    url = [@"https://h5api.m.taobao.com/h5/mtop.taobao.detail.getdesc/6.0/?data={\"id\":\"576219480627\"}" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [GCHttpTool GET2:url parameters:nil success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(MQError *error) {
        
        failure(error);
        
    }];
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //    NSRange range = {0,jsonString.length};
    //    //去掉字符串中的空格
    //    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}



@end
