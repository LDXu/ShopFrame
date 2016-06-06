//
//  BaseScrollViewController.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/31.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseScrollViewController : BaseViewController


@property (nonatomic, strong) UIScrollView *scrollView;



- (void)initLoadingView;
- (void)initLoadingViewWithFrame:(CGRect)frame;
- (void)continueAnimate;
- (void)stopAnimate;

- (void)initErrorViewWithFrame:(CGRect)frame;
- (void)initErrorView;
- (void)loadData;

- (void)refreshMainView;
- (void)setMJRefresh;
- (void)refreshFinish;

@end
