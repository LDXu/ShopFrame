//
//  BaseViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
////        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
////        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
////        [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
//    } else {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
//    }
    if (!self.requestArray) {
        self.requestArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers count] > 1) {
        [self hiddenTabbar];
    }
    if (self.loadingView.hidden == NO) {
        UIView *icon = [self.loadingView viewWithTag:200001];
        //        [icon continueRotateAnimation];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.navigationController.viewControllers count] == 1) {
        [self showTabbar];
    }
    
}

//- (void)dealloc
//{
//    for (AFHTTPSessionManager *operation in self.requestArray) {
//        if ([operation isKindOfClass:[AFHTTPSessionManager class]]) {
//            [operation ];
//        }
//    }
//}

#pragma mark- 创建并添加网络请求错误试图
//- (void)initNetworkErrorViewWithType:(LBErrorViewType)type frame:(CGRect)frame
//{
//    LBNetworkErrorView *errorView = [[LBNetworkErrorView alloc] initWithFrame:frame type:type];
//    errorView.delegate = self;
//    errorView.backgroundColor = self.view.backgroundColor;
//    self.networkErrorView = errorView;
//    [self.view addSubview:self.networkErrorView];
//}

#pragma mark- 网络错误试图的代理方法  点击请求
- (void)refreshForNetworkError
{
    [self startService];
}

#pragma mark- 创建并添加空视图
//- (void)initErrorViewWithType:(LBErrorViewType)type frame:(CGRect)frame
//{
//    LBErrorView *errorView = [[LBErrorView alloc] initWithFrame:frame type:type];
//    errorView.backgroundColor = self.view.backgroundColor;
//    self.errorView = errorView;
//    [self.view addSubview:self.errorView];
//}

#pragma mark- 创建等待试图
- (void)initLoadingView
{
    [self initLoadingViewWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT - 49 - self.navBarHeight)];
}

//- (void)initLoadingViewWithFrame:(CGRect)frame
//{
//    if (!self.loadingView) {
//        self.loadingView = [LBViewFactory createLoadingServiceViewWithFrame:frame];
//    }
//    self.loadingView.backgroundColor = self.view.backgroundColor;
//    [self.view addSubview:self.loadingView];
//    
//    self.loadingView.hidden = YES;
//    [self initNetworkErrorViewWithType:LBNetworkError frame:frame];
//    
//    self.networkErrorView.hidden = YES;
//}

#pragma mark- 开始动画
- (void)continueAnimate
{
    if (self.loadingView) {
        UIView *icon = [self.loadingView viewWithTag:200001];
        UIImageView *loadingView = [icon viewWithTag:1234];
        [loadingView startAnimating];
        self.loadingView.hidden = NO;
        self.errorView.hidden = YES;
        self.networkErrorView.hidden = YES;
    }
}

#pragma mark - loading停止动画
- (void)stopAnimate
{
    if (self.loadingView) {
        UIView *icon = [self.loadingView viewWithTag:200001];
        //        [icon stopRotateAnimation];
        UIImageView *loadingView = [icon viewWithTag:1234];
        [loadingView startAnimating];
        self.loadingView.hidden = YES;
    }
}

- (void)configLeftEmptyButton
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -12;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    view.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:view]];
}

#pragma mark - 导航栏返回按钮
- (void)configBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 17, 25);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航栏右侧按钮带文字
- (void)configRightButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 32);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 导航栏左侧按钮带文字
- (void)configLeftButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 38, 32);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}



#pragma mark - 添加右侧按钮带图片

- (void)configRightBarButtonWithImage:(UIImage*)image
                               target:(id)target
                             selector:(SEL)selector
{
    
    [self configRightBarButtonWithImage:image
                                 target:target
                               selector:selector
                                  frame:CGRectMake(0, 0, 32, 32)];
}
- (void)configRightBarButtonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}



#pragma mark - 添加左侧按钮带图片
- (void)configLeftButtonWithImage:(UIImage *)image
                           target:(id)target
                         selector:(SEL)selector
{
    [self configLeftBarButtonWithImage:image target:target selector:selector frame:CGRectMake(0, 0, 32, 32)];
}
- (void)configLeftBarButtonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector frame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark -添加标题
- (void)configTitleWithCustomView:(UIView *)customView
{
    self.navigationItem.titleView = customView;
}

#pragma mark  - 设置导航栏标题
- (void)configTitleWithString:(NSString *)title
{
    CGFloat width = [ZUtility widthForLableHeightText:title isHeight:30 isTextFont:18];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width + 10, 30)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, width + 10, 30)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    self.navigationItem.titleView = view;
}


- (CGFloat)navBarHeight
{
    return 20 + 44;
}

#pragma mark -隐藏标签栏
- (void)hiddenTabbar
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate).tabbarVC setTabBarHidden:YES animated:YES];
}

#pragma mark  - 显示标签栏
- (void)showTabbar
{
    [((AppDelegate*)[UIApplication sharedApplication].delegate).tabbarVC setTabBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 进行网络请求
- (void)loadNewData
{
    [self continueAnimate];
    [self startService];
}

- (NetworkServiceItem *)getServiceItem
{
    return nil;
}

- (void)startService
{
    [self startServiceWithItem:[self getServiceItem] isShowLoading:NO];
}


#pragma mark -网络请求
- (void)startServiceWithItem:(NetworkServiceItem *)item isShowLoading:(BOOL)isShowLoading
{
    if (isShowLoading) {
        [ZUtility showLoadingWithTitle:nil];
    }
    if (item) {
        AFHTTPSessionManager *manager = nil;
        if ([item.method isEqualToString:@"POST"]) {
            
            manager = [[NetworkService shareManager] POST:item.url parameters:item.parameters progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                [self serviceSucceedWithResult:responseObject operation:dataTask];
            } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
                [self serviceFailedWithError:error operation:dataTask];
            }];
            
        } else {
            
            manager = [[NetworkService shareManager] GET:item.url parameters:item.parameters progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                [self serviceSucceedWithResult:responseObject operation:dataTask];
            } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
                [self serviceFailedWithError:error operation:dataTask];
            }];
        }
        [self.requestArray addObject:manager];
    }
}

#pragma mark -网络请求成功
- (void)serviceSucceedWithResult:(id)result operation:(NSURLSessionDataTask *)operation
{
    [self stopAnimate];
}

#pragma mark -网络请求失败
- (void)serviceFailedWithError:(NSError *)error operation:(NSURLSessionDataTask *)operation
{
    [self showNetworkError];
}


- (BOOL)isEqualUrl:(NSString *)url forOperation:(NSURLSessionDataTask *)operation
{

    NSString *operationUrl = [operation.originalRequest.URL absoluteString];
    NSMutableString *eUrl = [[NSMutableString alloc] init];
    
    NSString *subString = [operationUrl substringToIndex:NETDOMAIN.length];
    NSString *subStrings = [operationUrl substringToIndex:NETDOMAINS.length];
    if ([subString isEqualToString:NETDOMAIN]) {
        eUrl = [NSMutableString stringWithFormat:@"%@%@",NETDOMAIN,url];
    } else  if ([subStrings isEqualToString:NETDOMAINS]){
        eUrl = [NSMutableString stringWithFormat:@"%@%@",NETDOMAINS,url];
    }
    
    return [eUrl isEqualToString:operationUrl];
}

#pragma mark -显示网络错误
- (void)showNetworkError
{
    [self stopAnimate];
    self.errorView.hidden = YES;
    self.networkErrorView.hidden = NO;
}

- (void)showError
{
    [self stopAnimate];
    if (self.errorView) {
        self.errorView.hidden = NO;
        self.networkErrorView.hidden = YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark -释放键盘
- (void)setUpForDismissKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        [self.view addGestureRecognizer:singleTapGR];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        [self.view addGestureRecognizer:singleTapGR];
    }];
    
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecongnizer{
    [self.view endEditing:YES];
}

@end
