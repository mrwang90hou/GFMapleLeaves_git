//
//  DCSwitchGridCell.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/13.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCRecommendItem.h"
#import "DCRecommendItem2.h"
//@class DCRecommendItem;

@interface DCSwitchGridCell : UICollectionViewCell

/* 推荐数据 */
//@property (strong , nonatomic)DCRecommendItem *youSelectItem;
/* 最终数据 */
@property (strong , nonatomic)DCRecommendItem2 *youSelectItem;

@end
