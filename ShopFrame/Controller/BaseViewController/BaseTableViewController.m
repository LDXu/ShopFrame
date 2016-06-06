//
//  BaseTableViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/31.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableItem.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
{
    BOOL _isRefreshLoading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT - 49 - self.navBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    
    _tableView.frame = CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT - self.navBarHeight);
    
    self.view.backgroundColor = [ZUtility colorForHex:@"fff2f1"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    self.tbDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
}

//- (void)initErrorViewWithType:(LBErrorViewType)type frame:(CGRect)frame
//{
//    LBErrorView *errorView = [[LBErrorView alloc] initWithFrame:frame type:type];
//    self.errorView = errorView;
//    [self.view insertSubview:self.errorView belowSubview:self.tableView];
//}

- (void)continueAnimate
{
    [super continueAnimate];
    self.tableView.hidden = YES;
}

- (void)stopAnimate
{
    [super stopAnimate];
    self.isReloading = NO;
    self.tableView.hidden = NO;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark -添加下拉刷新
- (void)setMJRefresh
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshloadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
}

- (void)RefreshloadNewData
{
    _isRefreshLoading = YES;
    [self loadNewData];
}

- (NSString *)getTableRequestUrl
{
    return nil;
}

- (void)loadNewData
{
    if (!self.isTableLoading && [self getTableRequestUrl]) {
        if (!_isRefreshLoading) {
            [self continueAnimate];
        }
        
        _isRefreshLoading = NO;
        self.currentPage = 1;
        self.isReloading = YES;
        self.isTableLoading = YES;
        DLog(@"开始刷新");
        [self startService];
    } else {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark -上啦刷新
- (void)setLoadMore
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    self.tableView.mj_footer.hidden = YES;
}
- (void)loadMoreData
{
    _currentPage++;
    [self startService];
}

#pragma mark -tableviewDelegate
- (BOOL)isSelectionStyleNone
{
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tbDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableItem *item = [_tbDataArray objectAtIndex:indexPath.row];
    return [item cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableItem *item = [_tbDataArray objectAtIndex:indexPath.row];
    NSString *cellIdentification = [item cellClassName];
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentification];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:[item cellClassName] owner:self options:0] objectAtIndex:0];
    }
    cell.indexPath = indexPath;
    if ([self isSelectionStyleNone]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([item isKindOfClass:[BaseTableItem class]]) {
        [cell updateCell:item];
    }
    return cell;
}

- (void)reloadTableViewWithIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark -NetworkService
- (NSArray *)getDataArrayWithResult:(id)result
{
    return nil;
}

-(void)updateTableViewDataSourceWithData:(id)data operation:(NSURLSessionDataTask *)operation
{
    NSArray *dataArray = [self getDataArrayWithResult:data];
    [self serviceWithResult:dataArray operation:operation];
}

#pragma mark - 网络请求成功后
- (void)serviceSucceedWithResult:(id)result operation:(NSURLSessionDataTask *)operation
{
    DLog(@"request ========================= %@",result);
    
    if ([self isEqualUrl:[self getTableRequestUrl] forOperation:operation]) {
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            //            NSDictionary *dict = [result safeObjectForKey:@"listInfo"];
            //            NSString *imagePath = [dict safeObjectForKey:@"imagePath"];
            //            if (imagePath.length > 0) {
            //                [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"imagePath"];
            //            }
            
            NSArray *listArray = [result objectForKey:@"dataList"];
            if (listArray) {
                [self updateTableViewDataSourceWithData:listArray operation:operation];
                return;
            }
        }
        [self updateTableViewDataSourceWithData:result operation:operation];
    }
}

- (void)serviceFailedWithError:(NSError *)error operation:(NSURLSessionDataTask *)operation
{
    if ([self isEqualUrl:[self getTableRequestUrl] forOperation:operation]) {
        if (!self.isReloading) {
            self.currentPage--;
        }
    }
    [self serviceSucceedWithResult:nil operation:operation];
}

#pragma mark -根据list数组的个数来进行操作
- (void)serviceWithResult:(NSArray *)result operation:(NSURLSessionDataTask *)operation
{
    if (result) {
        self.tableView.mj_footer.hidden = [result count] < [PageSize intValue] ? YES : NO;
        if (self.tableView.mj_footer.hidden) {
            
        }
        //如果请求下来的数组为0显示错误
        if ([result count] <= 0) {
            [self reloadTableViewData];
            [self showError];
        } else {
            [self refreshTableViewWithDataArray:result];
        }
    } else {
        //如果没有result,刷新tableview
        [self reloadTableViewData];
        //展示空视图并隐藏tableview
        [self showNetworkError];
    }
    if ([self isEqualUrl:[self getTableRequestUrl] forOperation:operation]) {
        _isTableLoading = NO;
    }
}

- (void)reloadTableViewData
{
    if (self.isReloading) {
        [self.tbDataArray removeAllObjects];
    }
    [self.tableView reloadData];
}

#pragma mark -有数据的时候刷新tableview
- (void)refreshTableViewWithDataArray:(NSArray *)dataArray
{
    //有数据的时候显示tableview并隐藏网络等待和空界面
    self.networkErrorView.hidden = YES;
    self.errorView.hidden = YES;
    self.tableView.hidden = NO;
    if (self.isReloading) {
        [self.tbDataArray removeAllObjects];
    }
    [self.tbDataArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
    [self stopAnimate];
}

- (void)showNetworkError
{
    [super showNetworkError];
    self.tableView.hidden = YES;
}

- (void)refreshForNetworkError
{
    [self loadNewData];
}

- (void)showError
{
    [super showError];
    if ([self.tbDataArray count] > 0) {
        self.errorView.hidden = YES;
        self.networkErrorView.hidden = YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
