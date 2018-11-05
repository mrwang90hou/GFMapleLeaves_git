//
//  GFConditionFilterView.m
//  GFConditionFilterViewDemo
//
//  Created by MrYu on 16/9/21.
//  Copyright © 2016年 yu qingzhu. All rights reserved.
//

#import "GFConditionFilterView.h"
#import "GFFilterDataTableView.h"
#import "UIView+Extension.h"

@interface GFConditionFilterView()<GFFilterDataTableViewDelegate>
{
    // 第1组筛选 按钮
    UIButton *_dataSource1Btn;
    // 第2组筛选 按钮
    UIButton *_dataSource2Btn;
    // 第3组筛选 按钮
    UIButton *_dataSource3Btn;
    // 第4组切换 按钮
    UIButton *_turn4Btn;
    // 选中的按钮
    UIButton *_selectBtn;
    // 下拉黑色半透明背景
    UIView *_bgView;
    // 导航条背景禁止返回点击
    UIView *_topView;
    
    // 对应三个下拉框
    GFFilterDataTableView *_filterTableView1;
    GFFilterDataTableView *_filterTableView2;
    GFFilterDataTableView *_filterTableView3;
    
    // 存储 tableView didSelected数据 数据来源：FilterDataTableView
    NSArray *_dataSource1;
    NSArray *_dataSource2;
    NSArray *_dataSource3;
    
    BOOL _isShow;
}

@property (nonatomic,strong) FilterBlock filterBlock;

/** 记录上一次选中的Button底部View */
@property (nonatomic , strong)UIView *selectBottomRedView;

@property (nonatomic,strong) NSMutableArray *dataSourceArr;
@end


@implementation GFConditionFilterView

- (NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
        [_dataSourceArr addObject:_dataSource1];
        [_dataSourceArr addObject:_dataSource2];
        [_dataSourceArr addObject:_dataSource3];
    }
    return _dataSourceArr;
}
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
//        [self setUpUI];
    }
    return self;
}

+(instancetype)conditionFilterViewWithFilterBlock:(FilterBlock)filterBlock
{
    GFConditionFilterView *conditionFilter = [[GFConditionFilterView alloc] initWithFrame:CGRectMake(0, K_HEIGHT_NAVBAR, SCREEN_WIDTH, 40)];
//    GFConditionFilterView *conditionFilter = [[GFConditionFilterView alloc] init];
    [conditionFilter createSubView];
    conditionFilter.filterBlock=filterBlock;
    return conditionFilter;
}

- (void)createSubView
{
    self.backgroundColor=[UIColor whiteColor];
    _isShow = NO;
    
    // 不用设置默认显示数据，在外边设置 bindChoseArray重置就会刷新
    _dataSource1Btn = [self buttonWithLeftTitle:@"综合" titleColor:UIColorFromRGB(0x333333) Font:[UIFont systemFontOfSize:13] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(0, 0, (SCREEN_WIDTH-50)/3, 40)];
    [_dataSource1Btn setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_dataSource1Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource1Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    _dataSource1Btn.tag = 1;
    [self addSubview:_dataSource1Btn];
    
    UILabel *middleLine=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource1Btn.x+_dataSource1Btn.width, 8 , 0.5, 24)];
    middleLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:middleLine];
    
    _dataSource2Btn = [self buttonWithLeftTitle:@"券后价" titleColor:UIColorFromRGB(0x333333) Font:[UIFont systemFontOfSize:13] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_dataSource1Btn.x+_dataSource1Btn.width+0.5, 0, (SCREEN_WIDTH-50)/3, 40)];
    [_dataSource2Btn setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_dataSource2Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource2Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    _dataSource2Btn.tag = 2;
    [self addSubview:_dataSource2Btn];
    
    
    UILabel *middleLine2=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource2Btn.x+_dataSource2Btn.width, 8 , 0.5, 24)];
    middleLine2.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:middleLine2];
    
    _dataSource3Btn = [self buttonWithLeftTitle:@"销量" titleColor:UIColorFromRGB(0x333333) Font:[UIFont systemFontOfSize:13] backgroundColor:[UIColor whiteColor] RightImageName:@"PR_filter_choice" Frame:CGRectMake(_dataSource2Btn.x+_dataSource2Btn.width+0.5, 0, (SCREEN_WIDTH-50)/3, 40)];
    [_dataSource3Btn setTitleColor:UIColorFromRGB(0x00a0ff) forState:UIControlStateSelected];
    [_dataSource3Btn setImage:[UIImage imageNamed:@"PR_filter_choice_top"] forState:UIControlStateSelected];
    [_dataSource3Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    _dataSource3Btn.tag = 3;
    [self addSubview:_dataSource3Btn];
    
    _turn4Btn = [self buttonWithLeftTitle:@"" titleColor:UIColorFromRGB(0x333333) Font:[UIFont systemFontOfSize:13] backgroundColor:[UIColor whiteColor] RightImageName:@"flzq_nav_jiugongge" Frame:CGRectMake(_dataSource3Btn.x+_dataSource3Btn.width, 0, 40, 40)];
    [_turn4Btn setImage:[UIImage imageNamed:@"flzq_nav_jiugongge"] forState:UIControlStateNormal];
    _turn4Btn.tag = 4;
    [_turn4Btn addTarget:self action:@selector(filterChoseData:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_turn4Btn];
    
    UILabel *middleLine3=[[UILabel alloc] initWithFrame:CGRectMake(_dataSource3Btn.x+_dataSource3Btn.width, 8 , 0.5, 24)];
    middleLine3.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:middleLine3];
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    bottomLine.backgroundColor=UIColorFromRGB(0xe6e6e6);
    [self addSubview:bottomLine];
    
    // 加载数据  本地 or 外部传入
}


-(UIButton *)buttonWithLeftTitle:(NSString *)title titleColor:(UIColor *)titleColor Font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor RightImageName:(NSString *)imageName Frame:(CGRect)frame
{
    
    titleColor=titleColor?:[UIColor blackColor];
    font=font?:[UIFont systemFontOfSize:13.0];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.backgroundColor=backgroundColor;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))/2+titleSize.width+space;
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, -edgeSpace)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace =-image.size.width-space;
    if((int)SCREEN_HEIGHT%736 != 0)
    {
        titleSpace =-image.size.width-3*space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                             titleSpace,
                                             0.0,
                                             0.0)];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

- (void)filterChoseData:(UIButton *)btn
{
    if (btn.tag == 4) {
        [btn setImage:[UIImage imageNamed:@"flzq_nav_jiugongge"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"flzq_nav_list"] forState:UIControlStateSelected];
        btn.selected = !btn.selected;
        //切换视图浏览
        !_changeViewClickBlock ? : _changeViewClickBlock();
        return;
    }
    btn.selected=!btn.selected;
    if (btn.selected) {
        [self showTableView:btn];
        _selectBtn=btn;
//        _selectBottomRedView.hidden = YES;
//        UIView *bottomRedView = [[UIView alloc] init];
//        [self addSubview:bottomRedView];
//        bottomRedView.backgroundColor = [UIColor redColor];
//        //        bottomRedView.dc_width = button.dc_width;
//        //        bottomRedView.dc_height = 3;
//        //        bottomRedView.dc_y = button.dc_height - bottomRedView.dc_height;
//        //        bottomRedView.dc_x = button.dc_x;
//        bottomRedView.width = (SCREEN_WIDTH-50)/3;
//        bottomRedView.height = 3;
//        bottomRedView.y = btn.height - bottomRedView.height;
//        bottomRedView.x = btn.x;
//        bottomRedView.hidden = NO;
//        bottomRedView.tag = btn.tag;
//        _selectBottomRedView = bottomRedView;
        
//        if (btn.tag == 1&&_dataSource1.count==0) {
//            _selectBottomRedView.hidden = YES;
//        }else{
//            _selectBottomRedView.hidden = NO;
//        }
//        if (btn.tag == 2&&_dataSource2.count==0) {
//            _selectBottomRedView.hidden = YES;
//        }else{
//            _selectBottomRedView.hidden = NO;
//        }
//        if (btn.tag == 3&&_dataSource3.count==0) {
//            _selectBottomRedView.hidden = YES;
//        }else{
//            _selectBottomRedView.hidden = NO;
//        }
//        NSArray *arr = [self.dataSourceArr objectAtIndex:btn.tag-1];
//        if (arr.count == 0) {
//            _selectBottomRedView.hidden = YES;
//        }
        
    }else{
        [self dismiss];
//        if (_selectBtn.highlighted) {
//            _selectBtn.highlighted = true;
//        }
    }
}

#pragma mark - 显示下拉框
-(void)showTableView:(UIButton *)btn
{
    [self prepareUIWithBtn:btn];
    _isShow=YES;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (_selectBtn && _selectBtn != btn) {
        _selectBtn.selected=NO;
    }
}
- (void)prepareUIWithBtn:(UIButton *)btn
{
    [self prepareBgView];
    
    CGPoint point = [self.superview convertPoint:self.frame.origin toView:[UIApplication sharedApplication].windows.lastObject];
//    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"self.bootom = %f,self.y = %f,self.screenY = %f",point.y+40,self.y,self.frame.origin.y]];
    if (btn == _dataSource1Btn) {
//        _filterTableView1 = [[GFFilterDataTableView alloc] initWithFrame:CGRectMake(0, self.bottom, self.width, 0)];
        _filterTableView1 = [[GFFilterDataTableView alloc] initWithFrame:CGRectMake(0, point.y+40, self.width, 0)];
        _filterTableView1.sortDelegate = self;
        _filterTableView1.dateArray = self.dataAry1;
        _filterTableView1.selectedCell = [NSString stringWithFormat:@"%@",_dataSource1.firstObject];
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView1];
        [_filterTableView2 dismiss];
        [_filterTableView3 dismiss];
    }else if (btn == _dataSource2Btn){
        _filterTableView2 = [[GFFilterDataTableView alloc] initWithFrame:CGRectMake(0, point.y+40, self.width, 0)];
        _filterTableView2.sortDelegate = self;
        _filterTableView2.dateArray = self.dataAry2;
        _filterTableView2.selectedCell = [NSString stringWithFormat:@"%@",_dataSource2.firstObject];

        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView2];
        [_filterTableView1 dismiss];
        [_filterTableView3 dismiss];
        
    }else if (btn == _dataSource3Btn){
        _filterTableView3 = [[GFFilterDataTableView alloc] initWithFrame:CGRectMake(0, point.y+40, self.width, 0)];
        _filterTableView3.sortDelegate = self;
        _filterTableView3.dateArray = self.dataAry3;
        _filterTableView3.selectedCell = [NSString stringWithFormat:@"%@",_dataSource3.firstObject];
        [[UIApplication sharedApplication].keyWindow addSubview:_filterTableView3];
        [_filterTableView1 dismiss];
        [_filterTableView2 dismiss];
    }
}

#pragma mark - 准备灰色背景图
- (void)prepareBgView
{
    if (_bgView)  return;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+self.y+self.height, self.width, SCREEN_HEIGHT-(self.y+self.height))];
//    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, SCREEN_HEIGHT)];
    _bgView.backgroundColor = [UIColor colorWithDisplayP3Red:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    //顶部View
    
    CGPoint point = [self.superview convertPoint:self.frame.origin toView:[UIApplication sharedApplication].windows.lastObject];
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, point.y)];
    _topView.backgroundColor = [UIColor colorWithDisplayP3Red:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_topView addGestureRecognizer:tap2];
    [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    
}

#pragma mark - 从外部传入条件
-(void)choseSortFromOutsideWithFirstSort:(NSArray *)firstAry WithSecondSort:(NSArray *)secondAry WithThirdSort:(NSArray *)thirdAry
{
    if (firstAry != nil) {
        [self changeBtn:_dataSource1Btn Text:[NSString stringWithFormat:@"%@",firstAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        _dataSource1 = firstAry;
    }
    if (secondAry != nil) {
        [self changeBtn:_dataSource2Btn Text:[NSString stringWithFormat:@"%@",secondAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        _dataSource2 = secondAry;
    }
    
    if (thirdAry != nil) {
        [self changeBtn:_dataSource3Btn Text:[NSString stringWithFormat:@"%@",thirdAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        _dataSource3 = thirdAry;
    }
    [self dismiss];
//    BOOL isFilter = YES;
//    if (self.filterBlock) {
//        self.filterBlock(isFilter,_dataSource1,_dataSource2,_dataSource3);
//    }
    
}

#pragma mark - GFFilterDataTableViewDelegate 选择筛选项
-(void)choseSort:(NSArray *)sortAry
{
    if (_dataSource1Btn.selected) {
        // 改变btn显示的数据
        [self changeBtn:_dataSource1Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        // 存储显示的数据
        _dataSource1 = sortAry;
        _dataSource2 = @[];
        _dataSource3 = @[];
        [self setBottomRedView:_dataSource1Btn];
    }else if (_dataSource2Btn.selected){
        [self changeBtn:_dataSource2Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        _dataSource2 = sortAry;
        _dataSource1 = @[];
        _dataSource3 = @[];
        [self setBottomRedView:_dataSource2Btn];
    }else if (_dataSource3Btn.selected){
        [self changeBtn:_dataSource3Btn Text:[NSString stringWithFormat:@"%@",sortAry.firstObject] Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
        _dataSource3 = sortAry;
        _dataSource1 = @[];
        _dataSource2 = @[];
        [self setBottomRedView:_dataSource3Btn];
    }
    [self dismiss];
    // 选择筛选条件，直接开始网络请求
    BOOL isFilter = YES;
    if (self.filterBlock) {
        NSLog(@"choseSort!!!");
        self.filterBlock(isFilter,_dataSource1,_dataSource2,_dataSource3);
    }
}
//
-(void)setBottomRedView:(UIButton*)btn{
    _selectBottomRedView.hidden = YES;
    UIView *bottomRedView = [[UIView alloc] init];
    [self addSubview:bottomRedView];
    bottomRedView.backgroundColor = UIColorFromRGB(0x00a0ff);
    //        bottomRedView.dc_width = button.dc_width;
    //        bottomRedView.dc_height = 3;
    //        bottomRedView.dc_y = button.dc_height - bottomRedView.dc_height;
    //        bottomRedView.dc_x = button.dc_x;
    bottomRedView.width = (SCREEN_WIDTH-50)/3;
    bottomRedView.height = 1;
    bottomRedView.y = btn.height - bottomRedView.height;
    bottomRedView.x = btn.x;
    bottomRedView.hidden = NO;
    _selectBottomRedView = bottomRedView;
}



#pragma mark - 刷新标题布局 （相当于手动给值请求）
-(void)bindChoseArrayDataSource1:(NSArray *)dataSource1Ary DataSource2:(NSArray *)dataSource2Ary DataSource3:(NSArray *)dataSource3Ary
{
    
    BOOL isFilter = YES;
    
    // 第一次赋初值调用还没有进行过didSelect，所有都为空值,不是筛选
    if (_dataSource1.count==0 && _dataSource2.count ==0 && _dataSource3.count==0 ) {
        isFilter=NO;
        NSLog(@"iS Filter is NO");
    }
    [self setBottomRedView:_dataSource1Btn];
    _dataSource1 = [dataSource1Ary copy];
    _dataSource2 = [dataSource2Ary copy];
    _dataSource3 = [dataSource3Ary copy];
    
    // 取传过来的值，传过来什么请求就请求什么
    NSArray *tempDataSource1 = [NSArray arrayWithArray:dataSource1Ary];
    NSArray *tempDataSource2 = [NSArray arrayWithArray:dataSource2Ary];
    NSArray *tempDataSource3 = [NSArray arrayWithArray:dataSource3Ary];
    

    // 改变 按键 值
    [self changeTitleWithData1:tempDataSource1 Data2:tempDataSource2 Data3:tempDataSource3];
    
    [self dismiss];
    
    if(self.filterBlock)
    {
        NSLog(@"bindChoseArrayDataSource1!!!");
        self.filterBlock(isFilter,tempDataSource1,tempDataSource2,tempDataSource3);
    }
}
-(void)dismiss
{
    [_filterTableView1 dismiss];
    [_filterTableView2 dismiss];
    [_filterTableView3 dismiss];
    _dataSource1Btn.selected=NO;
    _dataSource2Btn.selected=NO;
    _dataSource3Btn.selected=NO;
    _selectBtn=nil;
    _isShow=NO;
    [_bgView removeFromSuperview];
    _bgView=nil;
    [_topView removeFromSuperview];
    _topView=nil;
    _filterTableView1.sortDelegate=nil;
    _filterTableView2.sortDelegate=nil;
    _filterTableView3.sortDelegate=nil;
    [_filterTableView1 removeFromSuperview];
    [_filterTableView2 removeFromSuperview];
    [_filterTableView3 removeFromSuperview];
    _filterTableView1=nil;
    _filterTableView2=nil;
    _filterTableView3=nil;
}

#pragma mark - 选择后重新显示筛选条件
-(void)changeTitleWithData1:(NSArray *)dataAry1 Data2:(NSArray *)dataAry2 Data3:(NSArray *)dataAry3
{
    NSString *data1Str = [dataAry1 firstObject];
    NSString *data2Str = [dataAry2 firstObject];
    NSString *data3Str = [dataAry3 firstObject];
    
    [self changeBtn:_dataSource1Btn Text:data1Str Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
    [self changeBtn:_dataSource2Btn Text:data2Str Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
    [self changeBtn:_dataSource3Btn Text:data3Str Font:[UIFont systemFontOfSize:13] ImageName:@"PR_filter_choice"];
    
}

#pragma mark - 改按钮文字重新排列
-(void)changeBtn:(UIButton *)btn Text:(NSString *)title Font:(UIFont *)font ImageName:(NSString *)imageName;
{
//    btn.width = btn.selected==true?(SCREEN_WIDTH-50)/3:(SCREEN_WIDTH-1)/3;
    btn.width = (SCREEN_WIDTH-50)/3;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat space = 5;
    
    CGFloat edgeSpace = (btn.width-(titleSize.width+image.size.width+space))+titleSize.width+space;
    
    // 90 - 60
    // 78 - 50
    CGFloat edge = -edgeSpace;
//    if (titleSize.width > 4*[UIFont convertFontSize:13.0]) {
//        edge = -edgeSpace-titleSize.width/1.5;
//    }
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0, 0.0, edge)];
    [btn setImage:image forState:UIControlStateNormal];
    
    CGFloat titleSpace =-image.size.width-space;
    if((int)SCREEN_HEIGHT%736 != 0)
    {
        titleSpace =-image.size.width-4*space;
    }
    
    [btn.titleLabel setContentMode:UIViewContentModeCenter];
    [btn.titleLabel setFont:font];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                             titleSpace,
                                             0.0,
                                             0.0)];
    if ([title isEqualToString:@"综合排序"]) {
        [btn setTitle:@"综合" forState:UIControlStateNormal];
    }else if ([title containsString:@"优惠券"]){
        [btn setTitle:@"优惠券" forState:UIControlStateNormal];
    }
    
}

- (NSDictionary*)keyValueDic
{
    if (!_keyValueDic) {
        NSDictionary *keyValueDic=[[NSDictionary alloc] init];
        keyValueDic = @{
                        @"key1":@"value1",
                        @"key2":@"value2",
                        @"key3":@"value3",
                        @"key4":@"value4",
                        @"key5":@"value5",
                        };
        _keyValueDic = keyValueDic;
    }
    return _keyValueDic;
}

@end
