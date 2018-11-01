//
//  DCGoodsHandheldCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/10.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCGoodsHandheldCell.h"

// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsHandheldCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *handheldImageView;

@end

@implementation DCGoodsHandheldCell

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
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_handheldImageView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
//        make.center.equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHandheldImage:(NSString *)handheldImage
{
    _handheldImage = handheldImage;
    if ([[handheldImage substringToIndex:4] isEqualToString:@"http"]){
         [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
    }else{
         [_handheldImageView setImage:[UIImage imageNamed:handheldImage]];
    }
   
    
}

@end
