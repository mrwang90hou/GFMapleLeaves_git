//
//  GFHTTPSearchTool.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFHTTPSearchTool.h"

@implementation GFHTTPSearchTool

+(void)getGuessGuestlikeWithDict:(NSDictionary *)dict success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSString *str = @"http://wxagent.yeehot.com/public/index.php/api/index/guestlike";
    NSString *urlString=[NSString stringWithFormat:@"%@",str];
    NSLog(@"当前URL请求【猜猜客户喜欢的内容【猜你喜欢列表】】为：%@",urlString);
    NSLog(@"parameters参数为：%@",dict);
    
    [RequestTool requestWithType:1 URL:str parameter: dict successComplete:^(id responseObject) {

        NSData *mJsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        NSLog(@"执行网络成功：\n%@", [[NSString alloc] initWithData:mJsonData encoding:NSUTF8StringEncoding]);
        
        // Step6:进行数据解析
        NSError *mJsonError;
        NSDictionary *mResult = [NSJSONSerialization JSONObjectWithData:mJsonData options:NSJSONReadingMutableContainers error:&mJsonError];
        
        NSLog(@"mResult 为：%@",mResult);
        
        // Step7:回调请求结果
        if (mJsonError) {
            NSLog(@"JSON解析失败！");
//            responseBlock(nil, mJsonError);
            
            // 提示数据解析错误
//            [vc showNoticeHudWithTitle:NSNewLocalizedString(@"all_dialog_title", nil)  subtitle:NSNewLocalizedString(@"all_parse_data_error", nil) onView:vc.view inDuration:2];
        } else {
            NSLog(@"JSON解析成功！");
            //结果不为1000状态 统一处理【错误代码】
            if ([self valueStatus:mResult] == NO) {
                
                return ;
            }
//            responseBlock(mResult, nil);
            
            success(mResult);
            
        }
    } failureComplete:^(NSError *error) {
        
        
        
        failure(error);
    }];
}

+ (BOOL)valueStatus:(NSDictionary *)responseDictionary
{
    NSLog(@"code = %d",[[responseDictionary objectForKey:@"code"] intValue]);
    NSLog(@"message = %@",[responseDictionary objectForKey:@"message"]);
    
    if ([[responseDictionary objectForKey:@"code"] intValue] == 1000 && [[responseDictionary objectForKey:@"code"] stringValue] != nil) {
//        NSString *err = [responseDictionary objectForKey:@"err"];
        // 提示错误
        return YES;
    }
    return YES;
}



@end
