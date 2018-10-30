//
//  GFTabBarController.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,GFTabBarControllerType){
    GFTabBarControllerHome = 0,  //首页
    GFTabBarControllerBeautyStore = 1, //美店
    GFTabBarControllerMediaList = 2,  //美媚榜
    GFTabBarControllerMeiXin = 3, //美信
    GFTabBarControllerPerson = 4, //个人中心
};

@interface GFTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)GFTabBarControllerType tabVcType;

@end
