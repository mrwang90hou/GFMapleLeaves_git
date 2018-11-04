
//
//  GFInfoItemCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/20.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFInfoItemCell.h"

// Controllers

// Models
#import "DCStateItem.h"
// Views
#import "GFInfoStateItemCell.h"
#import "GFInfoStateItemFooterView.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface GFInfoItemCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 数据 */
@property (strong , nonatomic)NSMutableArray<DCStateItem *> *stateItem;
@end

static NSString *const GFInfoStateItemCellID = @"GFInfoStateItemCell";

static NSString *const GFInfoStateItemFooterViewID = @"GFInfoStateItemFooterView";

@implementation GFInfoItemCell

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;

        //注册Cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GFInfoStateItemCell class]) bundle:nil] forCellWithReuseIdentifier:GFInfoStateItemCellID];
        //注册footerView
        [_collectionView registerClass:[GFInfoStateItemFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFInfoStateItemFooterViewID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray<DCStateItem *> *)stateItem
{
    if (!_stateItem) {
        _stateItem = [NSMutableArray array];
    }
    return _stateItem;
}

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = DCBGColor;
    
    _stateItem = [DCStateItem mj_objectArrayWithFilename:@"GFInfoItemCell.plist"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _stateItem.count;
}


#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GFInfoStateItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFInfoStateItemCellID forIndexPath:indexPath];
    cell.stateItem = _stateItem[indexPath.row];//赋值
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        GFInfoStateItemFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFInfoStateItemFooterViewID forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}
//设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenW-2) / 3, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(ScreenW, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
@end
