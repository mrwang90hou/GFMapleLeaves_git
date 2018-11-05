//
//  GFHomeViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/26.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFHomeViewController.h"

// Controllers
#import "GFNavigationController.h"
#import "DCGoodsSetViewController.h"
#import "GFCommodityClassifyViewController.h"
#import "DCMyTrolleyViewController.h"
#import "DCGoodDetailViewController.h"
#import "DCGMScanViewController.h"
#import "GFGoodDetailViewController.h"
#import "DCGoodBaseViewController.h"
#import "GFGoodDetailNewViewController.h"
#import "GFReturnWebViewController.h"

#import "GFProjectClassificationViewController.h"
#import "GFHandPinkViewController.h"
#import "GFTodayWorthBuyViewController.h"
#import "GFBuyByVideoViewController.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
#import "DCRecommendItem2.h"

// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DCGoodsYouLikeCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //倒计时标语
#import "GFHotRecommendedHeadView.h"    //热门推荐
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"
#import "GFHTTPSearchTool.h"
//
#import "GFSearchViewController.h"
#import "PYSearchViewController.h"
#import "PYTempViewController.h"


@interface GFHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 广告轮播图 */
@property (nonatomic,strong) DCSlideshowHeadView *adView;
@property (nonatomic, assign) NSMutableArray *adBanerArr;
@property (nonatomic, assign) NSArray *adBanerURLArr;

/* 首页5张图片数据（今日值得买，今日关注。。。。） */
@property (nonatomic,strong)  NSArray *hotViewCellImageArr;
@property (nonatomic,strong)  NSArray *hotViewCellImageURLArray;
//双十一购物连接
@property (nonatomic,strong)  NSString *shop11Url;


/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *youLikeItem;
//@property (strong , nonatomic)NSMutableArray<DCRecommendItem2 *> *youLikeItem2;
@property (strong , nonatomic)NSMutableArray *youLikeItem2;
@property (nonatomic, assign) NSInteger page;                          /**<页码*/
/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@property (nonatomic,strong) PYSearchViewController *pyVC;

//headerView点击 btn
@property (nonatomic,strong) UIButton *headerViewBtn;

@end
/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
static NSString *const GFHotRecommendedHeadViewID = @"GFHotRecommendedHeadView";
/* foot */
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";

@implementation GFHomeViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        [_collectionView registerClass:[DCNewWelfareCell class] forCellWithReuseIdentifier:DCNewWelfareCellID];
        
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[GFHotRecommendedHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFHotRecommendedHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID];
        
        [self.view addSubview:_collectionView];
        WEAKSELF;
        [weakSelf requestData];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    return _collectionView;
}


-(NSMutableArray *)youLikeItem2{
    if (!_youLikeItem2) {
        _youLikeItem2 = [NSMutableArray array];
    }
    return _youLikeItem2;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestAllData];

    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
    [self setUpGIFRrfresh];
    
    [self getNetwork];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = DCBGColor;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
    }
}


#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

#pragma mark - 刷新
- (void)setUpRecData
{
    WEAKSELF
    [DCSpeedy dc_callFeedback]; //触动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
//    _youLikeItem2 = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods2.plist"];
}

- (void)requestDataOld{
    /*
//    NSString *NewCheckCode = [self makeCheckCodeWithUserID:[NSString stringWithFormat:@"%@",userID] loginID:[NSString stringWithFormat:@"%@",loginID] loginCheckCode:checkCode rand:rand];
//    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
//    [param setObject:@"2" forKey:@"platformType"];
//    [param setObject:@"0" forKey:@"isWeb"];
//    [param setObject:userID forKey:@"userID"];
//    [param setObject:loginID forKey:@"loginID"];
//    [param setObject:pageSize forKey:@"pageSize"];
//    [param setObject:page forKey:@"page"];
//    [param setObject:rand forKey:@"rand"];
//    [param setObject:NewCheckCode forKey:@"checkCode"];
    
    [GFHTTPSearchTool getGuessGuestlikeWithDict:nil success:^(id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"获取成功！"];
        NSDictionary *mResult = responseObject;
        NSDictionary *datas = [mResult objectForKey:@"data"];
        NSLog(@"datas = %@",datas);
    
//        "total": 3562,
//        "per_page": 12,
//        "current_page": 1,
//        "last_page": 297,
        
        
    } failure:^(NSError *error) {

        [SVProgressHUD showSuccessWithStatus:@"获取失败！"];
    }];
    */
//    self.adBanerArr = [NSMutableArray arrayWithCapacity:5];
    //获取 首页广告Baner图片
    [GCHttpDataTool getADListWithDictWithDict:nil success:^(id responseObject) {
//        NSDictionary *dic = responseObject[@"data"];
        NSMutableArray *adBanerArr = [NSMutableArray array];
        NSMutableArray *imageJumpURLArray = [NSMutableArray array];
        NSArray *dataArray = responseObject[@"data"];
        for (NSDictionary *dict in dataArray) {
            [adBanerArr addObject:dict[@"adimg"]];
            [imageJumpURLArray addObject:dict[@"jumpurl"]];
        }
        //回到主线程更新UI -> 撤销遮罩
        dispatch_async(dispatch_get_main_queue(), ^{
            self.adView.imageGroupArray = adBanerArr;
            self.adView.imageJumpURLArray = imageJumpURLArray;
            [self.collectionView reloadData];
        });
//        self.adView.imageGroupArray = self.adBanerArr;
//        [self.collectionView reloadData];
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
}

-(void)requestAllData{
    
    NSMutableArray *adBanerArr = [NSMutableArray array];
    NSMutableArray *adBanerURLArr = [NSMutableArray array];
    
    NSMutableArray *hotViewCellImageArr = [NSMutableArray array];
    NSMutableArray *hotViewCellImageURLArray = [NSMutableArray array];
    
    NSMutableArray<DCRecommendItem2 *> *youLikeItem2 = [NSMutableArray array];
    NSMutableArray *shop11UrlArray = [NSMutableArray array];
//    NSMutableArray *mAraayVo = [NSMutableArray new];
    
    // 创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    // 创建全局并行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        // 【请求一】获取 首页广告Baner图片
        [GCHttpDataTool getADListWithDictWithDict:nil success:^(id responseObject) {
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dict in dataArray) {
                [adBanerArr addObject:dict[@"adimg"]];
                [adBanerURLArr addObject:dict[@"jumpurl"]];
            }
            self.adBanerArr = adBanerArr;
//            回到主线程更新UI -> 撤销遮罩
            dispatch_async(dispatch_get_main_queue(), ^{
//                self.adView.imageGroupArray = adBanerArr;
//                self.adView.imageJumpURLArray = imageJumpURLArray;
                self.adView.imageGroupArray = adBanerArr;
                [self.collectionView reloadData];
            });
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
        
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        // 【请求二】首页5张图片数据（今日值得买，今日关注。。。。）
        [GCHttpDataTool getMenuListWithDict:nil success:^(id responseObject) {
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dict in dataArray) {
                [hotViewCellImageArr addObject:dict[@"img"]];
                [hotViewCellImageURLArray addObject:dict[@"url"]];
                if ([dict[@"id"] intValue] == 1) {
                    [shop11UrlArray addObject:dict[@"url"]];
                }
            }
            //回到主线程更新UI -> 撤销遮罩
            dispatch_async(dispatch_get_main_queue(), ^{
                self.shop11Url = shop11UrlArray[0];
                [self.collectionView reloadData];
            });
//            self.adBanerArr = adBanerArr;
            dispatch_semaphore_signal(semaphore);
        } failure:^(MQError *error) {
            
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    });
    /*// 【请求三】猜你喜欢列表
    dispatch_group_async(group, queue, ^{
     
        [GCHttpDataTool getGuestLikeWithDict:nil success:^(id responseObject) {
            
            NSArray *dataArray = responseObject[@"data"];
            for (NSDictionary *dict in dataArray) {
                DCRecommendItem2 *model = [DCRecommendItem2 new];
//                model.itemid = [dict[@"itemid"] intValue];
                model.itemid = [dict objectForKey:@"itemid"];
                
                model.itemtitle = dict[@"itemtitle"];
                model.itemdesc = dict[@"itemdesc"];
                model.itemprice = dict[@"itemprice"];
                model.itemsale = dict[@"itemsale"];
//                model.todaysale = [dict[@"todaysale"] intValue];
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
                [youLikeItem2 addObject:model];
            }
            //回到主线程更新UI -> 撤销遮罩
            dispatch_async(dispatch_get_main_queue(), ^{
                self.youLikeItem2 = [youLikeItem2 copy];
                [self.collectionView reloadData];
            });
            dispatch_semaphore_signal(semaphore);
        } failure:^(MQError *error) {
            [SVProgressHUD showErrorWithStatus:error.msg];
        }];
    });
    */
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //在这里 进行请求后的方法，回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            /*更新UI操作*/
            //轮播图
            
//            self.adView.imageGroupArray = adBanerArr;
//            self.adBanerArr = adBanerArr;
//            self.adBanerURLArr = adBanerURLArr;
            self.hotViewCellImageArr = hotViewCellImageArr;
            self.hotViewCellImageURLArray = hotViewCellImageURLArray;
//            self.shop11Url =
//            self.youLikeItem2 = [youLikeItem2 copy];
            
            [self.collectionView reloadData];
        });
    });
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    if (DCIsiPhoneX) {
//        NSLog(@"📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱This is iPhoneX!📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱");
        _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, 64)];
    }
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页【菜单】");
//        [SVProgressHUD showWithStatus:@"正在获取数据"];
//        [weakSelf requestData];
//        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
//        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了消息页面");
//        GFCommodityClassifyViewController *dcComVc = [GFCommodityClassifyViewController new];
//        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        NSLog(@"点击了首页购物车");
        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
        shopCarVc.isTabBar = YES;
        shopCarVc.title = @"购物车";
        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
//        GFSearchViewController *searchVc = [GFSearchViewController new];
//        searchVc.title = @"搜索";
//        [weakSelf presentViewController:searchVc animated:YES completion:nil];
        [weakSelf trunToSearchView];
    };
    _topToolView.qrCodeButtonClickBlock = ^{
        NSLog(@"点击了首页二维码 扫一扫");
        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    [self.view addSubview:_topToolView];
    
}
#pragma mark -跳转至搜索栏
- (void)trunToSearchView{
    // 1. Create an Array of popular search
    //    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    NSArray *hotSeaches = @[@"小枫叶🍁", @"汉服", @"女装", @"iPhone X", @"小枫叶🍁", @"小米6", @"MacBook Pro"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入您要搜索的内容..." didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
        
    }];
//    searchViewController.searchBar.backgroundColor = [UIColor grayColor];
//    searchViewController.view.backgroundColor = [UIColor blueColor];
    
    searchViewController.navigationController.navigationBar.alpha = 1;
    searchViewController.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
//    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(8, 8, ScreenW-20, 28)];
//    [field setBackgroundColor:[UIColor blueColor]];
//
//    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(8, 8, ScreenW-20, 28)];
//    [search setBackgroundColor:[UIColor blackColor]];
//    [searchViewController setSearchTextField:field];
//    [searchViewController setSearchBar:nil];
//    [searchViewController setSearchBar:search];
    
    
//    searchViewController.cancelButton.enabled = false;
    
    
    UIImageView *qrCodeView = [[UIImageView alloc]init];
    qrCodeView.image = [UIImage imageNamed:@"group_home_scan"];
    qrCodeView.contentMode = UIViewContentModeCenter;
    [searchViewController.searchTextField setRightView:qrCodeView];
    [searchViewController.searchTextField setRightViewMode:UITextFieldViewModeAlways];
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigation_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backToRootView)];
    
    [searchViewController.navigationItem  setLeftBarButtonItem:btn];
    
    searchViewController.searchBarBackgroundColor = RGB(240, 240, 240);
    
//    searchViewController.prefersStatusBarHidden = NO;
//    [searchViewController.status
    
    // 3. Set style for popular search and search history
    if (/* DISABLES CODE */ (1)) {
        searchViewController.hotSearchStyle = 1;
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    } else {
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
        searchViewController.searchHistoryStyle = 0;
    }
    // 4. Set delegate
    searchViewController.delegate = self;
    
    self.pyVC = searchViewController;
    
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)backToRootView{
    //返回上一视图
    [self.pyVC.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    //返回根视图
//    [self.pyVC.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }
    if (section == 1 || section == 2 || section == 3) { //广告福利  倒计时  掌上专享
        return 0;
    }
    if (section == 4) { //推荐
        return GoodsHandheldImagesArray.count;
    }
    if (section == 5) { //猜你喜欢
//        NSString *str = [NSString stringWithFormat:@"_youLikeItem2.count=%lu",(unsigned long)self.youLikeItem2.count];
//        [SVProgressHUD showInfoWithStatus:str];
         return _youLikeItem2.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//菜单
        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == 1) {//广告福利（上2下1）
        DCNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewWelfareCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//倒计时（好货秒抢）
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 3) {//掌上专享
        DCExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCExceedApplianceCellID forIndexPath:indexPath];
        cell.goodExceedArray = GoodsRecommendArray;
        gridcell = cell;
    }
    else if (indexPath.section == 4) {//推荐
        DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
        if (self.hotViewCellImageArr.count != 0) {
            cell.handheldImage = self.hotViewCellImageArr[indexPath.row];
        }else{
            cell.handheldImage = @"icon_default_loadError128";
        }
        gridcell = cell;
    }
    else {//猜你喜欢
        DCGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsYouLikeCellID forIndexPath:indexPath];
        cell.getTicketBlock = ^{
            NSLog(@"点击了第%zd商品的领券",indexPath.row);
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"您已成功领取第%zd商品的代金券",indexPath.row+1]];
        };
        cell.youLikeItem = _youLikeItem2[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
//            self.adView.imageGroupArray = self.adBanerArr;
            self.adView = headerView;
            reusableview = headerView;
        }else if (indexPath.section == 2){
            DCCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 4){
            GFHotRecommendedHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFHotRecommendedHeadViewID forIndexPath:indexPath];
            [headerView.titleImageView setImage:SETIMAGE(HomeBottomViewGIFImage)];//【今日值得购买】
            UIButton *headerViewBtn = [[UIButton alloc]init];
            [headerView addSubview:headerViewBtn];
            [headerViewBtn setBackgroundColor:[UIColor clearColor]];
            [headerViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(headerView);
            }];
            [headerViewBtn addTarget:self action:@selector(headerViewBtnAction) forControlEvents:UIControlEventTouchUpInside];
            self.headerViewBtn = headerViewBtn;
            reusableview = headerView;
        }else if (indexPath.section == 5){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeImageView setImage:[UIImage imageNamed:@"home_icon_guestyoulike"]];//【猜你喜欢】
           reusableview = headerView;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            DCTopLineFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID forIndexPath:indexPath];
            reusableview = footview;
        }else if (indexPath.section == 3){
            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
            reusableview = footerView;
        }else if (indexPath.section == 5) {
            DCOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID forIndexPath:indexPath];
            reusableview = footview;
        }
    }
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake(ScreenW/5 , ScreenW/5 + DCMargin);
    }
    if (indexPath.section == 1) {//广告
//        return CGSizeMake(ScreenW, 180);
        return CGSizeMake(ScreenW, 0);
    }
    if (indexPath.section == 2) {//计时
//        return CGSizeMake(ScreenW, 150);
        return CGSizeMake(ScreenW, 0);
    }
    if (indexPath.section == 3) {//掌上
//        return CGSizeMake(ScreenW,ScreenW * 0.35 + 120);
        return CGSizeMake(ScreenW,0);
    }
    if (indexPath.section == 4) {//推荐组
        return [self layoutAttributesForItemAtIndexPath2:indexPath].size;
    }
    if (indexPath.section == 5) {//猜你喜欢
        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 80);
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.24);
        }else{
            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
        }
    }
    return layoutAttributes;
}
//采用该布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath2:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.1);
        }else if (indexPath.row == 1 || indexPath.row == 2){
            layoutAttributes.size = CGSizeMake((ScreenW-1) * 0.5, ScreenW * 0.35);
        }else if(indexPath.row == 3){
            layoutAttributes.size = CGSizeMake((ScreenW-2) * 0.5, ScreenW * 0.35);
        }else{
            layoutAttributes.size = CGSizeMake((ScreenW-2) * 0.25, ScreenW * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return CGSizeMake(ScreenW, 230); //图片滚动的宽高
    }
    
//    if (section == 2 || section == 4 || section == 5) {//猜你喜欢的宽高
//        return CGSizeMake(ScreenW, 40);  //推荐适合的宽高
//    }
    if (section == 2 ) {
        return CGSizeMake(ScreenW, 0);
    }
    if (section == 4) {
        return CGSizeMake(ScreenW, 0);
//        return CGSizeMake(ScreenW, 0);
    }
    if (section == 5) {//猜你喜欢的宽高
        return CGSizeMake(ScreenW, 25);  //推荐适合的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
//        return CGSizeMake(ScreenW, 180);  //Top头条的宽高
//        return CGSizeMake(ScreenW, 120);  //Top头条的宽高
//        return CGSizeMake(ScreenW, 80);  //Top头条的宽高
        return CGSizeMake(ScreenW, 0);  //Top头条的宽高
    }
    if (section == 3) {
//        return CGSizeMake(ScreenW, 80); // 滚动广告
        return CGSizeMake(ScreenW, 0); // 滚动广告
    }
    if (section == 5) {
        return CGSizeMake(ScreenW, 40); // 结束
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return (section == 4 || section == 5) ? 4 : 0;
    return section == 4 ? 1:section == 5 ? 4 : 0;
    
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return (section == 4 || section == 5) ? 4 : 0;
    return section == 4 ? 1:section == 5 ? 4 : 0;
}
#pragma mark -cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
//        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
//        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
//        goodSetVc.typeNumber = indexPath.row;
//        [self.navigationController pushViewController:goodSetVc animated:YES];
        GFProjectClassificationViewController *vc = [[GFProjectClassificationViewController alloc]init];
        vc.typeNumber = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            GFReturnWebViewController *vc = [GFReturnWebViewController new];
            vc.webViewUrl = self.shop11Url;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //方案二
        else{
            GFHandPinkViewController *vc = [GFHandPinkViewController new];
            vc.typeNumber = indexPath.row-1;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        //方案一
//        else if(indexPath.row == 1){
//            GFTodayWorthBuyViewController *vc = [GFTodayWorthBuyViewController new];
////            vc.goodPlisName = @"ClasiftyGoods.plist";
////            vc.typeNumber = indexPath.row;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else if(indexPath.row == 2){
//            GFBuyByVideoViewController *vc = [GFBuyByVideoViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        
    }else if (indexPath.section == 5){
        NSLog(@"点击了推荐的第%ld个商品",(long)indexPath.row);
//        [SVProgressHUD showInfoWithStatus:@"点击【代金券】领取"];
//        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
//        DCGoodBaseViewController *dcVc = [[DCGoodBaseViewController alloc] init];
//        GFGoodDetailViewController *dcVc = [[GFGoodDetailViewController alloc] init];
        GFGoodDetailNewViewController *dcVc = [[GFGoodDetailNewViewController alloc] init];
//        dcVc.goodsID = _youLikeItem2[indexPath.row].itemid;
//        dcVc.goodTitle = _youLikeItem2[indexPath.row].itemtitle;
//        dcVc.goodPrice = _youLikeItem2[indexPath.row].itemprice;
//        dcVc.goodSubtitle = _youLikeItem2[indexPath.row].itemdesc;
//        dcVc.shufflingArray = @[_youLikeItem2[indexPath.row].itempic];
//        dcVc.goodImageView = _youLikeItem2[indexPath.row].itempic;
        dcVc.goodsDetailsItem = [_youLikeItem2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:dcVc animated:YES];
    }
}

-(void)headerViewBtnAction{
    [SVProgressHUD showInfoWithStatus:@"headerViewBtnAction"];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 5; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"相关词 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 消息
- (void)messageItemClick
{
}
#pragma mark -底部collectionView下拉刷新
//今日值得买
-(void)requestData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    self.page = 1;
    NSDictionary *dict=@{
                         @"page":@(self.page)
                         };
    // 【请求三】猜你喜欢列表
    [GCHttpDataTool getGuestLikeWithDict:dict success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self loadSuccessBlockWith:responseObject];
        //回到主线程更新UI -> 撤销遮罩
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.youLikeItem2 = [youLikeItem2 copy];
//            [self.collectionView reloadData];
//        });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
    
    [self.collectionView.mj_footer resetNoMoreData];
}

-(void)loadMoreData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSDictionary *dict=@{
                         @"page":@(self.page)
                         };
    [GCHttpDataTool getGuestLikeWithDict:dict success:^(id responseObject) {
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
    NSMutableArray<DCRecommendItem2 *> *youLikeItem2 = [NSMutableArray array];
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
        //                model.todaysale = [dict[@"todaysale"] intValue];
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
//        [youLikeItem2 addObject:model];
        [self.youLikeItem2 addObject:model];
    }
    
////    回到主线程更新UI -> 撤销遮罩
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.youLikeItem2 addObjectsFromArray:[youLikeItem2 copy]];
//            [self.collectionView reloadData];
//        });
//    [self.youLikeItem2 addObjectsFromArray:[youLikeItem2 copy]];
//    self.youLikeItem2 = [youLikeItem2 copy];
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



@end
