//
//  DCUserInfo.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/19.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "JKDBModel.h"

@interface DCUserInfo : JKDBModel

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *userimage;

@property (nonatomic, copy) NSString *birthDay;

@property (nonatomic, copy) NSString *defaultAddress;

@end
