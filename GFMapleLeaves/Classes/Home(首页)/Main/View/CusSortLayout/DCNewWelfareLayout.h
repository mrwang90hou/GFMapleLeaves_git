//
//  DCNewWelfareLayout.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/29.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCNewWelfareLayoutDelegate <NSObject>

@optional;

/* 头部高度 */
-(CGFloat)dc_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
/* 尾部高度 */
-(CGFloat)dc_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;

@end

@interface DCNewWelfareLayout : UICollectionViewFlowLayout


@property (nonatomic, assign) id<DCNewWelfareLayoutDelegate>delegate;

@end
