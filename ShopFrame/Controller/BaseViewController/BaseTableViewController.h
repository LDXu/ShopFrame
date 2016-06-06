//
//  BaseTableViewController.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/31.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tbDataArray;


@property (nonatomic, assign)NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isReloading;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, assign) BOOL isTableLoading;


- (NSString *)getTableRequestUrl;
- (BOOL)isSelectionStyleNone;

- (void)setMJRefresh;
- (void)loadNewData;
- (void)setLoadMore;
- (void)loadMoreData;
- (void)continueAnimate;
- (void)stopAnimate;
- (void)reloadTableViewWithIndex:(NSInteger)index;
- (void)refreshTableViewWithDataArray:(NSArray *)dataArray;
- (void)serviceWithResult:(NSArray *)result operation:(AFHTTPSessionManager *)operation;

- (NSArray *)getDataArrayWithResult:(id)result;

- (void)reloadTableViewData;

@end
