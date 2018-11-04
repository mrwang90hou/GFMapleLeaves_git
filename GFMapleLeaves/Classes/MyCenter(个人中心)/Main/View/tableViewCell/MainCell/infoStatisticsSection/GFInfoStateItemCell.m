//
//  GFInfoStateItemCell.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/20.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFInfoStateItemCell.h"
#import "DCStateItem.h"

@interface GFInfoStateItemCell()

@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateBgImageView;

@end

@implementation GFInfoStateItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - 赋值
- (void)setStateItem:(DCStateItem *)stateItem
{
    _stateItem = stateItem;
    
    self.stateBgImageView.backgroundColor = (stateItem.bgColor) ? RGB(240, 240, 240) : [UIColor whiteColor];
    if (stateItem.showImage) {
        [self.stateButton setImage:[UIImage imageNamed:stateItem.imageContent] forState:0];
    }else{
        [self.stateButton setTitle:stateItem.imageContent forState:0];
    }
    
    self.stateLabel.text = stateItem.stateTitle;
}


@end
