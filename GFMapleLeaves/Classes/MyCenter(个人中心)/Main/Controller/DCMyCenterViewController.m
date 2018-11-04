
//
//  DCMyCenterViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/10.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCMyCenterViewController.h"

// Controllers
#import "DCManagementViewController.h" //账户管理
#import "DCGMScanViewController.h"  //扫一扫
#import "DCSettingViewController.h" //设置

#import "GFAboutUsViewController.h"
#import "GFFeedBackViewController.h"
#import "GFCustomerServiceCenterViewController.h"
#import "GFPlatformRulesViewController.h"


// Models
#import "DCGridItem.h"
// Views
                               //顶部和头部View
#import "DCCenterTopToolView.h"
#import "DCMyCenterHeaderView.h"
#import "GKMeDetailController.h"

//新增两组 cell
#import "GFEarningsItemCell.h"
#import "GFInfoItemCell.h"
//四组Cell
#import "DCCenterItemCell.h"
#import "DCCenterServiceCell.h"
#import "DCCenterBeaShopCell.h"
#import "DCCenterBackCell.h"
//新增四个 tabviewCell
#import "GKDetailCell.h"
#import "GKCheckOldPhoneController.h"
#import "GKChangeNameController.h"
#import "GKChangePassWordController.h"
#import "GFListItemsCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCMyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

/* headView */
@property (strong , nonatomic)DCMyCenterHeaderView *headView;
/* 头部背景图片 */
@property (nonatomic, strong) UIImageView *headerBgImageView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 顶部Nva */
@property (strong , nonatomic)DCCenterTopToolView *topToolView;

/* 服务数据 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *infoItem;
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *serviceItem;
@end

static NSString *const GFEarningsCellID = @"GFEarningsItemCell";
static NSString *const GFInfoItemCellID = @"GFInfoItemCell";

static NSString *const GKDetailCellID = @"GKDetailCell";


static NSString *const DCCenterItemCellID = @"DCCenterItemCell";
static NSString *const DCCenterServiceCellID = @"DCCenterServiceCell";
static NSString *const DCCenterBeaShopCellID = @"DCCenterBeaShopCell";
static NSString *const DCCenterBackCellID = @"DCCenterBackCell";
static NSString *const GFListItemsCellID = @"GFListItemsCell";


@implementation DCMyCenterViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewStyleGrouped;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFEarningsItemCell class]) bundle:nil] forCellReuseIdentifier:GFEarningsCellID];
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFInfoItemCell class]) bundle:nil] forCellReuseIdentifier:GFInfoItemCellID];
        [_tableView registerClass:[GFInfoItemCell class] forCellReuseIdentifier:GFInfoItemCellID];
        [_tableView registerClass:[DCCenterItemCell class] forCellReuseIdentifier:DCCenterItemCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterServiceCell class]) bundle:nil] forCellReuseIdentifier:DCCenterServiceCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterBeaShopCell class]) bundle:nil] forCellReuseIdentifier:DCCenterBeaShopCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCenterBackCell class]) bundle:nil] forCellReuseIdentifier:DCCenterBackCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GFListItemsCell class]) bundle:nil] forCellReuseIdentifier:GFListItemsCellID];
        
        [_tableView registerClass:[GKDetailCell class] forCellReuseIdentifier:GKDetailCellID];
    }
    return _tableView;
}

- (UIImageView *)headerBgImageView{
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
//        NSInteger armNum = [DCSpeedy dc_GetRandomNumber:1 to:9];
//        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"my_Income_banner_Background"]]];
        [_headerBgImageView setBackgroundColor:[UIColor greenColor]];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

- (DCMyCenterHeaderView *)headView
{
    if (!_headView) {
        _headView = [DCMyCenterHeaderView dc_viewFromXib];
        _headView.frame =  CGRectMake(0, 0, ScreenW, 170);
    }
    return _headView;
}


- (NSMutableArray<DCGridItem *> *)serviceItem
{
    if (!_serviceItem) {
        _serviceItem = [NSMutableArray array];
    }
    return _serviceItem;
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:false];
    [self.navigationController.navigationBar setTranslucent:NO];//设置为半透明状态
    [self.navigationController.navigationBar setBarTintColor:GFOrgangeCokor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //都是针对tableView来看
    //1 去除掉自动布局添加的边距
    self.tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    //2 去掉iOS7的separatorInset边距
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self setUpBase];
    
    [self setUpData];

    [self setUpNavTopView];
    
    [self setUpHeaderCenterView];
}

#pragma mark - 获取数据
- (void)setUpData
{
//    _infoItem = [DCGridItem mj_objectArrayWithFilename:@"GFInfoItemCell.plist"];
    _serviceItem = [DCGridItem mj_objectArrayWithFilename:@"MyServiceFlow.plist"];
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[DCCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{ //点击了扫描
        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{ //点击设置
        
//        DCSettingViewController *dcSetVc = [DCSettingViewController new];
//        [weakSelf.navigationController pushViewController:dcSetVc animated:YES];
//        GKMeDetailController *vc = [[GKMeDetailController alloc]init];
//        UINavigationController *uiNavC = [[UINavigationController alloc] initWithRootViewController:[[GKMeDetailController alloc]init]];
        //            uiNavC.edgesForExtendedLayout = UIRectEdgeNone;
        // 设置导航栏标题颜色，字体大小，背景不透明，背景颜色
        NSMutableDictionary *titleParams = [[NSMutableDictionary alloc] init];
        [titleParams setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [titleParams setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
//        [uiNavC.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
//        [uiNavC.navigationBar setTranslucent:NO];//设置为半透明状态
//        [uiNavC.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
        [weakSelf.navigationController.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
        [weakSelf.navigationController.navigationBar setTranslucent:NO];//设置为半透明状态
//        [weakSelf.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
        [weakSelf.navigationController.navigationBar setBarTintColor:GFOrgangeCokor];
        [weakSelf.navigationController pushViewController:[GKMeDetailController new] animated:YES];
        
    };
    
    [self.view addSubview:_topToolView];
    
}


#pragma mark - initialize
- (void)setUpBase {
    
    self.view.backgroundColor = DCBGColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tabBarItem.title = @"我的账户";
//    self.title = @"我的账户";
    
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new]; //去除多余分割线
}

#pragma mark - 初始化头部
- (void)setUpHeaderCenterView{
    
    self.tableView.tableHeaderView = self.headView;
    self.headerBgImageView.frame = self.headView.bounds;
    [self.headView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层
    
    WEAKSELF
    self.headView.headClickBlock = ^{
//        DCManagementViewController *dcMaVc = [DCManagementViewController new];
//        [weakSelf.navigationController pushViewController:dcMaVc animated:YES];
        NSMutableDictionary *titleParams = [[NSMutableDictionary alloc] init];
        [titleParams setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [titleParams setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
        //        [uiNavC.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
        //        [uiNavC.navigationBar setTranslucent:NO];//设置为半透明状态
        //        [uiNavC.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
        [weakSelf.navigationController.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
        [weakSelf.navigationController.navigationBar setTranslucent:NO];//设置为半透明状态
        //        [weakSelf.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
        [weakSelf.navigationController.navigationBar setBarTintColor:GFOrgangeCokor];
        [weakSelf.navigationController pushViewController:[GKMeDetailController new] animated:YES];
    };
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != 3) {
        return 1;
    }else{
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cusCell = [UITableViewCell new];
    if (indexPath.section == 0) {
        GFEarningsItemCell *cell = [tableView dequeueReusableCellWithIdentifier:GFEarningsCellID forIndexPath:indexPath];
        cusCell = cell;
    }else if(indexPath.section == 1){
        GFInfoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:GFInfoItemCellID forIndexPath:indexPath];
        cusCell = cell;
    }else if (indexPath.section == 2) {
        DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
        cusCell = cell;
    }else if(indexPath.section == 3){
//        GFListItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:GFListItemsCellID forIndexPath:indexPath];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSArray *imageViewArr=[[NSArray alloc] initWithObjects:@"my_icon_Customer_service_center",@"my_icon_Rules",@"my_icon_feedback",@"my_icon_about_me",nil];
        NSArray *nameLabelArr=[[NSArray alloc] initWithObjects:@"客服中心",@"平台规则",@"意见反馈",@"关于小枫叶",nil];
        [cell.imageView setImage:[UIImage imageNamed:[imageViewArr objectAtIndex:indexPath.row]]];
        [cell.textLabel setText:[nameLabelArr objectAtIndex:indexPath.row]];
        [cell.textLabel setFont:GKFontAndFontName(@"Regular",12)];
        [cell.textLabel setTextColor:[UIColor lightGrayColor]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //去掉cell的自动布局添加的边距
//        cell.layoutMargins = UIEdgeInsetsMake(1, 0, 1, 0);
        cusCell = cell;
    }
    /*弃用
    
    else if(indexPath.section == 3){
//        DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
//        cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
//        cusCell = cell;
    }else if (indexPath.section == 4){
//        DCCenterBeaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBeaShopCellID forIndexPath:indexPath];
//        cusCell = cell;
    }else if (indexPath.section == 5){
//        DCCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBackCellID forIndexPath:indexPath];
//        cusCell = cell;
    }else if(indexPath.section == 6){
//        GKDetailCell *cell = [[GKDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKDetailCell"];
////        GKDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:GKDetailCellID forIndexPath:indexPath];
//        if (indexPath.row == 0) {
//            cell.firstLabel.text = @"用户昵称";
//            cell.desLabel.text = @"小枫叶🍁";
//        }else if(indexPath.row == 1){
//            cell.firstLabel.text = @"手机号码";
//            cell.desLabel.text = @"18577986175";
//        }else if(indexPath.row == 2){
//            cell.firstLabel.text = @"修改密码";
//            cell.desLabel.text = @"";
//        }
//        cell.firstLabel.text = @"用户昵称";
//        cell.desLabel.text = @"小枫叶🍁";
//        static NSString *ID = @"wine";
//        //    GKTFCell
//        // 1.先去缓存池中查找可循环利用的cell
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        // 2.如果缓存池中没有可循环利用的cell
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
//        // 3.设置数据
//            cell.textLabel.text = [NSString stringWithFormat:@"%zd行的数据", indexPath.row];
//        cell.textLabel.text = @"充电的时候出现了故障~";
//        [cell.textLabel setFont:GKFontAndFontName(@"Regular",14)];
////        UITableViewCell *cell = [[UITableViewCell alloc]init];
//        cell.detailTextLabel.text = @"2018/08/23 10:32:00";
//        [cell.detailTextLabel setTextColor:GFPink2Cokor];
//        [cell.detailTextLabel setFont:GKFont(12)];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
        
        GFListItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:GFListItemsCellID forIndexPath:indexPath];
//        cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
        cusCell = cell;
    }
//   switch ((int)indexPath.section) {
//        case 0:
//
//            break;
//        case 1:
//
//            break;
//        case 2:
//            DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
//            cusCell = cell;
//            break;
//        case 3:
//            DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
//            cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
//            break;
//        case 4:
//            DCCenterBeaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBeaShopCellID forIndexPath:indexPath];
//            cusCell = cell;
//            break;
//        case 5:
//            DCCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBackCellID forIndexPath:indexPath];
//            cusCell = cell;
//            break;
//
//        default:
//            break;
//    }
     */
    
    return cusCell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GFBaseSetViewController *vc = [GFBaseSetViewController new];
    
    
    
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                vc = [GFCustomerServiceCenterViewController new];
                break;
            case 1:
                vc = [GFPlatformRulesViewController new];
                break;
            case 2:
                vc = [GFFeedBackViewController new];
                break;
            case 3:
                vc = [GFAboutUsViewController new];
                break;
            default:
                break;
        }
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //        return 300;
        return 41;
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2) {
//        return 300;
        return 180;
    }else if (indexPath.section == 3){
//        return 215;
        return 44;
    }else{
        return 0;
    }
//    else if (indexPath.section == 4){
////        return 280;
//        return 0;
//    }else if (indexPath.section == 5){
//        //        return 200;
//        return 0;
//    }else if (indexPath.section == 6){
//        //        return 200;
//        return 20;
//    }
//    return 0;
    
}

#pragma mark 返回每一组的header标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////    ZFSettingGroup *group = _allGroups[section];
////    return group.header;
//}
//
//#pragma mark 返回每一组的footer标题
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
////    ZFSettingGroup *group = _allGroups[section];
////    return group.footer;
//}

#pragma mark 索引路径的行高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 1) {
//        return 10;
//    }else{
        return 1;
//    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0|| section == 1) {
//        return 10;
//    }else{
//        return 0.1;
//    }
//}





#pragma mark - 滚动tableview 完毕之后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;
    
    _topToolView.backgroundColor = (scrollView.contentOffset.y > 640) ? GFOrgangeCokor : [UIColor clearColor];
    
    //图片高度
    CGFloat imageHeight = self.headView.dc_height;
    //图片宽度
    CGFloat imageWidth = ScreenW;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headerBgImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}



@end
