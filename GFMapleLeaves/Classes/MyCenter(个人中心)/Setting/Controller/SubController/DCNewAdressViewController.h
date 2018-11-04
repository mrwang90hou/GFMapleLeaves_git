//
//  DCNewAdressViewController.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/19.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger,DCSaveAdressType){
    DCSaveAdressNewType = 0,  //保存
    DCSaveAdressChangeType = 1, //编辑
};


@class DCAdressItem;
@interface DCNewAdressViewController : UIViewController


/* type */
@property (nonatomic,assign) DCSaveAdressType saveType;

/* 更改数据 */
@property (strong , nonatomic)DCAdressItem *adressItem;

@end
