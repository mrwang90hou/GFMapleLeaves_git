//
//  GFCustomerServiceCenterViewController.m
//  GFMapleLeaves
//
//  Created by mrwang90hou on 2018/10/24.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//

#import "GFCustomerServiceCenterViewController.h"
#import "GFCustomerServiceCenterCell.h"
#import "GKFeedBackInfoCell.h"
#define HeaderImageHeight ScreenW/2
#define kLineSpacing DCMargin/2

static NSString *GFCustomerServiceCenterCellID = @"GFCustomerServiceCenterCell";
static NSString *GKFeedBackInfoCellID = @"GKFeedBackInfoCell";

@interface GFCustomerServiceCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSIndexPath * _indexPath;
}
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic,strong)  NSMutableArray *dataSoucre;


@end

@implementation GFCustomerServiceCenterViewController
#pragma mark - lazy load
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DCNaviH+K_HEIGHT_NAVBAR, ScreenW, ScreenH-DCNaviH-K_HEIGHT_NAVBAR) style:UITableViewStylePlain];//UITableViewStyleGrouped
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"GFCustomerServiceCenterCell" bundle:nil] forCellReuseIdentifier:GFCustomerServiceCenterCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"GKFeedBackInfoCell" bundle:nil] forCellReuseIdentifier:GKFeedBackInfoCellID];
        _tableView.allowsSelection = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSoucre
{
    if (_dataSoucre==nil) {
        _dataSoucre=[NSMutableArray array];
    }
    [_dataSoucre addObject:@"客服中心"];
    return _dataSoucre;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服中心";
    [self getUI];
    [self getData];
}

- (void)getUI{
    [self.view setBackgroundColor:TABLEVIEW_BG];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView setBackgroundColor:TABLEVIEW_BG];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(K_HEIGHT_NAVBAR + DCNaviH);
//        make.top.equalTo(self.view);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(150);
//    }];
}
#pragma mark -页面逻辑方法

- (void)getData{
    [self requestData];
}
//获取故障历史信息、报障历史列表
-(void)requestData{
//    NSString *cookid = [DCObjManager dc_readUserDataForKey:@"key"];
//    if (cookid) {
//
//        NSDictionary *dict=@{
//                          @"id":@"212423414"
//                          };
//        [GCHttpDataTool getFaultListWithDict:dict success:^(id responseObject) {
//            [SVProgressHUD dismiss];
////            [SVProgressHUD showSuccessWithStatus:@"获取故障历史信息、报障历史列表成功！"];
//
//        } failure:^(MQError *error) {
//            [SVProgressHUD showErrorWithStatus:error.msg];
//        }];
//    }else{
//        return;
//    }
}
#pragma mark -用户交互方法



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

#pragma mark collectionView代理方法

#pragma mark -tableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *TVcell = [UITableViewCell new];
//    if(indexPath.section == 2){
//        GKFeedBackInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GKFeedBackInfoCell"];
//        if (!cell) {
//            cell = [[GKFeedBackInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GKFeedBackInfoCell"];
//        }
//        cell.peopleTitleLabel.text = @"服务进度";
//        cell.timeLabel.text = @"  ";
//        cell.detailTV.text = @"进行中.../完成/目前没有服务进度，请耐心等待。";
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        TVcell = cell;
//    }else{
//        GFCustomerServiceCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:GFCustomerServiceCenterCellID forIndexPath:indexPath];
//        // 3.设置数据
//        NSArray *headerLabelArr=[[NSArray alloc] initWithObjects:@"客服电话",@"在线客服",@"服务进度",nil];
//        NSArray *footerLabelArr=[[NSArray alloc] initWithObjects:@"400-***-11-123",@"微信/QQ",@"进行中.../完成/目前没有服务进度",nil];
//        [cell.headerLeabel setText:[headerLabelArr objectAtIndex:indexPath.section]];
//        [cell.detailsLeabel setText:[footerLabelArr objectAtIndex:indexPath.section]];
//        //    [cell.textLabel setFont:GKFontAndFontName(@"Regular",14)];
//        //    [cell.detailTextLabel setTextColor:TEXTGRAYCOLOR];
//        //    [cell.detailTextLabel setFont:GKFont(12)];
////        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        TVcell = cell;
//    }
    //
    GFCustomerServiceCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:GFCustomerServiceCenterCellID forIndexPath:indexPath];
    // 3.设置数据
    NSArray *headerLabelArr=[[NSArray alloc] initWithObjects:@"客服电话",@"在线客服",@"服务进度",nil];
    NSArray *footerLabelArr=[[NSArray alloc] initWithObjects:@"400-***-11-123",@"微信/QQ",@"进行中.../完成/目前没有服务进度",nil];
    [cell.headerLeabel setText:[headerLabelArr objectAtIndex:indexPath.section]];
    [cell.detailsLeabel setText:[footerLabelArr objectAtIndex:indexPath.section]];
    //    [cell.textLabel setFont:GKFontAndFontName(@"Regular",14)];
    //    [cell.detailTextLabel setTextColor:TEXTGRAYCOLOR];
    //    [cell.detailTextLabel setFont:GKFont(12)];
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryType = UITableViewCellAccessoryNone;
    TVcell = cell;
    
    
    return TVcell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [SVProgressHUD showInfoWithStatus:@"联系客服"];
            break;
        case 1:
            [SVProgressHUD showInfoWithStatus:@"在线客服"];
            break;
        case 2:
            [SVProgressHUD showInfoWithStatus:@"服务进度"];
            break;
        default:
            break;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 2){
//        return 130;
//    }else{
//        return 44;
//    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 11;
}
@end
