//
//  GFGoodDetailNewViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/31.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//


#import "GFGoodDetailNewViewController.h"

// Controllers
#import "DCGoodBaseViewController.h"
#import "DCGoodParticularsViewController.h"
#import "DCGoodCommentViewController.h"
#import "DCMyTrolleyViewController.h"
#import "DCToolsViewController.h"
#import "GKGoodsDetailsGetTicketWebViewController.h"
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

#import "GFDetailShufflingHeadView.h" //头部轮播
#import "GFDetailGoodsReferralCell.h"  //商品标题价格介绍
#import "GFDetailShowTypeCell.h"      //种类
#import "DCShowTypeOneCell.h"
#import "DCShowTypeTwoCell.h"
#import "DCShowTypeThreeCell.h"
#import "DCShowTypeFourCell.h"
#import "DCDetailServicetCell.h"      //服务
#import "DCGoodsYouLikeCell.h"          //猜你喜欢
#import "GFDetailOverFooterView.h"    //尾部结束
#import "DCDetailPartCommentCell.h"   //部分评论
#import "GFDetailCustomHeadView.h"    //自定义头部
#import "GFCheckBabyDetailsCell.h"      //查看宝贝详情

#import "GFGoodDetailNewCell.h" //新方案的【商品详情】图片介绍页面
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

#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"

/*UIScrollViewDelegate*/
@interface GFGoodDetailNewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>



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

//图片数组
@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,assign)Boolean *setDetailsImageHidden;

/* 猜你喜欢 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem2 *> *youLikeItem2;
/*跳转的连接*/
@property(strong,nonatomic)NSString *couponurl;
@end

//header
static NSString *GFDetailShufflingHeadViewID = @"GFDetailShufflingHeadView";
static NSString *GFDetailCustomHeadViewID = @"GFDetailCustomHeadView";
//cell
static NSString *GFDetailGoodsReferralCellID = @"GFDetailGoodsReferralCell";

static NSString *DCShowTypeOneCellID = @"DCShowTypeOneCell";
static NSString *DCShowTypeTwoCellID = @"DCShowTypeTwoCell";
static NSString *DCShowTypeThreeCellID = @"DCShowTypeThreeCell";
static NSString *DCShowTypeFourCellID = @"DCShowTypeFourCell";
static NSString *GFCheckBabyDetailsCellID = @"GFCheckBabyDetailsCell";


static NSString *DCDetailServicetCellID = @"DCDetailServicetCell";
static NSString *DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *DCDetailPartCommentCellID = @"DCDetailPartCommentCell";
//footer
static NSString *GFDetailOverFooterViewID = @"GFDetailOverFooterView";


static NSString *lastNum_;
static NSArray *lastSeleArray_;


@implementation GFGoodDetailNewViewController

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
        [_collectionView registerClass:[GFDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailShufflingHeadViewID];
        [_collectionView registerClass:[GFDetailCustomHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailCustomHeadViewID];
        //注册Cell
        [_collectionView registerClass:[GFDetailGoodsReferralCell class] forCellWithReuseIdentifier:GFDetailGoodsReferralCellID];
        [_collectionView registerClass:[GFCheckBabyDetailsCell class] forCellWithReuseIdentifier:GFCheckBabyDetailsCellID];
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        [_collectionView registerClass:[DCDetailPartCommentCell class] forCellWithReuseIdentifier:DCDetailPartCommentCellID];
        [_collectionView registerClass:[DCDetailServicetCell class] forCellWithReuseIdentifier:DCDetailServicetCellID];
        //注册Footer
        [_collectionView registerClass:[GFDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFDetailOverFooterViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
        
    }
    return _collectionView;
}

#pragma mark - LifeCyle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.barTintColor = DCBGColor;
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setDetailsImageHidden = true;
    [self getData];
    [self setUpInit];
    [self setUpNav];
    [self setUpBottomButton];
    [self setUpSuspendView];
}

-(void)getData{
//    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image01" ofType:@"json"]];
//    NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    //    NSLog(@"json = %@",json);
//    _dataArray = json[@"data"];
    _dataArray  = @[];
    [self requestData];
}

- (void)requestData{
    //【商品详情页面数据】
    
    NSDictionary *dic = @{
                          @"itemid" : self.goodsDetailsItem.itemid
                          };
    [GCHttpDataTool getGoodsDetailWithDict:dic success:^(id responseObject) {
        NSDictionary *dict= responseObject[@"data"];
//        for (NSDictionary *dict in dataArray) {
//            [adBanerArr addObject:dict[@"adimg"]];
//            [imageJumpURLArray addObject:dict[@"jumpurl"]];
//            self.goodImageView = dict[@"itempic"];
//            self.shufflingArray
            self.shufflingArray = @[dict[@"itempic"]];
//        }
        //回到主线程更新UI -> 撤销遮罩
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
//    获取【商品详情】照片列表
    NSLog(@"获取【商品详情】照片列表 = %@",[NSString stringWithFormat:@"{\"id\":\"%@\"}",self.goodsDetailsItem.itemid]);
    NSDictionary *dict = @{
                           @"data" : [NSString stringWithFormat:@"{\"id\":\"%@\"}",self.goodsDetailsItem.itemid]
                           };
    [GCHttpDataTool getGoodsDetailPagePICWithDict:dict success:^(id responseObject) {
        NSArray *imageArray = [self getImageurlFromHtml:responseObject];
        //回到主线程更新UI -> 撤销遮罩
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataArray = [imageArray copy];
            [self.collectionView reloadData];
        });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
    
    
    NSMutableArray<DCRecommendItem2 *> *youLikeItem2 = [NSMutableArray array];
    /*猜你喜欢*/
    // 【请求三】猜你喜欢列表
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
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
    
    
    
    
}
//过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
       
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
//    MidStrTitle = html;
    return html;
}

- (NSArray *)getImageurlFromHtml:(NSString *)webString
{
    NSMutableArray * imageurlArray = @[].mutableCopy;
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [webString substringWithRange:range];
        NSError *error;
//        NSLog(@"subString = %@",subString);
        //从图片中的标签中提取ImageURL
//        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"img.alicdn.com/(.*?)\"" options:0 error:&error];
        
        NSInteger count = [subReg numberOfMatchesInString:subString options:NSMatchingReportCompletion range:NSMakeRange(0, subString.length)];
//        NSLog(@"count = %ld",(long)count);
        
//        //手机号简单匹配
//        NSString *searchText = @"15173265865/18551410506";
//        NSString *regexStr = @"1[358][0-9]{9}";
//        NSError *error;
//        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
//        if (error) return;
//        NSInteger count = [regular numberOfMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length)];
        
        if (!error&&count==1) {
            //        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"src=\"//(.*?)\"" options:0 error:NULL];
            NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
            NSTextCheckingResult * subRes = match[0];
            NSRange subRange = [subRes range];
            subRange.length = subRange.length -1;
            NSString * imagekUrl = [subString substringWithRange:subRange];
            
            //将提取出的图片URL添加到图片数组中
            imagekUrl = [NSString stringWithFormat:@"http://%@",imagekUrl];
            
            [imageurlArray addObject:imagekUrl];
            //        NSLog(@"👋👋👋👋👋👋imagekUrl = %@",imagekUrl);
        }
    }
    return imageurlArray;
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
#pragma mark - 开心分享 领券
- (void)setUpRightTwoButton
{
//    NSArray *titles = @[@"开心分享",@"领券¥50"];
    NSArray *titles = @[@"开心分享",[NSString stringWithFormat:@"领券¥%@",self.goodsDetailsItem.couponmoney]];
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
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击事件
- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
        [self setUpWithAddSuccess];
    }else if(button.tag == 1){
//        NSLog(@"购物车");
//        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2) {
//        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        });
        NSLog(@"开心分享");
    }else if(button.tag == 3){
//        [SVProgressHUD showInfoWithStatus:self.goodsDetailsItem.couponurl];
        NSLog(@"领券");
        //跳转进入【领券】页面
        GKGoodsDetailsGetTicketWebViewController *vc = [GKGoodsDetailsGetTicketWebViewController new];
        vc.title = @"领券";
        vc.webViewUrl = self.goodsDetailsItem.couponurl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma 退出界面
- (void)selfAlterViewback{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 消失
- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (section == 0 ) ? 2 : (section == 1) ? self.dataArray.count : _youLikeItem2.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //【商品详情】参数cell
            GFDetailGoodsReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFDetailGoodsReferralCellID forIndexPath:indexPath];
//            cell.goodsLabel.text = _goodTitle;
//            cell.priceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodPrice];
//            cell.goodSubtitleLabel.text = _goodSubtitle;
            cell.goodsDetailsItem = self.goodsDetailsItem;
            [DCSpeedy dc_setUpLabel:cell.goodsLabel Content:self.goodsDetailsItem.itemtitle IndentationFortheFirstLineWith:cell.priceLabel.font.pointSize * 1];
            cell.shareButtonClickBlock = ^{
//                [weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
            };
            gridcell = cell;
        }else if (indexPath.row == 1){
            //查看宝贝参数详情
            GFCheckBabyDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFCheckBabyDetailsCellID forIndexPath:indexPath];
            [cell setDetailsImageHidden:self.setDetailsImageHidden];
            gridcell = cell;
        }
    }else if (indexPath.section == 1){
#pragma mark -新方案设计修改处
//        if (indexPath.row == 0) {
//            //
//            GFCheckBabyDetailsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFCheckBabyDetailsCellID forIndexPath:indexPath];
//            gridcell = cell;
//        }else{
        
            static NSString *GFGoodDetailNewCellIdentifier = @"GFGoodDetailNewCellID";
            //在这里注册自定义的XIBcell 否则会提示找不到标示符指定的cell
            UINib *nib = [UINib nibWithNibName:@"GFGoodDetailNewCell" bundle: [NSBundle mainBundle]];
            [collectionView registerNib:nib forCellWithReuseIdentifier:GFGoodDetailNewCellIdentifier];
            GFGoodDetailNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GFGoodDetailNewCellIdentifier forIndexPath:indexPath];
            NSString *url = self.dataArray[indexPath.row];
            [cell.pciIamgeView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                /** 缓存image size */
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    if(result)  [collectionView  xh_reloadDataForURL:imageURL];
                }];
            }];
//        }
        
        gridcell = cell;
    }else if (indexPath.section == 2){
//        DCDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailLikeCellID forIndexPath:indexPath];
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
            GFDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailShufflingHeadViewID forIndexPath:indexPath];
            headerView.shufflingArray = _shufflingArray;
            reusableview = headerView;
        }else if (indexPath.section == 2){
            GFDetailCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GFDetailCustomHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 2) {
            GFDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:GFDetailOverFooterViewID forIndexPath:indexPath];
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
//        return (indexPath.row == 0) ? CGSizeMake(ScreenW, [DCSpeedy dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height + [DCSpeedy dc_calculateTextSizeWithText:_goodPrice WithTextFont:20 WithMaxW:ScreenW - DCMargin * 6].height + DCMargin * 2) : CGSizeMake(ScreenW, 35);
        
//        NSLog(@"%f",[DCSpeedy dc_calculateTextSizeWithText:_goodsDetailsItem.itemtitle WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height);
//        NSLog(@"%f",[DCSpeedy dc_calculateTextSizeWithText:[NSString stringWithFormat:@"%@",_goodsDetailsItem.itemendprice] WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height);
        
        return (indexPath.row == 0) ? CGSizeMake(ScreenW, [DCSpeedy dc_calculateTextSizeWithText:_goodsDetailsItem.itemtitle WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height + [DCSpeedy dc_calculateTextSizeWithText:[NSString stringWithFormat:@"%@",_goodsDetailsItem.itemendprice] WithTextFont:20 WithMaxW:ScreenW - DCMargin * 6].height + DCMargin * 2) : CGSizeMake(ScreenW, 35);
        
    }else if (indexPath.section == 1){//查看宝贝详情
//        return CGSizeMake(ScreenW, (ScreenH-50)/5*4+40);
//        return CGSizeMake(ScreenW, 0);
        NSString *url = self.dataArray[indexPath.row];
//        return  (indexPath.row == 0) ? CGSizeMake(ScreenW,35) : CGSizeMake(ScreenW,[XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:SCREEN_WIDTH-16 estimateHeight:200]);
        return self.setDetailsImageHidden ? CGSizeMake(ScreenW, 0) : CGSizeMake(ScreenW,[XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:SCREEN_WIDTH-16 estimateHeight:200]);
//    }else if (indexPath.section == 2){//商品猜你喜欢
//        return CGSizeMake(ScreenW, (ScreenW / 3 + 60) * 2 + 20);
    }else{
//        return CGSizeMake(ScreenW, (ScreenW / 3 + 60) * 2 + 20);
        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 80);
//        return CGSizeZero;
    }
}


#pragma mark - header宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(ScreenW, ScreenH * 0.55) : ( section == 2) ? CGSizeMake(ScreenW, 40) : CGSizeZero;
}

#pragma mark - footter宽高
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
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (!self.setDetailsImageHidden) {
            self.setDetailsImageHidden = true;
        }else{
            self.setDetailsImageHidden = false;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            //        [self.collectionView reloadSections:[NSIndexPath indexPathForRow:0 inSection:1]];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
        });
    }else{
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
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
//        [[NSNotificationCenter defaultCenter]postNotificationName:SCROLLTODETAILSPAGE object:nil];
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

#pragma mark - 加入【收藏】成功
- (void)setUpWithAddSuccess
{
    [SVProgressHUD showSuccessWithStatus:@"收藏成功~"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:1.0];
}
@end
