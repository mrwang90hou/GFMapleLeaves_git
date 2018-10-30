//
//  GFAboutUsViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/24.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//


#import "GFAboutUsViewController.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface GFAboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation GFAboutUsViewController
#pragma mark - LazyLoad
//- (UITableView *)tableView
//{    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.showsVerticalScrollIndicator = NO;
//    }
//    return _tableView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:TABLEVIEW_BG];
    self.title = @"关于小枫叶";
    [self setUI];
}

-(void)setUI{
    UIView *headerView = [[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headerView];//150
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ScreenH/4);
    }];
    UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"my_logo_showPages2"]];
    [headerView addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.mas_equalTo(headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    UILabel *label01 = [[UILabel alloc]init];
    [label01 setText:@"小枫叶"];
    [label01 setFont:GKFont(36)];
    [headerView addSubview:label01];
    [label01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_centerX);
        make.bottom.mas_equalTo(logoImage.mas_centerY).offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    UILabel *label02 = [[UILabel alloc]init];
    [label02 setText:@"Maple leaves"];
    [label02 setFont:GKFont(20)];
    [headerView addSubview:label02];
    [label02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label01);
        make.top.mas_equalTo(logoImage.mas_centerY).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cusCell = [UITableViewCell new];
    if(indexPath.section == 0){
        //        GFListItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:GFListItemsCellID forIndexPath:indexPath];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        NSArray *headerLabelArr=[[NSArray alloc] initWithObjects:@"当前版本",@"版本更新",nil];
        NSArray *footerLabelArr=[[NSArray alloc] initWithObjects:@"V1.0.0",@"暂无更新",nil];
        [cell.textLabel setText:[headerLabelArr objectAtIndex:indexPath.row]];
        [cell.detailTextLabel setText:[footerLabelArr objectAtIndex:indexPath.row]];
        [cell.textLabel setFont:GKFontAndFontName(@"Regular",12)];
        [cell.detailTextLabel setFont:GKFontAndFontName(@"Regular",12)];
        [cell.textLabel setTextColor:[UIColor lightGrayColor]];
        [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //去掉cell的自动布局添加的边距
        //        cell.layoutMargins = UIEdgeInsetsMake(1, 0, 1, 0);
        cusCell = cell;
    }
    return cusCell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//                [SVProgressHUD showInfoWithStatus:@"1"];
//                break;
//            case 1:
//                [SVProgressHUD showInfoWithStatus:@"2"];
//                break;
//            case 2:
//                [SVProgressHUD showInfoWithStatus:@"3"];
//                break;
//            case 3:
//                [SVProgressHUD showInfoWithStatus:@"4"];
//                break;
//            default:
//                break;
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark 索引路径的行高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
@end
