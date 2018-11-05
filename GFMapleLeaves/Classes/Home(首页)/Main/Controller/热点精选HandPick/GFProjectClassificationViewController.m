//
//  GFProjectClassificationViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/11/5.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFProjectClassificationViewController.h"

// Controllers
#import "DCFootprintGoodsViewController.h"
#import "DCGoodDetailViewController.h"
#import "GFGoodDetailNewViewController.h"
// Models
#import "DCRecommendItem.h"
#import "DCRecommendItem2.h"

// Views
#import "DCNavSearchBarView.h"
#import "DCCustionHeadView.h"
#import "DCSwitchGridCell.h"
#import "DCListGridCell.h"
#import "DCColonInsView.h"
#import "DCSildeBarView.h"
#import "DCHoverFlowLayout.h"
// Vendors
#import <MJExtension.h>
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Categories

// Others

@interface GFProjectClassificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/* scrollerVew */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 切换视图按钮 */
@property (strong , nonatomic)UIButton *switchViewButton;
/* 自定义头部View */
@property (strong , nonatomic)DCCustionHeadView *custionHeadView;
@property (nonatomic, assign) NSInteger page;                          /**<页码*/
/* 具体商品数据源 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *setItem;
@property (strong , nonatomic)NSMutableArray<DCRecommendItem2 *> *goodsItems;
//@property (strong , nonatomic)NSMutableArray *goodsItems;
@property (nonatomic,strong) NSArray *typeArrStr;
/* 冒号工具View */
@property (strong , nonatomic)DCColonInsView *colonView;
/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isSwitchGrid;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 足迹按钮 */
@property (strong , nonatomic)UIButton *footprintButton;

@end

static CGFloat _lastContentOffset;

static NSString *const DCCustionHeadViewID = @"DCCustionHeadView";
static NSString *const DCSwitchGridCellID = @"DCSwitchGridCell";
static NSString *const DCListGridCellID = @"DCListGridCell";

@implementation GFProjectClassificationViewController

#pragma mark  - 防止警告
- (NSString *)goodPlisName
{
    return nil;
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        DCHoverFlowLayout *layout = [DCHoverFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCCustionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCustionHeadViewID]; //头部View
        [_collectionView registerClass:[DCSwitchGridCell class] forCellWithReuseIdentifier:DCSwitchGridCellID];//cell
        [_collectionView registerClass:[DCListGridCell class] forCellWithReuseIdentifier:DCListGridCellID];//cell
        [self.view addSubview:_collectionView];
        WEAKSELF;
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            [weakSelf requestData:weakSelf.typeNumber];
        }];
        
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData:weakSelf.typeNumber];
        }];
    }
    return _collectionView;
}
-(NSMutableArray *)goodsItems{
    if (!_goodsItems) {
        _goodsItems = [NSMutableArray array];
    }
    return _goodsItems;
}
-(NSArray *)typeArrStr{
    if (!_typeArrStr) {
//        _typeArrStr = @[@"女装",@"男装",@"内衣",@"美妆",@"配饰",@"鞋品",@"箱包",@"儿童",@"母婴",@"居家",@"美食",@"数码",@"家电",@"其他",@"车品",@"文体"];
        
        _typeArrStr = @[@"女装",@"母婴",@"美妆",@"家居",@"内衣",@"男装",@"美食",@"数码",@"鞋包",@"全部"];
        
    }
    return _typeArrStr;
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == DCBGColor)return;
    self.navigationController.navigationBar.barTintColor = DCBGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    type=0全部，1女装，2男装，3内衣，4美妆，5配饰，6鞋品，7箱包，8儿童，9母婴，10居家，11美食，12数码，13家电，14其他，15车品，16文体
//    （支持多类目筛选，如1,2获取类目为女装、男装的商品，逗号仅限英文逗号）
//    NSArray *typeArrStr =  @[@"全部",@"女装",@"男装",@"内衣",@"美妆",@"配饰",@"鞋品",@"箱包",@"儿童",@"母婴",@"居家",@"美食",@"数码",@"家电",@"其他",@"车品",@"文体"];
    
    self.title = [self.typeArrStr objectAtIndex:self.typeNumber];
    [self setUpNav];
    
    [self setUpColl];
    
    [self setUpData];
    
    [self setUpSuspendView];

}

#pragma mark - initialize
- (void)setUpColl
{
    // 默认列表视图
    _isSwitchGrid = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 加载数据
- (void)setUpData
{
    _setItem = [DCRecommendItem mj_objectArrayWithFilename:_goodPlisName];
    [self requestData:self.typeNumber];
}

-(void)clearData{
    [self.goodsItems removeAllObjects];
    [self.collectionView reloadData];
}

//今日值得买
-(void)requestData:(NSInteger)type{
    [SVProgressHUD showWithStatus:@"正在加载"];
    self.page = 1;
    NSDictionary *dict=@{
                         //flag=0综合查询,1优惠券面值高到低，2优惠券面值低到高，3券后价由高到低，4、券后价由低到高，5，销量由高到低，6，销量由低到高
                         @"page":@(self.page),
                         @"flag":@"0",
                         @"name":[self.typeArrStr objectAtIndex:type]
                         };
    [GCHttpDataTool getCatnameListWithDict:dict typeNumber:type success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self loadSuccessBlockWith:responseObject];
            //回到主线程更新UI -> 撤销遮罩
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.goodsItems = [goodsItems copy];
//                [self.collectionView reloadData];
//            });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
        [SVProgressHUD dismiss];
    }];
    [self.collectionView.mj_footer resetNoMoreData];
}
-(void)loadMoreData:(NSInteger)type{
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *dict=@{
                         //flag=0综合查询,1优惠券面值高到低，2优惠券面值低到高，3券后价由高到低，4、券后价由低到高，5，销量由高到低，6，销量由低到高
                         @"page":@(self.page),
                         @"flag":@"0"
                         };
    [GCHttpDataTool getCatnameListWithDict:dict typeNumber:type success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self loadSuccessBlockWith:responseObject];
        //回到主线程更新UI -> 撤销遮罩
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                self.goodsItems = [goodsItems copy];
        //                [self.collectionView reloadData];
        //            });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
        [SVProgressHUD dismiss];
    }];
    [self.collectionView.mj_footer resetNoMoreData];
}

-(void)loadSuccessBlockWith:(id)responseObject{
//    NSMutableArray<DCRecommendItem2 *> *goodsItems = [NSMutableArray array];
    self.page = self.page + 1;
    [self.collectionView.mj_header endRefreshing];
    NSArray *dataArray = responseObject[@"data"];
    for (NSDictionary *dict in dataArray) {
        DCRecommendItem2 *model = [DCRecommendItem2 new];
        //                model.itemid = [dict[@"itemid"] intValue];
        model.itemid = [dict objectForKey:@"itemid"];
        model.itemtitle = dict[@"itemtitle"];
        model.itemdesc = dict[@"itemdesc"];
        model.itemprice = dict[@"itemprice"];
        model.itemsale = dict[@"itemsale"];
        model.todaysale = [dict objectForKey:@"todaysale"];
        if ((NSNull*)model.todaysale == [NSNull null]) {
            model.todaysale = @"";
        }
        model.itempic = dict[@"itempic"];
        model.itemendprice = dict[@"itemendprice"];
        model.shoptype = dict[@"shoptype"];
        model.couponurl = dict[@"couponurl"];
        model.couponmoney = dict[@"couponmoney"];
        model.videoid = dict[@"videoid"];
        model.tkmoney = dict[@"tkmoney"];
//        [goodsItems addObject:model];
        [self.goodsItems addObject:model];
//        [self.goodsItems addObjectsFromArray:goodsItems];
    }
//    NSMutableArray<DCRecommendItem2 *>  *arr = [NSMutableArray array];
//    arr = self.goodsItems;
//    [arr addObjectsFromArray:[goodsItems copy]];
//    self.goodsItems = [arr copy];
//    [self.goodsItems addObjectsFromArray:[goodsItems copy]];
//    [self.goodsItems addObjectsFromArray:arr];
//    [self.goodsItems addObjectsFromArray:arr];
    self.collectionView.mj_footer.hidden = NO;
    if (dataArray.count == 0) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        self.collectionView.mj_footer.hidden = YES;
        return;
    }
    self.collectionView.mj_footer.hidden = NO;
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
}

#pragma mark - 导航栏
- (void)setUpNav
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"flzq_nav_jiugongge"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"flzq_nav_list"] forState:UIControlStateSelected];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(switchViewButtonBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.switchViewButton = button;
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = [UIColor whiteColor];
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    _topSearchView.frame = CGRectMake(50, 6, ScreenW - 110, 32);
//    self.navigationItem.titleView = _topSearchView;
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"搜索商品/店铺" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = PFR13Font;
    [_searchButton setImage:[UIImage imageNamed:@"group_home_search_gray"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.frame = CGRectMake(0, 0, _topSearchView.dc_width - 2 * DCMargin, _topSearchView.dc_height);
    [_topSearchView addSubview:_searchButton];
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 60, 40, 40);
    
    _footprintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_footprintButton];
    [_footprintButton addTarget:self action:@selector(footprintButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_footprintButton setImage:[UIImage imageNamed:@"ptgd_icon_zuji"] forState:UIControlStateNormal];
    _footprintButton.frame = CGRectMake(ScreenW - 50, ScreenH - 60, 40, 40);
    [_footprintButton setHidden:true];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _goodsItems.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DCListGridCell *cell = nil;
    cell = (_isSwitchGrid) ? [collectionView dequeueReusableCellWithReuseIdentifier:DCListGridCellID forIndexPath:indexPath] : [collectionView dequeueReusableCellWithReuseIdentifier:DCSwitchGridCellID forIndexPath:indexPath];
//    cell.youSelectItem = _setItem[indexPath.row];
    cell.youSelectItem = _goodsItems[indexPath.row];
    WEAKSELF
    if (_isSwitchGrid) { //列表Cell
        __weak typeof(cell)weakCell = cell;
        cell.colonClickBlock = ^{ // 冒号点击
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf setUpColonInsView:weakCell];
            [strongSelf.colonView setUpUI]; // 初始化
            strongSelf.colonView.collectionBlock = ^{
                NSLog(@"点击了收藏%zd",indexPath.row);
            };
            strongSelf.colonView.addShopCarBlock = ^{
                NSLog(@"点击了加入购物车%zd",indexPath.row);
            };
            strongSelf.colonView.sameBrandBlock = ^{
                NSLog(@"点击了同品牌%zd",indexPath.row);
            };
            strongSelf.colonView.samePriceBlock = ^{
                NSLog(@"点击了同价格%zd",indexPath.row);
            };
        };
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCCustionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCustionHeadViewID forIndexPath:indexPath];
        WEAKSELF
//        headerView.filtrateClickBlock = ^{//点击了筛选
//            [weakSelf filtrateButtonClick];
//        };
        headerView.changeViewClickBlock = ^{
//            [weakSelf filtrateButtonClick];
            [weakSelf switchViewButtonBarItemClick:self.switchViewButton];
        };
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (_isSwitchGrid) ? CGSizeMake(ScreenW, 140) : CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 60);//列表、网格Cell
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 40); //头部
}

#pragma mark - 边间距属性默认为0
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
    
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_isSwitchGrid) ? 0 : 4;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"点击了商品第%zd",indexPath.row);
//    [SVProgressHUD showInfoWithStatus:@"等待开发完善！"];
    GFGoodDetailNewViewController *dcVc = [[GFGoodDetailNewViewController alloc] init];
//    dcVc.goodTitle = _setItem[indexPath.row].main_title;
//    dcVc.goodPrice = _setItem[indexPath.row].price;
//    dcVc.goodSubtitle = _setItem[indexPath.row].goods_title;
//    dcVc.shufflingArray = _setItem[indexPath.row].images;
//    dcVc.goodImageView = _setItem[indexPath.row].image_url;
    dcVc.shufflingArray = @[_goodsItems[indexPath.row].itempic];
    dcVc.goodsDetailsItem = [_goodsItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dcVc animated:YES];

    WEAKSELF
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.colonView.dc_x = ScreenW;
    }completion:^(BOOL finished) {
        [weakSelf.colonView removeFromSuperview];
    }];
}

#pragma mark - 滑动代理
//开始滑动的时候记录位置
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _lastContentOffset = scrollView.contentOffset.y;
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.contentOffset.y > _lastContentOffset){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.collectionView.frame = CGRectMake(0, 20, ScreenW, ScreenH - 20);
        self.view.backgroundColor = [UIColor whiteColor];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.collectionView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH);
        self.view.backgroundColor = DCBGColor;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;

    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.footprintButton.dc_y = (strongSelf.backTopButton.hidden == YES) ? ScreenH - 60 : ScreenH - 110;
    }];
    
}

#pragma mark - 冒号工具View
- (void)setUpColonInsView:(UICollectionViewCell *)cell
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //单列
        self.colonView = [[DCColonInsView alloc] init];
        
    });
    [cell addSubview:_colonView];
    
    _colonView.frame = CGRectMake(cell.dc_width, 0, cell.dc_width - 120, cell.dc_height);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.colonView.dc_x = 120;
    }];
}

#pragma mark - 点击事件

#pragma mark - 切换视图按钮点击
- (void)switchViewButtonBarItemClick:(UIButton *)button
{
    button.selected = !button.selected;
    _isSwitchGrid = !_isSwitchGrid;
    
    [_colonView removeFromSuperview];
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
#pragma mark - 商品浏览足迹
- (void)footprintButtonClick
{
    [self setUpAlterViewControllerWith:[DCFootprintGoodsViewController alloc] WithDistance:ScreenW * 0.4];
}

#pragma mark - 商品筛选
- (void)filtrateButtonClick
{
    [DCSildeBarView dc_showSildBarViewController];
}

#pragma mark - 点击搜索
- (void)searchButtonClick
{
    
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance
{
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionRight;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
