//
//  GKSignUpCodeView.h
//  Record
//
//  Created by L on 2018/7/4.
//  Copyright © 2018年 L. All rights reserved.
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
