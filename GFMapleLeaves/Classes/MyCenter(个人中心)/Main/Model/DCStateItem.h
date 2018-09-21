//
//  DCStateItem.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCStateItem : NSObject

/* 显示文字图片 */
@property (nonatomic, assign) BOOL showImage;

/* 图片或数字 */
@property (nonatomic, copy) NSString *imageContent;

/* 标题 */
@property (nonatomic, copy) NSString *stateTitle;

/* 背景色 */
@property (nonatomic, assign) BOOL bgColor;

@end
