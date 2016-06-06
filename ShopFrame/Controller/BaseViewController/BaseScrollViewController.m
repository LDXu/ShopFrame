//
//  BaseScrollViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/31.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()<UIScrollViewDelegate>

@end

@implementation BaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT - [self navBarHeight])];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    _scrollView.backgroundColor = [ZUtility colorForHex:@"fff2f1"];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
}

- (void)setMJRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMainView)];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.scrollView.mj_header = header;
}
- (void)refreshFinish
{
    [self.scrollView.mj_header endRefreshing];
}


- (void)refreshMainView
{
    [self loadNewData];
    [self.scrollView.mj_header endRefreshing];
}


- (void)initLoadingView
{
    [self initLoadingViewWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT - 49 - [self navBarHeight])];
}

- (void)initLoadingViewWithFrame:(CGRect)frame
{
//    if (!self.loadingView) {
//        self.loadingView = [LBViewFactory createLoadingServiceViewWithFrame:frame];
//    }
//    //    self.loadingView.backgroundColor = self.view.backgroundColor;
//    [self.view addSubview:self.loadingView];
//    
//    //    self.loadingView.hidden = YES;
//    //    _scrollView.hidden = YES;
//    [self.view addSubview:self.loadingView];
//    
//    self.loadingView.hidden = YES;
}

- (void)initErrorView
{
    [self initErrorViewWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_WIDTH  - [self navBarHeight])];
}
- (void)initErrorViewWithFrame:(CGRect)frame
{
//    if (!self.errorView) {
//        self.errorView = [LBViewFactory createErrorViewWithFrame:frame errorInfo:@"加载失败" target:self action:@selector(loadData)];
//        //        self.networkErrorView = view;
//    }
//    self.loadingView.hidden = YES;
//    self.scrollView.hidden = YES;
//    
//    
//    [self.view addSubview:self.errorView];
//    //    self.errorView.hidden = YES;
    
}

- (void)loadData
{
    [self initLoadingView];
    [self continueAnimate];
}

- (void)continueAnimate
{
    if (self.loadingView) {
        self.loadingView.hidden = NO;
        UIView *icon = [self.loadingView viewWithTag:200001];
        UIImageView *loadingView = [icon viewWithTag:1234];
        [loadingView startAnimating];
        
        self.scrollView.hidden = YES;
    }
    
}

- (void)stopAnimate
{
//    if (self.loadingView) {
//        UIView *icon = [self.loadingView viewWithTag:200001];
//        [icon stopRotateAnimation];
//        self.loadingView.hidden = YES;
//    }
//    self.scrollView.hidden = NO;
}

- (void)serviceSucceededWithResult:(id)result
{
    [self stopAnimate];
    self.errorView.hidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
