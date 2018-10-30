//
//  GFDetailGoodsReferralCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/10/31.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "GFDetailGoodsReferralCell.h"

// Controllers

// Models

// Views
#import "DCUpDownButton.h"
// Vendors

// Categories

// Others

@interface GFDetailGoodsReferralCell ()

/* 分享按钮 */
@property (strong , nonatomic)DCUpDownButton *shareButton;

/* 冒号 */
@property (strong , nonatomic)UIButton *colonButton;
@end

@implementation GFDetailGoodsReferralCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    //淘宝logo
    _tbLogoImageView = [[UIImageView alloc] init];
    [self addSubview:_tbLogoImageView];
    _tbLogoImageView.image = [UIImage imageNamed:@"taobao_icon"];
    //商品名称
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR16Font;
    _gridLabel.numberOfLines = 0;
//    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];
    
    //好评率
    _goodsRateRLabel = [[UILabel alloc] init];
    _goodsRateRLabel.font = PFR11Font;
    _goodsRateRLabel.text = @"好评99.8%";
    _goodsRateRLabel.textColor = TEXTGRAYCOLOR;
    _goodsRateRLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_goodsRateRLabel];
    //价格
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR16Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    //满减
    _downPriceBtn = [[UIButton alloc] init];
    [_downPriceBtn setBackgroundImage:SETIMAGE(@"down_price_btn_bg") forState:UIControlStateNormal];
    [_downPriceBtn setTitle:@"满两套减50" forState:UIControlStateNormal];
    [_downPriceBtn setTitleColor:RGBall(255) forState:UIControlStateNormal];
    _downPriceBtn.titleLabel.font = PFR11Font;
    [_downPriceBtn setUserInteractionEnabled:NO];
    [self addSubview:_downPriceBtn];
    //天猫价
    _tCatPriceLabel = [[UILabel alloc] init];
    _tCatPriceLabel.font = PFR12Font;
    _tCatPriceLabel.text = @"天猫价：168";
    _tCatPriceLabel.textColor = TEXTGRAYCOLOR;
    [self addSubview:_tCatPriceLabel];
    //月销量
    _mothSalesVolumeLabel = [[UILabel alloc] init];
    _mothSalesVolumeLabel.font = PFR12Font;
    _mothSalesVolumeLabel.text = @"月销450";
    _mothSalesVolumeLabel.textColor = TEXTGRAYCOLOR;
    [self addSubview:_mothSalesVolumeLabel];
    //优惠券
    _ticketBtn = [[UIButton alloc] init];
    [_ticketBtn setBackgroundImage:SETIMAGE(@"my_collection_coupons_icon") forState:UIControlStateNormal];
    [_ticketBtn setTitle:@"券￥50" forState:UIControlStateNormal];
    [_ticketBtn setTitleColor:RGBall(255) forState:UIControlStateNormal];
    _ticketBtn.titleLabel.font = PFR12Font;
    [_ticketBtn setUserInteractionEnabled:NO];
    [self addSubview:_ticketBtn];
    
    
    _colonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_colonButton setImage:[UIImage imageNamed:@"icon_shenglue"] forState:UIControlStateNormal];
    [_colonButton addTarget:self action:@selector(colonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_colonButton];
    _colonButton.hidden = true;
    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
    
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_tbLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self.tbLogoImageView)setOffset:-3];
//        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];

    [_goodsRateRLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-DCMargin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 18));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tbLogoImageView);
        [make.top.mas_equalTo(self.gridLabel.mas_bottom)setOffset:DCMargin];
    }];

    [_downPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(DCMargin);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [_tCatPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.downPriceBtn.mas_right).offset(DCMargin*2);
        make.centerY.equalTo(self.priceLabel);
    }];

    [_mothSalesVolumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tCatPriceLabel.mas_right).offset(DCMargin);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];

    [_ticketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-4);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];

    [_colonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.size.mas_offset(CGSizeMake(22, 15));
    }];
    
    //竖直线条
//    [DCSpeedy dc_setUpLongLineWith:_gridLabel WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15] WithHightRatio:0.6];
    
}


#pragma mark - 分享按钮点击
- (void)shareButtonClick
{
    !_shareButtonClickBlock ? : _shareButtonClickBlock();
}

#pragma mark - Setter Getter Methods


@end
