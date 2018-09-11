//
//  DCTabBarController.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
    DCTabBarControllerHome = 0,  //首页
    DCTabBarControllerBeautyStore = 1, //美店
    DCTabBarControllerMediaList = 2,  //美媚榜
    DCTabBarControllerMeiXin = 3, //美信
    DCTabBarControllerPerson = 4, //个人中心
};

@interface DCTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end
