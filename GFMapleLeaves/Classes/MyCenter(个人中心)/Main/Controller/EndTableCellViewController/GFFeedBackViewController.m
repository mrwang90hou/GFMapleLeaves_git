//
//  GFFeedBackViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/24.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//


#import "GFFeedBackViewController.h"

@interface GFFeedBackViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextView *feedBackContentTV;

@property (nonatomic,strong) UIButton *endingBtn;
@end

@implementation GFFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:TABLEVIEW_BG];
    self.title = @"意见反馈";
    [self setupUI];
}

-(void)setupUI{
    
    /* 消费详情view */
    /*（1）*/
    
    UILabel *feedBackLabel = [[UILabel alloc]init];
    [self.view addSubview:feedBackLabel];
    [feedBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 24));
    }];
    [feedBackLabel setFont:GKFont(17)];
    [feedBackLabel setText:@"我要反馈"];
    
    //先布局evaluationContentTF评价内容
    UITextView *feedBackContentTV = [[UITextView alloc]init];
    [self.view addSubview:feedBackContentTV];
    [feedBackContentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(feedBackLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
//        make.width.mas_equalTo(ScreenW-30);
        make.height.mas_equalTo(140);
    }];
    feedBackContentTV.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    feedBackContentTV.backgroundColor = [UIColor whiteColor];
    feedBackContentTV.textColor = [UIColor darkGrayColor];
    feedBackContentTV.text = @"请输入反馈内容...";
    feedBackContentTV.font = [UIFont systemFontOfSize:15.0];
    feedBackContentTV.layer.cornerRadius = 6.0;
    feedBackContentTV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    feedBackContentTV.layer.borderWidth = 1 / ([UIScreen mainScreen].scale);
    self.feedBackContentTV = feedBackContentTV;
   
    /*（2）拍照上传*/
    UILabel *photoUploadLabel = [[UILabel alloc]init];
    [self.view addSubview:photoUploadLabel];
    [photoUploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(feedBackContentTV.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 24));
    }];
    [photoUploadLabel setFont:GKFont(17)];
    [photoUploadLabel setText:@"拍照上传"];
    
    UIView *bgView = [[UIView alloc]init];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(photoUploadLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(140);
    }];
    UIButton *addPicBtn = [[UIButton alloc]init];
    [addPicBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:addPicBtn];
    [addPicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(12);
        make.centerY.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    /*（3）确认提交*/
    UIButton *endingBtn = [[UIButton alloc]init];
    [self.view addSubview:endingBtn];
    [endingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(60);
        make.centerX.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(307, 44));
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@(44));
    }];
    [endingBtn addTarget:self action:@selector(endingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [endingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//0xFCE9B
    [endingBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [endingBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_background_icon_style01"] forState:UIControlStateNormal];
    self.endingBtn = endingBtn;
    
    //    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5,50,300,170)];
    //    self.textView = evaluationContentTF;
    //    self.textView.delegate = self;
    //    self.textView.layer.borderWidth = 1.0;//边宽
    //    self.textView.layer.cornerRadius = 5.0;//设置圆角
    ////    self.textView.layer.borderColor =[[UIColor grayColor]colorWithAlphaComponet:0.5];
    //    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //    //再创建个可以放置默认字的lable
    //    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-5,290,60)];
    //    self.placeHolderLabel.numberOfLines = 0;
    //    self.placeHolderLabel.text = @"您还能输入300字";
    //    self.placeHolderLabel.backgroundColor =[UIColor clearColor];
    //    //多余的一步不需要的可以不写  计算textview的输入字数
    //    self.residueLabel = [[UILabel alloc]init];
    ////    [[UILabel alloc]initWithFrame:CGReactMake:(240,140,60,20)];
    //
    //    self.residueLabel.backgroundColor = [UIColor clearColor];
    //    self.residueLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    //    self.residueLabel.text =[NSString stringWithFormat:@"140/140"];
    //    self.residueLabel.textColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    //    //最后添加上即可
    //    [self.view addSubview :self.textView];
    //    [self.textView addSubview:self.placeHolderLabel];
    //    self.evaluationContentTF = evaluationContentTF;
}
#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_feedBackContentTV.text.length != 0) {
        self.endingBtn.enabled = YES;
    }else{
        self.endingBtn.enabled = NO;
    }
}
-(void)endingBtnAction{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
    });
}

@end
