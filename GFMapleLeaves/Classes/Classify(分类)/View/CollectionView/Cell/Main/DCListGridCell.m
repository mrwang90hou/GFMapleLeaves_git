//
//  DCListGridCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/13.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "DCListGridCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCListGridCell ()


/* 商品图片 */
@property (strong , nonatomic)UIImageView *gridImageView;
//视频播放按钮
@property (strong , nonatomic)UIImageView *videoView;
/* 淘宝 logo */
@property (strong , nonatomic)UIImageView *tbLogoImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 淘宝|好货 */
@property (strong , nonatomic)UILabel * goodGridLabel;

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
/* 冒号 */
@property (strong , nonatomic)UIButton *colonButton;

@end

@implementation DCListGridCell

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
    //视频播放按钮
    _videoView = [[UIImageView alloc]init];
    [_videoView setImage:SETIMAGE(@"icon_video_default")];
    [self addSubview:_videoView];
    _tbLogoImageView = [[UIImageView alloc] init];
//    _tbLogoImageView.image = [UIImage imageNamed:@"icon_taobao"];
    [self addSubview:_tbLogoImageView];
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];
    _goodGridLabel = [[UILabel alloc] init];
    _goodGridLabel.font = PFR14Font;
    _goodGridLabel.textColor = [UIColor grayColor];
    _goodGridLabel.numberOfLines = 2;
    _goodGridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodGridLabel];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    _downPriceImageView = [[UIImageView alloc] init];
//    _downPriceImageView.image = [UIImage imageNamed:@"coupons_bg"];
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
    _ticketLabel.font = PFR13Font;
    _ticketLabel.text = @"券￥5";
    //    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"coupons_bg"]];
    //    [_ticketLabel setBackgroundColor:color];
    _ticketLabel.textColor = [UIColor whiteColor];
    [_ticketImageView addSubview:_ticketLabel];
    
    _colonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_colonButton setImage:[UIImage imageNamed:@"icon_shenglue"] forState:UIControlStateNormal];
    [_colonButton addTarget:self action:@selector(colonButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_colonButton];
    _colonButton.hidden = true;
    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(5);
        [make.left.mas_equalTo(self)setOffset:DCMargin * 2];
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.gridImageView);
        make.centerY.mas_equalTo(self.gridImageView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [_tbLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.gridImageView.mas_right)setOffset:20];
        [make.top.mas_equalTo(self.gridLabel)setOffset:4];
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(self.gridImageView)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];
    [_goodGridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gridLabel);
        [make.top.mas_equalTo(self.gridLabel.mas_bottom)setOffset:10];
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodGridLabel);
        [make.top.mas_equalTo(self.goodGridLabel.mas_bottom)setOffset:2];
    }];
    
    [_downPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel);
        [make.top.mas_equalTo(self.priceLabel.mas_bottom)setOffset:2];
    }];
    [_goodsRateRLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-4);
        //        [make.top.mas_equalTo(self.priceLabel)setOffset:2];
        make.centerY.equalTo(self.downPriceLabel);
    }];
    [_tCatPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.downPriceLabel);
        [make.top.mas_equalTo(self.goodsRateRLabel.mas_bottom)setOffset:10];
    }];
    
    [_mothSalesVolumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.tbLogoImageView);
        make.left.mas_equalTo(self.tCatPriceLabel.mas_right).offset(8);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];
    
    [_ticketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-4);
        make.centerY.equalTo(self.tCatPriceLabel);
    }];
    [_ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.ticketImageView);
    }];
    
    [_colonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.bottom.mas_equalTo(self)setOffset:-DCMargin];
        make.size.mas_offset(CGSizeMake(22, 15));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setYouSelectItem:(DCRecommendItem2 *)youSelectItem
{
    
     _youSelectItem = youSelectItem;
//    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:youSelectItem.image_url]];
//    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youSelectItem.price floatValue]];
//    _gridLabel.text = youSelectItem.main_title;
//    //首行缩进
//    [DCSpeedy dc_setUpLabel:_gridLabel Content:youSelectItem.main_title IndentationFortheFirstLineWith:_gridLabel.font.pointSize * 2.5];
    
    
    
    //判断视频View是否显示
    [youSelectItem.videoid integerValue]==0 ?[_videoView setHidden:YES]:[_videoView setHidden:NO];
    
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:youSelectItem.itempic]];
    //淘宝&天猫店铺
    [_tbLogoImageView setImage:SETIMAGE([youSelectItem.shoptype isEqualToString:@"C"]?@"icon_taobao":@"icon_tianmao")];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youSelectItem.itemendprice floatValue]];
    //    [_beforeDownPriceLabel setText:[NSString stringWithFormat:@"淘宝价：¥ %.2f",[youSelectItem.itemprice floatValue]]];
    
    [_tCatPriceLabel setText:[youSelectItem.shoptype isEqualToString:@"C"]?[NSString stringWithFormat:@"淘宝价：¥ %.2f",[youSelectItem.itemprice floatValue]]:[NSString stringWithFormat:@"天猫价：¥ %.2f",[youSelectItem.itemprice floatValue]]];
    _gridLabel.text = youSelectItem.itemtitle;
    [_ticketLabel setText:[NSString stringWithFormat:@"券￥%d",[youSelectItem.couponmoney intValue]]];
    [_mothSalesVolumeLabel setText:[NSString stringWithFormat:@"月销：%d",[youSelectItem.itemsale intValue]]];
    _goodGridLabel.text = @"淘宝|好货";
    _downPriceImageView.image = [UIImage imageNamed:@"coupons_bg"];
    _downPriceLabel.text = @"满两套减50";
    _goodsRateRLabel.text = @"好评99.8%";
    _ticketImageView.image = [UIImage imageNamed:@"coupons_bg"];
    //首行缩进
    [DCSpeedy dc_setUpLabel:_gridLabel Content:_gridLabel.text IndentationFortheFirstLineWith:_gridLabel.font.pointSize * 2];
    
    
}

#pragma mark - 点击事件
- (void)colonButtonClick
{
    !_colonClickBlock ? : _colonClickBlock();
}


@end
