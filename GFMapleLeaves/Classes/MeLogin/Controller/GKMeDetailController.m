//
//  GKMeDetailController.m
//  Record
//
//  Created by mrwang90hou on 2018/9/2.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GKMeDetailController.h"
#import "GKChangeNameController.h"
#import "GKCheckOldPhoneController.h"
#import "GKChangePassWordController.h"
#import "GKLoginController.h"

#import "TZImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import "GKIconCellCell.h"
#import "GKDetailCell.h"

@interface GKMeDetailController ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView * userImageView;
@end

@implementation GKMeDetailController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.title = @"个人资料";
    self.view.backgroundColor = TABLEVIEW_BG;
    self.tableView.scrollEnabled = NO;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else if (section == 1) return 3;
    else if (section == 2) return 1;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GKIconCellCell *cell = [[GKIconCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKIconCellCell"];
        self.userImageView = cell.iconImageView;
        cell.iconImageView.image = self.userImageView.image;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else if(indexPath.section == 1){
        GKDetailCell *cell = [[GKDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKDetailCell"];
        if (indexPath.row == 0) {
            cell.firstLabel.text = @"用户昵称";
            cell.desLabel.text = @"小枫叶🍁";
        }else if(indexPath.row == 1){
            cell.firstLabel.text = @"手机号码";
            cell.desLabel.text = @"18577986175";
        }else if(indexPath.row == 2){
            cell.firstLabel.text = @"修改密码";
            cell.desLabel.text = @"";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LYChatGroupSettingDefault"];
        cell.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        GKButton * logoutBtn = [GKButton new];
        [cell.contentView addSubview:logoutBtn];
        [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 44));
        }];
        [logoutBtn setupCircleButton];
        logoutBtn.titleLabel.font = GKMediumFont(16);
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn addTarget:self action:@selector(loginOffClick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}
#pragma mark -(注销)退出登录操作
- (void)logoutBtnClick{
    UIAlertController *alert    = [UIAlertController alertControllerWithTitle:@"确认退出?" message:@"退出登录将无法查看个人信息,重新登录后即可查看" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *logoutAction     = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //执行注销
        [self loginOffClick];
        //返回根视图
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:logoutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 88;
    else if (indexPath.section == 1) return 50;
    else if (indexPath.section == 2) return 44;
    else return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self setAlertController];
    }else if(indexPath.section == 1 && indexPath.row == 0){
        [self.navigationController pushViewController:[GKChangeNameController new] animated:YES];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        [self.navigationController pushViewController:[GKCheckOldPhoneController new] animated:YES];
    }else if(indexPath.section == 1 && indexPath.row == 2){
        [self.navigationController pushViewController:[GKChangePassWordController new] animated:YES];
    }
}

- (void)setAlertController{
    UIAlertController *alert    = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *photoAction     = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    
    UIAlertAction *pickPhotoAction     = [UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pickPhoto];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alert addAction:photoAction];
    [alert addAction:pickPhotoAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController * imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = NO;
    imagePickerController.showsCameraControls = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        self.userImageView.image = image;
    }];
}

- (void)pickPhoto{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
//    imagePickerVc.statusBarStyle = UIStatusBarStyleDefault;
    //导航栏左右按钮颜色
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.oKButtonTitleColorNormal = UIColorFromHex(0xFFFFFF);
//    imagePickerVc.cannotSelectLayerColor = UIColorFromHex(0xFFFFFF);
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPreview = YES;
    imagePickerVc.allowTakePicture = NO;
    
    // 自定义导航栏上的返回按钮
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
    }];
    imagePickerVc.interactivePopGestureRecognizer.delegate=self;
    imagePickerVc.delegate = self;
    
    // 设置首选语言 / Set preferred language
//    imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //            [self uploadImage:photos[0]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userImageView.image = photos[0];
        });
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 退出登录
- (void)loginOffClick
{
    WEAKSELF
    [DCSpeedy dc_SetUpAlterWithView:self Message:@"是否确定退出登录" Sure:^{
        [DCObjManager dc_removeUserDataForkey:@"isLogin"];
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
//            [weakSelf.view makeToast:@"退出登录成功" duration:0.5 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //先跳出登录界面，在返回RootVC
                GKLoginController *dcLoginVc = [GKLoginController new];
                [weakSelf presentViewController:dcLoginVc animated:YES completion:^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil]; //退出登录
                }];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            });
        });
    } Cancel:nil];
}
@end
