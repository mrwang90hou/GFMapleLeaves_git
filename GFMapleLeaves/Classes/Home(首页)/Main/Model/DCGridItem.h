//
//  DCGridItem.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCGridItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ,readonly) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ,readonly) NSString *gridColor;

@end

