//
//  GFGoodDetailViewController.m
//  GFMapleLeaves
//
//  Created by 王宁 on 2018/10/29.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//


#import "GFGoodDetailViewController.h"

// Controllers
#import "DCGoodBaseViewController.h"
#import "DCGoodParticularsViewController.h"
#import "DCGoodCommentViewController.h"
#import "DCMyTrolleyViewController.h"
#import "DCToolsViewController.h"
// Models

// Views

// Vendors

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others


// Views
#import "DCLIRLButton.h"

#import "DCDetailShufflingHeadView.h" //头部轮播
#import "GFDetailGoodsReferralCell.h"  //商品标题价格介绍
#import "DCDetailShowTypeCell.h"      //种类
#import "DCShowTypeOneCell.h"
#import "DCShowTypeTwoCell.h"
#import "DCShowTypeThreeCell.h"
#import "DCShowTypeFourCell.h"
#import "DCDetailServicetCell.h"      //服务
#import "DCDetailLikeCell.h"          //猜你喜欢
#import "DCDetailOverFooterView.h"    //尾部结束
#import "DCDetailPartCommentCell.h"   //部分评论
#import "GFDetailCustomHeadView.h"    //自定义头部
#import "GFCheckBabyDetailsCell.h"      //查看宝贝详情

// Vendors
#import "AddressPickerView.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
// Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Others

/*UIScrollViewDelegate*/
@interface GFGoodDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;




@property (strong, nonatomic) UIView *bgView;
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;



/* 返回按钮 */
@property (strong, nonatomic) UIButton *returnBtn;
@end

//header
static NSString *DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";
static NSString *GFDetailCustomHeadViewID = @"GFDetailCustomHeadView";
//cell
static NSString *GFDetailGoodsReferralCellID = @"GFDetailGoodsReferralCell";

static NSString *DCShowTypeOneCellID = @"DCShowTypeOneCell";
static NSString *DCShowTypeTwoCellID = @"DCShowTypeTwoCell";
static NSString *DCShowTypeThreeCellID = @"DCShowTypeThreeCell";
static NSString *DCShowTypeFourCellID = @"DCShowTypeFourCell";
static NSString *GFCheckBabyDetailsCellID = @"GFCheckBabyDetailsCell";


static NSString *DCDetailServicetCellID = @"DCDetailServicetCell";
static NSString *DCDetailLikeCellID = @"DCDetailLikeCell";
static NSString *DCDetailPartCommentCellID = @"DCDetailPartCommentCell";
//footer
static NSString *DCDetailOverFooterViewID = @"DCDetailOverFooterView";


static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation GFGoodDetailViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(ScreenW, (ScreenH - 50) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0; //Y
        layout.minimumInteritemSpacing = 0; //X
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //        _collectionView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH - 50);
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];
        
        //注册header
        [_collectionView registerClass:[DCDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID];
        [_collectionView registerClass:[GFDetailCustomHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailCustomHeadViewID];
        //注册Cell
        [_collectionView registerClass:[GFDetailGoodsReferralCell class] forCellWithReuseIdentifier:GFDetailGoodsReferralCellID];
        [_collectionView registerClass:[GFCheckBabyDetailsCell class] forCellWithReuseIdentifier:GFCheckBabyDetailsCellID];
        [_collectionView registerClass:[DCDetailLikeCell class] forCellWithReuseIdentifier:DCDetailLikeCellID];
        [_collectionView registerClass:[DCDetailPartCommentCell class] forCellWithReuseIdentifier:DCDetailPartCommentCellID];
        [_collectionView registerClass:[DCDetailServicetCell class] forCellWithReuseIdentifier:DCDetailServicetCellID];
        //注册Footer
        [_collectionView registerClass:[DCDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
        
    }
    return _collectionView;
}

#pragma mark - LifeCyle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self setUpNav];
    
    [self setUpBottomButton];
    [self setUpSuspendView];

}

#pragma mark - initialize
- (void)setUpInit
{
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.scrollerView.backgroundColor = self.view.backgroundColor;
//    self.scrollerView.contentSize = CGSizeMake(self.view.dc_width * self.childViewControllers.count, 0);
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    
    //初始化
    lastSeleArray_ = [NSArray array];
    lastNum_ = 0;
    
}

#pragma mark - 底部按钮(收藏 开心分享 领券)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏
    
    [self setUpRightTwoButton];//开心分享 领券
}
#pragma mark - 收藏
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"home_details_collection_icon",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = ScreenW * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
//    for (NSInteger i = 0; i < imagesNor.count; i++) {
    for (NSInteger i = 0; i < 1; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
//    NSArray *titles = @[@"加入购物车",@"立即购买"];
    NSArray *titles = @[@"开心分享",@"领券¥50"];
    NSArray *imagesNor = @[@"home_details_share_icon",@"home_offer_icon"];
    NSArray *imagesBG = @[@"home_share_bg",@"home_offer_bg"];
    CGFloat buttonW = ScreenW * 0.8 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
//        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button setBackgroundImage:SETIMAGE([imagesBG objectAtIndex:i]) forState:UIControlStateNormal];
        [button setImage:SETIMAGE([imagesNor objectAtIndex:i]) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
    }
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 100, 40, 40);
}
#pragma mark - 导航栏设置
- (void)setUpNav
{
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, K_HEIGHT_NAVBAR/2-20+K_HEIGHT_STATUSBAR, 30, 30)];
    [self.view addSubview:returnBtn];
    [returnBtn setImage:SETIMAGE(@"hoem_Details_Upper left corner_return") forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnToHomeVC) forControlEvents:UIControlEventTouchUpInside];
    self.returnBtn = returnBtn;
}

-(void)returnToHomeVC{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

#pragma mark - 点击事件
- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
        shopCarVc.isTabBar = YES;
        shopCarVc.title = @"购物车";
        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2 || button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:SELECTCARTORBUY object:nil userInfo:dict];
        });
    }
}


#pragma 退出界面
- (void)selfAlterViewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 ) ? 2 : 1;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            GFDetailGoodsReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFDetailGoodsReferralCellID forIndexPath:indexPath];
            cell.gridLabel.text = _goodTitle;
            cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodPrice];
//            cell.goodSubtitleLabel.text = _goodSubtitle;
            [DCSpeedy dc_setUpLabel:cell.gridLabel Content:_goodTitle IndentationFortheFirstLineWith:cell.priceLabel.font.pointSize * 1];
            cell.shareButtonClickBlock = ^{
//                [weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
            };
            gridcell = cell;
        }else if (indexPath.row == 1){
            //查看宝贝参数详情
            GFCheckBabyDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFCheckBabyDetailsCellID forIndexPath:indexPath];
            gridcell = cell;
        }
    }else if (indexPath.section == 1){
        DCDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailPartCommentCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
        gridcell = cell;
    }else if (indexPath.section == 2){
        DCDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailLikeCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID forIndexPath:indexPath];
            headerView.shufflingArray = _shufflingArray;
            reusableview = headerView;
        }else if (indexPath.section == 2){
            GFDetailCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailCustomHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 2) {
            DCDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID forIndexPath:indexPath];
            reusableview = footerView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
            footerView.backgroundColor = DCBGColor;
            reusableview = footerView;
        }
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //商品详情
        return (indexPath.row == 0) ? CGSizeMake(ScreenW, [DCSpeedy dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height + [DCSpeedy dc_calculateTextSizeWithText:_goodPrice WithTextFont:20 WithMaxW:ScreenW - DCMargin * 6].height + DCMargin * 2) : CGSizeMake(ScreenW, 35);
    }else if (indexPath.section == 1){//商品评价部分展示
        return CGSizeMake(ScreenW, (ScreenH-50)/5*4+40);
//        return CGSizeMake(ScreenW, 0);
    }else if (indexPath.section == 2){//商品猜你喜欢
        return CGSizeMake(ScreenW, (ScreenW / 3 + 60) * 2 + 20);
    }else{
        return CGSizeZero;
    }
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(ScreenW, ScreenH * 0.55) : ( section == 2) ? CGSizeMake(ScreenW, 30) : CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    //    return (section == 5) ? CGSizeMake(ScreenW, 35) : CGSizeMake(ScreenW, DCMargin);
    return (section == 2) ? CGSizeMake(ScreenW, 35) : CGSizeMake(ScreenW, 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if (indexPath.section == 0 && indexPath.row == 0) {
    //        [self scrollToDetailsPage]; //滚动到详情页面
    //    }else if (indexPath.section == 2 && indexPath.row == 0) {
    //        [self chageUserAdress]; //跟换地址
    //    }else if (indexPath.section == 1){ //属性选择
    //        DCFeatureSelectionViewController *dcFeaVc = [DCFeatureSelectionViewController new];
    //        dcFeaVc.lastNum = lastNum_;
    //        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
    //        dcFeaVc.goodImageView = _goodImageView;
    //        [self setUpAlterViewControllerWith:dcFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    //    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        
    }
}

#pragma mark - 视图滚动
- (void)setUpViewScroller{
    WEAKSELF
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, ScreenH);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
//    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [UIView animateWithDuration:0.8 animations:^{
//            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
//            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
//        } completion:^(BOOL finished) {
//            [weakSelf.webView.scrollView.mj_header endRefreshing];
//        }];
//    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
    _returnBtn.hidden = (scrollView.contentOffset.y > ScreenH/2) ? YES : NO;
}

#pragma mark - 点击事件
#pragma mark - 更换地址
- (void)chageUserAdress
{
//    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//        DCLoginViewController *dcLoginVc = [DCLoginViewController new];
//        [self presentViewController:dcLoginVc animated:YES completion:nil];
//        return;
//    }
//    _adPickerView = [AddressPickerView shareInstance];
//    [_adPickerView showAddressPickView];
//    [self.view addSubview:_adPickerView];
//
//    WEAKSELF
//    _adPickerView.block = ^(NSString *province,NSString *city,NSString *district) {
//        DCUserInfo *userInfo = UserInfoData;
//        NSString *newAdress = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
//        if ([userInfo.defaultAddress isEqualToString:newAdress]) {
//            return;
//        }
//        userInfo.defaultAddress = newAdress;
//        [userInfo save];
//        [weakSelf.collectionView reloadData];
//    };
}

#pragma mark - 滚动到详情页面
- (void)scrollToDetailsPage
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SCROLLTODETAILSPAGE object:nil];
    });
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    if (self.scrollerView.contentOffset.y > ScreenH) {
        [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else{
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma mark - 加入购物车成功
- (void)setUpWithAddSuccess
{
    [SVProgressHUD showSuccessWithStatus:@"加入购物车成功~"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:1.0];
}
@end
