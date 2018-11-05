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

//GFConditionFilterView实现筛选窗体
#import "GFConditionFilterView.h"
#import "UIView+Extension.h"

@interface GFProjectClassificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    // *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
    NSArray *_selectedDataSource1Ary;
    NSArray *_selectedDataSource2Ary;
    NSArray *_selectedDataSource3Ary;
    
    GFConditionFilterView *_conditionFilterView;
}
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
@property (nonatomic, assign) NSInteger flag;                          /**<排序类型*/
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
//            [self.goodsItems removeAllObjects];
            [self clearData];
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
    
    [self setUpConditionFilterView];
    
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

-(void)setUpConditionFilterView{
    //方案二
    // FilterBlock 选择下拉菜单选项触发
    //        GFConditionFilterView *headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFConditionFilterViewID forIndexPath:indexPath];
    //        _conditionFilterView =
    _conditionFilterView = [GFConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary) {
        
        // 1.isFilter = YES 代表是用户下拉选择了某一项
        // 2.dataSource1Ary 选择后第一组选择的数据  2 3一次类推
        // 3.如果你的项目没有清空筛选条件的功能，可以无视else 我们的app有清空之前的条件，重置，所以才有else的逻辑
        
        if (isFilter) {
            //网络加载请求 存储请求参数
            _selectedDataSource1Ary = dataSource1Ary;
            _selectedDataSource2Ary = dataSource2Ary;
            _selectedDataSource3Ary = dataSource3Ary;
            
        }else{
            // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
            _selectedDataSource1Ary = @[@"综合排序"];
            _selectedDataSource2Ary = @[];
            _selectedDataSource3Ary = @[];
            NSLog(@"isFilter = NO !综合排序!");
            //记录当前请求的type 数值
        }
        //判断当前的状态选择，并进行网络请求
        [self startRequest];
    }];
    _conditionFilterView.y += 64;
    // 设置初次加载显示的默认数据 即初次加载还没有选择操作之前要显示的标题数据
    //    _selectedDataSource1Ary = @[@"综合排序"];
    //    _selectedDataSource1Ary = @[@"优惠券"];
    //    _selectedDataSource2Ary = @[@"券后价"];
    //    _selectedDataSource3Ary = @[@"销量"];
    // 传入数据源，对应三个tableView顺序
    //    _conditionFilterView.dataAry1 = @[@"1-1",@"1-2",@"1-3",@"1-4",@"1-5"];
    //    _conditionFilterView.dataAry2 = @[@"2-1",@"2-2",@"2-3",@"2-4",@"2-5"];
    //    _conditionFilterView.dataAry3 = @[@"3-1",@"3-2",@"3-3",@"3-4",@"3-5"];
    _conditionFilterView.dataAry1 = @[@"综合排序",@"优惠券从高到低",@"优惠券从低到高"];
    _conditionFilterView.dataAry2 = @[@"券后价由高到低",@"券后价由低到高"];
    _conditionFilterView.dataAry3 = @[@"销量由高到低",@"销量由低到高"];
    
    // 初次设置默认显示数据(标题)，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary];
    /** 外部手动筛选加载*/
    [_conditionFilterView choseSortFromOutsideWithFirstSort:_selectedDataSource1Ary WithSecondSort:_selectedDataSource2Ary WithThirdSort:_selectedDataSource3Ary];
    //    [self.view addSubview:_conditionFilterView];
}

- (void)startRequest
{
    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    NSString *source3 = [NSString stringWithFormat:@"%@",_selectedDataSource3Ary.firstObject];
    
    //    NSMutableArray *nsArr = [NSMutableArray new];
    //    [nsArr addObject:source1];
    //    [nsArr addObject:source2];
    //    [nsArr addObject:source3];
    NSArray *strArr = @[source1,source2,source3];
    //    NSArray *strArr = [nsArr copy];
    NSString *typeStr = @"";
    for (NSString *str in strArr) {
        //        if (str.length != 0) {
        //        if (![str isEqual:[NSNull null]]) {
        //        if(![str isKindOfClass:[NSNull class]] && ![str isEqual:[NSNull null]] && str != nil){
        if (![str isEqualToString:@"(null)"]) {
            typeStr = str;
            break;
        }
    }
    NSLog(@"typeStr = %@",typeStr);
    int flagNumer = 0;
    NSArray *typeStrArr = @[@"综合排序",@"优惠券从高到低",@"优惠券从低到高",@"券后价由高到低",@"券后价由低到高",@"销量由高到低",@"销量由低到高"];
    for (int i = 0; i<typeStrArr.count; i++) {
        if ([typeStr isEqualToString:[typeStrArr objectAtIndex:i]]) {
            flagNumer = i;
            break;
        }
    }
    NSLog(@"当前查询方法为：%@,第%d种查询方法！！！",[typeStrArr objectAtIndex:flagNumer],flagNumer);
    //flag=0综合查询,1优惠券面值高到低，2优惠券面值低到高，3券后价由高到低，4、券后价由低到高，5，销量由高到低，6，销量由低到高
    //    NSDictionary *dic = [_conditionFilterView keyValueDic];
    // 可以用字符串在dic换成对应英文key
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    if (self.flag == flagNumer) {
        return;
    }
    self.flag = flagNumer;
    [self ScrollToTop];//滚回页面顶部
    //清空数据
    [self.goodsItems removeAllObjects];
    [self.collectionView reloadData];
    [self requestData:self.typeNumber];
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
                         @"flag":@(self.flag),
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
                         @"flag":@(self.flag),
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
        
        [headerView addSubview:_conditionFilterView];
        [_conditionFilterView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView);
        }];
        _conditionFilterView.changeViewClickBlock = ^{
            //            [weakSelf filtrateButtonClick];
            [weakSelf switchViewButtonBarItemClick:self.switchViewButton];
        };
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
