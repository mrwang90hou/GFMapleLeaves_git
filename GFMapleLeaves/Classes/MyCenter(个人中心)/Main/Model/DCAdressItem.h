//
//  DCAdressItem.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/19.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCAdressItem : NSObject

@property(nonatomic,strong) NSNumber *ID;

/* 用户名 */
@property (nonatomic, copy) NSString *userName;
/* 用户电话 */
@property (nonatomic, copy) NSString *userPhone;
/* 选择地址地址 */
@property (nonatomic, copy) NSString *chooseAdress;
/* 用户地址 */
@property (nonatomic, copy) NSString *userAdress;

/* 默认地址 1为正常 2为默认 */
@property (nonatomic, copy) NSString *isDefault;


/* 行高 */
@property (assign , nonatomic)CGFloat cellHeight;

@end
