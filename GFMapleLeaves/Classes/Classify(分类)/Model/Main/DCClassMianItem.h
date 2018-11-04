//
//  DCClassMianItem.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DCCalssSubItem;
@interface DCClassMianItem : NSObject

/** 文标题  */
@property (nonatomic, copy ,readonly) NSString *title;


/** goods  */
@property (nonatomic, copy ,readonly) NSArray<DCCalssSubItem *> *goods;

@end
