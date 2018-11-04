//
//  GFGoodDetailNewCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/31.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFGoodDetailNewCell.h"

// Controllers

// Models
#import "DCCommentPicItem.h"
// Views

// Vendors
#import "SDPhotoBrowser.h"
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface GFGoodDetailNewCell ()

/* 昵称 */
@property (strong , nonatomic)UILabel *nickName;
/* 图片数量 */
@property (strong , nonatomic)UILabel *picNum;

/* imageArray */
@property (copy , nonatomic)NSArray *imagesArray;

@end

@implementation GFGoodDetailNewCell


- (void)awakeFromNib {
    [super awakeFromNib];
//    UINib *nib = [UINib nibWithNibName:@"MyPurchaseRecordFooterCell" bundle:[NSBundle mainBundle]];
//    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"MyPurchaseRecordId"];
}

#pragma mark - Intial
//- (instancetype)initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        [self setUpUI];
//    }
//    return self;
//}
//
//- (void)setUpUI
//{
//    self.backgroundColor = [UIColor whiteColor];
//    _pciImageView = [[UIImageView alloc] init];
////    _pciImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _pciImageView.contentMode = UIViewContentModeScaleToFill;
//    _pciImageView.semanticContentAttribute = UIDisplayGamutUnspecified;
//    _pciImageView.userInteractionEnabled = YES;
//    [self addSubview:_pciImageView];
//
//}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    [_pciImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.equalTo(self);
//    }];
//}
@end
