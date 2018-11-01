//
//  DCGoodsYouLikeCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#define cellWH ScreenW * 0.5 - 50

#import "DCGoodsYouLikeCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsYouLikeCell ()


@end

@implementation DCGoodsYouLikeCell

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
    //view中封装：图片、底部佣金条、佣金金额
    _view = [[UIView alloc]init];
    [self addSubview:_view];
    
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    //底部佣金条
    _bottomView= [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor orangeColor];
    [_bottomView setAlpha:0.7];
    [_goodsImageView addSubview:_bottomView];
    
    _commissionLabel = [[UILabel alloc]init];
    _commissionLabel.textColor = [UIColor whiteColor];
    _commissionLabel.font = PFR12Font;
    [_commissionLabel setText:@"预估佣金：￥7.86"];
    [_bottomView addSubview:_commissionLabel];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR12Font;
    _goodsLabel.textColor = [UIColor blackColor];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _downPriceLabel = [[UILabel alloc] init];
    _downPriceLabel.font = PFR8Font;
    _downPriceLabel.textColor = [UIColor grayColor];
    [_downPriceLabel setText:@"淘宝价：￥29.9"];
    _downPriceLabel.numberOfLines = 1;
    _downPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_downPriceLabel];
    
    _mothSalesVolume = [[UILabel alloc] init];
    _mothSalesVolume.font = PFR8Font;
    _mothSalesVolume.textColor = [UIColor grayColor];
    [_mothSalesVolume setText:@"月销：23860"];
    _mothSalesVolume.numberOfLines = 1;
    _mothSalesVolume.textAlignment = NSTextAlignmentRight;
    [self addSubview:_mothSalesVolume];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR12Font;
    [self addSubview:_priceLabel];
    
    _getTicketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _getTicketButton.titleLabel.font = PFR10Font;
//    [_getTicketButton setBackgroundColor:[UIColor orangeColor]];
    [_getTicketButton setBackgroundImage:[UIImage imageNamed:@"coupons_bg"] forState:UIControlStateNormal];
    [_getTicketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getTicketButton setTitle:@"代金券￥5元" forState:UIControlStateNormal];
    [_getTicketButton addTarget:self action:@selector(getTicketBlock) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_getTicketButton];
    
    [DCSpeedy dc_chageControlCircularWith:_sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    WEAKSELF
    [super layoutSubviews];
    
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH , cellWH));
        
    }];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(weakSelf.view);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.bottom.mas_equalTo(weakSelf.view)setOffset:0];
        make.size.mas_equalTo(CGSizeMake(cellWH , 20));
    }];
    
    [_commissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf.bottomView);
        make.size.mas_equalTo(CGSizeMake(cellWH , 20));
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        [make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom)setOffset:DCMargin];
        
    }];
    
    [_downPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(weakSelf.goodsLabel.mas_bottom);
    }];
    
    [_mothSalesVolume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(weakSelf.goodsLabel.mas_bottom);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(weakSelf.goodsLabel.mas_bottom).offset(10);
        
    }];
    
    [_getTicketButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        make.centerY.mas_equalTo(weakSelf.priceLabel);
        make.size.mas_equalTo(CGSizeMake(66, 18));
    }];
}


#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(DCRecommendItem *)youLikeItem
{
    if([[youLikeItem.image_url substringToIndex:4] isEqualToString:@"http"]){
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    }else{
        [_goodsImageView setImage:[UIImage imageNamed:youLikeItem.image_url]];
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youLikeItem.price floatValue]];
    _goodsLabel.text = youLikeItem.main_title;

    [_commissionLabel setText:@"预估佣金：￥7.86"];
    [_downPriceLabel setText:@"淘宝价：￥29.9"];
    [_mothSalesVolume setText:@"月销：23860"];
}

//#pragma mark - 点击事件
//- (void)lookSameGoods
//{
//    !_lookSameBlock ? : _lookSameBlock();
//}
#pragma mark - 点击事件
- (void)getTicketBlock
{
    !_getTicketBlock ? : _getTicketBlock();
    
    if (!_getTicketButton.selected) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"您已成功领取【商品：%@】的代金券",_goodsLabel.text]];
        _getTicketButton.selected = true;
        [_getTicketButton setBackgroundColor:[UIColor grayColor]];
        [_getTicketButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_getTicketButton setTitle:@"已领取！" forState:UIControlStateNormal];
    }else{
        [SVProgressHUD showInfoWithStatus:@"小主，您已经领取过该券啦！"];
    }
    
    
    
}
@end
