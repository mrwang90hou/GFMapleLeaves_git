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
    _goodsTitleImage = [[UIImageView alloc] init];
    [self addSubview:_goodsTitleImage];
//    _goodsTitleImage.image = [UIImage imageNamed:@"taobao_icon"];
    //商品名称
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR16Font;
    _goodsLabel.numberOfLines = 0;
//    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
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
    _beforeDownPriceLabel = [[UILabel alloc] init];
    _beforeDownPriceLabel.font = PFR12Font;
//    _beforeDownPriceLabel.text = @"天猫价：168";
    _beforeDownPriceLabel.textColor = TEXTGRAYCOLOR;
    [self addSubview:_beforeDownPriceLabel];
    //月销量
    _mothSalesVolume = [[UILabel alloc] init];
    _mothSalesVolume.font = PFR12Font;
//    _mothSalesVolume.text = @"月销450";
    _mothSalesVolume.textColor = TEXTGRAYCOLOR;
    [self addSubview:_mothSalesVolume];
    //优惠券
    _getTicketButton = [[UIButton alloc] init];
    [_getTicketButton setBackgroundImage:SETIMAGE(@"my_collection_coupons_icon") forState:UIControlStateNormal];
//    [_getTicketButton setTitle:@"券￥50" forState:UIControlStateNormal];
    [_getTicketButton setTitleColor:RGBall(255) forState:UIControlStateNormal];
    _getTicketButton.titleLabel.font = PFR12Font;
    [_getTicketButton setUserInteractionEnabled:NO];
    [self addSubview:_getTicketButton];
    
    
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
    
    [_goodsTitleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self.goodsTitleImage)setOffset:-3];
//        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];

    [_goodsRateRLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-DCMargin);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 18));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsTitleImage);
        [make.top.mas_equalTo(self.goodsLabel.mas_bottom)setOffset:DCMargin];
    }];

    [_downPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(DCMargin);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [_beforeDownPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.downPriceBtn.mas_right).offset(DCMargin*2);
        make.centerY.equalTo(self.priceLabel);
    }];

    [_mothSalesVolume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.beforeDownPriceLabel.mas_right).offset(DCMargin);
        make.centerY.equalTo(self.beforeDownPriceLabel);
    }];

    [_getTicketButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsRateRLabel);
        make.centerY.equalTo(self.beforeDownPriceLabel);
    }];

    [_colonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.size.mas_offset(CGSizeMake(22, 15));
    }];
    
    //竖直线条
//    [DCSpeedy dc_setUpLongLineWith:_goodsLabel WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15] WithHightRatio:0.6];
}

#pragma mark - Setter Getter Methods
- (void)setGoodsDetailsItem:(DCRecommendItem2 *)goodsDetailsItem
{
//    if([[goodsDetailsItem.itempic substringToIndex:4] isEqualToString:@"http"]){
//        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsDetailsItem.itempic]];
//    }else{
//        [_goodsImageView setImage:[UIImage imageNamed:goodsDetailsItem.itempic]];
//    }
    //    [_goodsTitleImage setImage:SETIMAGE(@"icon_taobao")];
    //判断佣金条是否显示
//    [goodsDetailsItem.tkmoney integerValue]==0 ?[_commissionLabel setHidden:YES]:[_commissionLabel setText:[NSString stringWithFormat:@"预估佣金：￥%lf",[goodsDetailsItem.tkmoney floatValue]]];
    [_downPriceBtn setHidden:YES];
    //淘宝&天猫店铺
    [_goodsTitleImage setImage:SETIMAGE([goodsDetailsItem.shoptype isEqualToString:@"C"]?@"icon_taobao":@"icon_tianmao")];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[goodsDetailsItem.itemendprice floatValue]];
    [_beforeDownPriceLabel setText:[goodsDetailsItem.shoptype isEqualToString:@"C"]?[NSString stringWithFormat:@"淘宝价：¥ %.2f",[goodsDetailsItem.itemprice floatValue]]:[NSString stringWithFormat:@"天猫价:¥ %.2f",[goodsDetailsItem.itemprice floatValue]]];
    _goodsLabel.text = goodsDetailsItem.itemtitle;
    [_getTicketButton setTitle:[NSString stringWithFormat:@"券￥%d",[goodsDetailsItem.couponmoney intValue]] forState:UIControlStateNormal];
    [_mothSalesVolume setText:[NSString stringWithFormat:@"月销:%d",[goodsDetailsItem.itemsale intValue]]];
    //首行缩进
//    [DCSpeedy dc_setUpLabel:_goodsLabel Content:_goodsLabel.text IndentationFortheFirstLineWith:_goodsLabel.font.pointSize * 1.5];
//    [DCSpeedy dc_setUpLabel:_goodsLabel Content:self.goodsDetailsItem.main_title IndentationFortheFirstLineWith:_priceLabel.font.pointSize * 1];
}


#pragma mark - 分享按钮点击
- (void)shareButtonClick
{
    !_shareButtonClickBlock ? : _shareButtonClickBlock();
}

#pragma mark - Setter Getter Methods


@end
