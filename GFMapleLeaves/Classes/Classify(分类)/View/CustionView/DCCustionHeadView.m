//
//  DCCustionHeadView.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#define AuxiliaryNum 100

#import "DCCustionHeadView.h"

// Controllers

// Models

// Views
#import "DCCustionButton.h"
// Vendors

// Categories

// Others

@interface DCCustionHeadView ()

/** 记录上一次选中的Button */
@property (nonatomic , weak) DCCustionButton *selectBtn;
/** 记录上一次选中的Button底部View */
@property (nonatomic , strong)UIView *selectBottomRedView;

@end

@implementation DCCustionHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
//    NSArray *titles = @[@"推荐",@"价格",@"销量",@"筛选"];
    NSArray *titles = @[@"综合",@"券后价",@"销量",@""];
//    NSArray *noImage = @[@"icon_Arrow2",@"icon_Arrowup",@"icon_Arrowup",@"icon_shaixuan"];
    NSArray *noImage = @[@"icon_Arrow2",@"icon_Arrowup",@"icon_Arrowup",@"flzq_nav_jiugongge"];
    
    CGFloat btnW = self.dc_width / titles.count;
    CGFloat btnH = self.dc_height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i++) {
        DCCustionButton *button = [DCCustionButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:noImage[i]] forState:UIControlStateNormal];
        button.tag = i + AuxiliaryNum;
        CGFloat btnX = i * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button]; //默认选择第一个
        }
    }
    //
    
    
    
    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

#pragma mark - 按钮点击
- (void)buttonClick:(DCCustionButton *)button
{
    if (button.tag == 3 + AuxiliaryNum) {
        //筛选
//        !_filtrateClickBlock ? : _filtrateClickBlock();
        
        
        [button setImage:[UIImage imageNamed:@"flzq_nav_jiugongge"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"flzq_nav_list"] forState:UIControlStateSelected];
        button.selected = !button.selected;
        //切换视图浏览
        !_changeViewClickBlock ? : _changeViewClickBlock();
        
        
    }else{
        _selectBottomRedView.hidden = YES;
        [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        UIView *bottomRedView = [[UIView alloc] init];
        [self addSubview:bottomRedView];
        bottomRedView.backgroundColor = [UIColor redColor];
        bottomRedView.dc_width = button.dc_width;
        bottomRedView.dc_height = 3;
        bottomRedView.dc_y = button.dc_height - bottomRedView.dc_height;
        bottomRedView.dc_x = button.dc_x;
        bottomRedView.hidden = NO;
        
        _selectBtn = button;
        _selectBottomRedView = bottomRedView;
    }
}


#pragma mark - Setter Getter Methods

@end
