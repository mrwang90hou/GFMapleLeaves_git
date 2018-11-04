//
//  DCNewAdressView.h
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/9/19.
//Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPlaceholderTextView.h"

@interface DCNewAdressView : UIView

/** 选择地址回调 */
@property (nonatomic, copy) dispatch_block_t selectAdBlock;

@property (weak, nonatomic) IBOutlet DCPlaceholderTextView *detailTextView;
@property (weak, nonatomic) IBOutlet UITextField *rePersonField;
@property (weak, nonatomic) IBOutlet UITextField *rePhoneField;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
