//
//  GKSignUpCodeView.h
//  Record
//
//  Created by mrwang90hou on 2018/9/4.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKSignUpCodeView : UIView
@property (nonatomic,strong)GKButton * codeBtn;
@property (nonatomic,strong)GKButton * nextBtn;
@property (nonatomic,strong)CAGradientLayer * clickLayer;
@property (nonatomic,strong)UILabel * hintLabel;
@property (nonatomic,strong)UITextField * codeTF;
@property (nonatomic,strong)UIImageView * codeImageView;

@end
