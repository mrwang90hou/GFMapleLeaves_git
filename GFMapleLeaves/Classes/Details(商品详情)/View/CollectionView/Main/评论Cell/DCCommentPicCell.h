//
//  DCCommentPicCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/27.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCCommentPicItem;
@interface DCCommentPicCell : UICollectionViewCell

/* 图片评论 */
@property (strong , nonatomic)DCCommentPicItem *picItem;

/* 图片 */
@property (strong , nonatomic)UIImageView *pciImageView;

@end
