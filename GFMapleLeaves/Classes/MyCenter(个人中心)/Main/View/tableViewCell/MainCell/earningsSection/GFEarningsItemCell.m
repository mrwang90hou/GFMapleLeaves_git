//
//  GFEarningsItemCell.m
//  GFMapleLeaves
//
//  Created by L on 2018/9/21.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFEarningsItemCell.h"

// Controllers

// Models

// Views
//#import "DCGoodsGridCell.h"
// Vendors

// Categories

// Others

@interface GFEarningsItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *earningLabel;

@end


@implementation GFEarningsItemCell


#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor grayColor];
    
//    [DCSpeedy dc_chageControlCircularWith:_controlButton AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
    
#pragma mark - Setter Getter Methods
}
@end
