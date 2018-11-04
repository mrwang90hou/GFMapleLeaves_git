//
//  GFGoodDetailNewViewController.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/31.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRecommendItem2.h"
@interface GFGoodDetailNewViewController : UIViewController

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

/* 商品信息详细信息 */
@property (strong , nonatomic)DCRecommendItem2 *goodsDetailsItem;

/* 商品标题 */
@property (strong , nonatomic)NSString *goodsID;
/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;
/* 商品轮播图 */
@property (copy , nonatomic)NSArray *shufflingArray;

@end
