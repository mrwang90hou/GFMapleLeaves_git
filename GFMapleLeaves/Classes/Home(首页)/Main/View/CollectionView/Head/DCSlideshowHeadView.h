//
//  DCSlideshowHeadView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSlideshowHeadView : UICollectionReusableView

/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;
/* 轮播图的跳转链接数组 */
@property (copy , nonatomic)NSArray *imageJumpURLArray;
@end
