//
//  DCCustionHeadView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCustionHeadView : UICollectionReusableView

/** 筛选点击回调 */
@property (nonatomic, copy) dispatch_block_t filtrateClickBlock;
/** //切换视图浏览回调 */
@property (nonatomic, copy) dispatch_block_t changeViewClickBlock;

@end
