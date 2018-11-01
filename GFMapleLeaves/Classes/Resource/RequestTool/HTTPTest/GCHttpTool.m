//
//  GCHttpTool.m
//  goockr_heart
//
//  Created by csl on 16/10/4.
//  Copyright © 2016年 csl. All rights reserved.
//

#import "GCHttpTool.h"

#import "AFNetworking.h"


@implementation GCHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(MQError *))failure
{
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 设置请求格式
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setTimeoutInterval:5.0];
    // 设置返回格式
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    //判断请求参数中是否包含   “code” 或者 “token”
    if ([DCObjManager dc_readUserDataForKey:@"token"]&&[DCObjManager dc_readUserDataForKey:@"uid"]) {
        
        [mgr.requestSerializer setValue:[DCObjManager dc_readUserDataForKey:@"token"] forHTTPHeaderField:@"token"];
        [mgr.requestSerializer setValue:[DCObjManager dc_readUserDataForKey:@"uid"] forHTTPHeaderField:@"uid"];
    }
    //调出请求头
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //拼接参数的序列化器，使用的正确的序列化器
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回数据的序列化器
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 可接受的文本参数规格
    //        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    
//    //Get请求
//    [mgr GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        // 这里可以获取到目前的数据请求的进度
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 请求成功，解析数据
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//
//        NSLog(@"%@", dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 请求失败
//        NSLog(@"%@", [error localizedDescription]);
//    }];
    
    [mgr GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *mJsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSLog(@"获取到的数据为：\n%@", [[NSString alloc] initWithData:mJsonData encoding:NSUTF8StringEncoding]);
        
        
        if ([responseObject[@"code"] intValue]!=1000)
        {
            MQError *err=[[MQError alloc] init];
            err.code=[responseObject[@"code"] intValue];
            err.msg = responseObject[@"message"];
            failure(err);
        }else{
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        MQError *err=[MQError errorWithCode:-1 msg:@"网络请求失败"];
        
        failure(err);
        
    }];
}

+ (void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(MQError *error))failure;
{
   
    //[3]	(null)	@"NSLocalizedDescription" : @"Request failed: unacceptable content-type: text/plain"	
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    "PhoneNumber":"13679587672",
    //    "Password":"123456"
    
    //  NSMutableDictionary *dict = @{@"PhoneNumber":@"13679587672",@"Password":@"123456"};
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 5.0f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *mJsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSLog(@"获取到的数据为：\n%@", [[NSString alloc] initWithData:mJsonData encoding:NSUTF8StringEncoding]);
//        NSDictionary *mResult = [NSJSONSerialization JSONObjectWithData:mJsonData options:NSJSONReadingMutableContainers error:nil];
        //        NSLog(@"获取到的数据为：%@",[responseObject description]);
//        NSLog(@"获取到的数据为：%@",[mResult description]);

        
        if ([responseObject[@"code"] intValue]!=1000)
        {
            MQError *err=[[MQError alloc] init];;
            
            err.code=[responseObject[@"code"] intValue];
            
            err.msg=responseObject[@"message"];
            
            failure(err);
            
        }else{
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MQError *err=[MQError errorWithCode:-1 msg:@"网络请求失败"];
        
        failure(err);

        
    }];
}

//responseObject是接口返回来的Unicode数据
- (NSString *)transformDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\"u" withString:@"\"U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@""  withString:@"\""];
    NSString *tempStr3 = [[@"" stringByAppendingString:tempStr2] stringByAppendingString:@""];
     NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
     NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
     return str;
 }

@end

























