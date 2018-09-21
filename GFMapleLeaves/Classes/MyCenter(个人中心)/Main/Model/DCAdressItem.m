//
//  DCAdressItem.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2019/9/19.
//  Copyright © 2019年 mrwang90hou. All rights reserved.
//

#import "DCAdressItem.h"

@implementation DCAdressItem

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    CGFloat top = 52;
    CGFloat bottom = 46;
    CGFloat middle = [DCSpeedy dc_calculateTextSizeWithText:[NSString stringWithFormat:@"%@ %@",_chooseAdress,_userAdress] WithTextFont:14 WithMaxW:ScreenW - 24].height;
    
    return top + middle + bottom;;
}

@end
