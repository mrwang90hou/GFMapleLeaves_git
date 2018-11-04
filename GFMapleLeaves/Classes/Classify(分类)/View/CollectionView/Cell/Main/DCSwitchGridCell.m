//
//  DCSwitchGridCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/13.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCSwitchGridCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCSwitchGridCell ()


/* 商品图片 */
@property (strong , nonatomic)UIImageView *gridImageView;
/* 淘宝 logo */
@property (strong , nonatomic)UIImageView *tbLogoImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 满减 */
@property (strong , nonatomic)UIImageView *downPriceImageView;
@property (strong , nonatomic)UILabel *downPriceLabel;
/* 好评率 */
@property (strong , nonatomic)UILabel *goodsRateRLabel;
/* 天猫价格 */
@property (strong , nonatomic)UILabel *tCatPriceLabel;
/* 月销量 */
@property (strong , nonatomic)UILabel *mothSalesVolumeLabel;
/* 券 */
@property (strong , nonatomic)UIImageView *ticketImageView;
@property (strong , nonatomic)UILabel *ticketLabel;
@end
@implementation DCSwitchGridCell
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
    
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    _tbLogoImageView = [[UIImageView alloc] init];
//    _tbLogoImageView.image = [UIImage imageNamed:@"icon_taobao"];
    [self addSubview:_tbLogoImageView];
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    _downPriceImageView = [[UIImageView alloc] init];
    _downPriceImageView.image = [UIImage imageNamed:@"coupons_bg"];
    _downPriceImageView.hidden = true;
    [self addSubview:_downPriceImageView];
    _downPriceLabel = [[UILabel alloc] init];
    _downPriceLabel.font = PFR11Font;
    _downPriceLabel.text = @"满两套减50";
//    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coupons_bg"]];
    [_downPriceLabel setBackgroundColor:[UIColor orangeColor]];
//    _downPriceLabel.backgroundColor = [UIImage imageNamed:@"coupons_bg"];
    _downPriceLabel.textColor = [UIColor whiteColor];
    [self addSubview:_downPriceLabel];
    _goodsRateRLabel = [[UILabel alloc] init];
    _goodsRateRLabel.font = PFR11Font;
//    _goodsRateRLabel.text = @"好评99.8%";
    _goodsRateRLabel.textColor = [UIColor grayColor];
    [self addSubview:_goodsRateRLabel];
    _tCatPriceLabel = [[UILabel alloc] init];
    _tCatPriceLabel.font = PFR11Font;
//    _tCatPriceLabel.text = @"天猫价：168";
    _tCatPriceLabel.textColor = [UIColor grayColor];
    [self addSubview:_tCatPriceLabel];
    _mothSalesVolumeLabel = [[UILabel alloc] init];
    _mothSalesVolumeLabel.font = PFR11Font;
//    _mothSalesVolumeLabel.text = @"月销450";
    _mothSalesVolumeLabel.textColor = [UIColor grayColor];
    [self addSubview:_mothSalesVolumeLabel];
    _ticketImageView = [[UIImageView alloc] init];
    _ticketImageView.image = [UIImage imageNamed:@"coupons_bg"];
    [self addSubview:_ticketImageView];
    _ticketLabel = [[UILabel alloc] init];
    _ticketLabel.font = PFR11Font;
//    _ticketLabel.text = @"券￥50";
//    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coupons_bg"]];
//    [_ticketLabel setBackgroundColor:color];
    _ticketLabel.textColor = [UIColor whiteColor];
    [_ticketImageView addSubview:_ticketLabel];
//    _tCatPriceLabel = [[UILabel alloc] init];
//    NSInteger pNum = arc4random() % 10000;
//    _tCatPriceLabel.text = [NSString stringWithFormat:@"%zd人已评价",pNum];
//    _tCatPriceLabel.font = PFR10Font;
//    _tCatPriceLabel.textColor = [UIColor darkGrayColor];
//    [self addSubview:_tCatPriceLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(self.dc_width * 0.8, self.dc_width * 0.8));
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:4];
        [make.top.mas_equalTo(self.gridImageView.mas_bottom)setOffset:2];
        [make.right.mas_equalTo(self)setOffset:-0];
    }];
    
    [_tbLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:15];
        [make.top.mas_equalTo(self.gridImageView.mas_bottom)setOffset:6];
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gridLabel);
        [make.top.mas_equalTo(self.gridLabel.mas_bottom)setOffset:2];
    }];
    [_downPriceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(2);
//        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
        make.centerY.equalTo(self.priceLabel);
    }];
    [_downPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.priceLabel.mas_right).offset(2);
        //        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
//        make.center.equalTo(self.downPriceImageView);
//        make.centerX.equalTo(self._downPriceImageView);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(2);
        //        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
        make.centerY.equalTo(self.priceLabel);
        
    }];
    
    [_goodsRateRLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-4);
//        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
        make.centerY.equalTo(self.priceLabel);
    }];
    [_tCatPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gridLabel);
        [make.top.mas_equalTo(self.priceLabel.mas_bottom)setOffset:2];
    }];
    
    [_mothSalesVolumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tCatPriceLabel.mas_right);
//        make.centerX.mas_equalTo(self);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];
    
    [_ticketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-4);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];
    [_ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.priceLabel.mas_right).offset(2);
        //        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
        make.center.equalTo(self.ticketImageView);
        //        make.centerX.equalTo(self._downPriceImageView);
//        make.right.mas_equalTo(self).offset(-4);
//        make.centerY.equalTo(self.tCatPriceLabel);
        
    }];
    
}

#pragma mark - Setter Getter Methods
- (void)setYouSelectItem:(DCRecommendItem2 *)youSelectItem
{
    _youSelectItem = youSelectItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:youSelectItem.itempic]];
//    _gridImageView.image = [UIImage imageNamed:@"icon_default_loadError128"];
    
    //淘宝&天猫店铺
    [_tbLogoImageView setImage:SETIMAGE([youSelectItem.shoptype isEqualToString:@"C"]?@"icon_taobao":@"icon_tianmao")];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youSelectItem.itemendprice floatValue]];
    //    [_beforeDownPriceLabel setText:[NSString stringWithFormat:@"淘宝价：¥ %.2f",[youSelectItem.itemprice floatValue]]];
    
    [_tCatPriceLabel setText:[youSelectItem.shoptype isEqualToString:@"C"]?[NSString stringWithFormat:@"淘宝价:¥%.2f",[youSelectItem.itemprice floatValue]]:[NSString stringWithFormat:@"天猫价:¥%.2f",[youSelectItem.itemprice floatValue]]];
    _gridLabel.text = youSelectItem.itemtitle;
    [_ticketLabel setText:[NSString stringWithFormat:@"券￥%d",[youSelectItem.couponmoney intValue]]];
    [_mothSalesVolumeLabel setText:[NSString stringWithFormat:@"月销:%d",[youSelectItem.itemsale intValue]]];
    _downPriceImageView.image = [UIImage imageNamed:@"coupons_bg"];
    _downPriceLabel.text = @"满两套减50";
    _goodsRateRLabel.text = @"好评99.8%";
    _ticketImageView.image = [UIImage imageNamed:@"coupons_bg"];
    //首行缩进
    [DCSpeedy dc_setUpLabel:_gridLabel Content:_gridLabel.text IndentationFortheFirstLineWith:_gridLabel.font.pointSize * 2];
}


@end
