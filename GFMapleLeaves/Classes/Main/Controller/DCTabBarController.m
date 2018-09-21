//
//  DCTabBarController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/11.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCTabBarController.h"

// Controllers
#import "DCNavigationController.h"
#import "DCLoginViewController.h"
#import "GKLoginController.h"
#import "DCBeautyMessageViewController.h"
// Models

// Views
#import "DCTabBadgeView.h"
// Vendors

// Categories

// Others

@interface DCTabBarController ()<UITabBarControllerDelegate>

//美信
@property (nonatomic, weak) DCBeautyMessageViewController *beautyMsgVc;

@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property (nonatomic, weak) UITabBarItem *item;

@end

@implementation DCTabBarController

#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

#pragma mark - LifeCyle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeValue) name:DCMESSAGECOUNTCHANGE object:nil];
    
    // 添加badgeView
    [self addBadgeViewOnTabBarButtons];
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:LOGINOFFSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        weakSelf.selectedViewController = [weakSelf.viewControllers objectAtIndex:DCTabBarControllerHome]; //默认选择商城index为1
    }];

}


#pragma mark - initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self addDcChildViewContorller];
    
    self.selectedViewController = [self.viewControllers objectAtIndex:DCTabBarControllerHome]; //默认选择商城index为1
}


#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"DCHandPickViewController",
                              MallTitleKey  : @"首页",
//                              MallImgKey    : @"tabr_01_up",
//                              MallSelImgKey : @"tabr_01_down"},
                              MallImgKey    : @"tab_icon_home_normal",
                              MallSelImgKey : @"tab_icon_home_selected"},
                            
//                            @{MallClassKey  : @"DCBeautyShopViewController",
//                              MallTitleKey  : @"美店",
//                              MallImgKey    : @"tabr_02_up",
//                              MallSelImgKey : @"tabr_02_down"},
//                            DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
//                            shopCarVc.isTabBar = YES;
                            @{MallClassKey  : @"DCCommodityViewController",
                              MallTitleKey  : @"分类",
//                              MallImgKey    : @"tabr_02_up",
//                              MallSelImgKey : @"tabr_02_down"},
                                MallImgKey    : @"tab_icon_classify_normal",
                                MallSelImgKey : @"tab_icon_classify_selected"},
                            
                            @{MallClassKey  : @"GFSuperMemberViewController",
                              MallTitleKey  : @"超级会员",
//                              MallImgKey    : @"tabr_03_up",
//                              MallSelImgKey : @"tabr_03_down"},
                              MallImgKey    : @"tab_icon_logo",
                              MallSelImgKey : @"tab_icon_logo"},
                            
                            @{MallClassKey  : @"GFSuperMemberViewController",
                              MallTitleKey  : @"动态",
//                              MallImgKey    : @"tabr_04_up",
//                              MallSelImgKey : @"tabr_04_down"},
                              MallImgKey    : @"tab_icon_message_normal",
                              MallSelImgKey : @"tab_icon_message_selected"},
                            
                            @{MallClassKey  : @"DCMyCenterViewController",
//                          @{MallClassKey  : @"GKMeViewController",
                             MallTitleKey  : @"我的",
//                              MallImgKey    : @"tabr_05_up",
//                              MallSelImgKey : @"tabr_05_down"},
                              MallImgKey    : @"tab_icon_my_normal",
                              MallSelImgKey : @"tab_icon_my_selected"},
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        DCNavigationController *nav = [[DCNavigationController alloc] initWithRootViewController:vc];
        //【新方案】
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:dict[MallTitleKey] image:[UIImage imageNamed:dict[MallImgKey]] selectedImage:[UIImage imageNamed:dict[MallSelImgKey]]];
//        item = nav.tabBarItem;
        nav.tabBarItem = item;
        //原始方案1
//        UITabBarItem *item = nav.tabBarItem;
//        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
////        item.title = [dict[MallImgKey] stringValue];
//        item.
        //默认的：灰色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
//
//        [item setTitlePositionAdjustment:<#(UIOffset)#>]
        //青绿色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:59.0/255.0 green:207.0/255.0 blue:202.0/255.0 alpha:1],UITextAttributeTextColor, nil]forState:UIControlStateSelected];
        //与selected图片颜色一致
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:247.0/255.0 green:0.0/255.0 blue:130.0/255.0 alpha:1],UITextAttributeTextColor, nil]forState:UIControlStateSelected];
//        item. = [NSString dict[MallSelImgKey]]
        [self addChildViewController:nav];
        WEAKSELF
        if ([dict[MallTitleKey] isEqualToString:@"动态"]) {
            weakSelf.beautyMsgVc = (DCBeautyMessageViewController *)vc; //给美信赋值
        }
        
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
}

#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerPerson]){

        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//            DCLoginViewController *dcLoginVc = [DCLoginViewController new];
//            [self presentViewController:dcLoginVc animated:YES completion:nil];
            UINavigationController *uiNavC = [[UINavigationController alloc] initWithRootViewController:[[GKLoginController alloc]init]];
//            uiNavC.edgesForExtendedLayout = UIRectEdgeNone;
            
            
            // 设置导航栏标题颜色，字体大小，背景不透明，背景颜色
            NSMutableDictionary *titleParams = [[NSMutableDictionary alloc] init];
            [titleParams setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
            [titleParams setObject:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
            [uiNavC.navigationBar setTitleTextAttributes:titleParams];//设置标题属性
            [uiNavC.navigationBar setTranslucent:NO];//设置为半透明状态
            [uiNavC.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:134/255.0 blue:227/255.0 alpha:1]];
//
//
////            UINavigationBar *bar = [UINavigationBar appearance];
//            uiNavC.navigationBar.barTintColor = DCBGColor;
//            [uiNavC.navigationBar setTintColor:[UIColor darkGrayColor]];
//            uiNavC.navigationBar.translucent = YES;
//            [uiNavC.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//            // 设置导航栏字体颜色
//            UIColor * naiColor = [UIColor blackColor];
//            attributes[NSForegroundColorAttributeName] = naiColor;
//            attributes[NSFontAttributeName] = PFR18Font;
//            uiNavC.navigationBar.titleTextAttributes = attributes;
//            uiNavC.navigationBar.backgroundColor = DCBGColor;
//            //self.navigationController?.navigationBar.translucent = false//方法2
//            //            GKLoginController *gfLoginVc = [GKLoginController new];
            [self presentViewController:uiNavC animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if ([self.childViewControllers.firstObject isEqual:viewController]) { //根据tabBar的内存地址找到美信发通知jump
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
    }

}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];

    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}


#pragma mark - 更新badgeView
- (void)updateBadgeValue
{
    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
}


#pragma mark - 添加所有badgeView
- (void)addBadgeViewOnTabBarButtons {
    
    // 设置初始的badegValue
    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
    
    int i = 0;
    for (UITabBarItem *item in self.tabBarItems) {
        
        if (i == 0) {  // 只在美信上添加
            [self addBadgeViewWithBadgeValue:item.badgeValue atIndex:i];
            // 监听item的变化情况
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
            _item = item;
        }
        i++;
    }
}

- (void)addBadgeViewWithBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    
    DCTabBadgeView *badgeView = [DCTabBadgeView buttonWithType:UIButtonTypeCustom];
    
    CGFloat tabBarButtonWidth = self.tabBar.dc_width / self.tabBarItems.count;
    
    badgeView.dc_centerX = index * tabBarButtonWidth + 40;
    
    badgeView.tag = index + 1;
    
    badgeView.badgeValue = badgeValue;
    
    [self.tabBar addSubview:badgeView];
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[DCTabBadgeView class]]) {
            if (subView.tag == 1) {
                DCTabBadgeView *badgeView = (DCTabBadgeView *)subView;
                badgeView.badgeValue = _beautyMsgVc.tabBarItem.badgeValue;
            }
        }
    }
    
}


#pragma mark - 移除通知
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
