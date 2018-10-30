//
//  GKIconCellCell.m
//  Record
//
//  Created by mrwang90hou on 2018/9/2.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKIconCellCell.h"

@implementation GKIconCellCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * iconImageView = [UIImageView new];
        [self addSubview:iconImageView];
        WEAKSELF;
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf).with.offset(15);
            make.centerY.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        makeCornerRadius(iconImageView, 30);
        iconImageView.layer.borderColor = UIColorFromHex(0x707070).CGColor;
        iconImageView.layer.borderWidth = 1;
        iconImageView.image = [UIImage imageNamed:@"icon"];
        self.iconImageView = iconImageView;
        
        UILabel * desLabel = [UILabel new];
        [self addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.mas_equalTo(weakSelf).with.offset(-35);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 35 -90, 22));
        }];
        desLabel.text = @"设置头像";
        desLabel.textColor = UIColorFromHex(0x333333);
        desLabel.font = GKBlodFont(16);
        desLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}

@end
