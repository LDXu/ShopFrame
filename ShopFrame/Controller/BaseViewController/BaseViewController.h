//
//  BaseViewController.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *requestArray;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, weak) UIView *errorView;
@property (nonatomic, strong) UIView *networkErrorView;
@property (nonatomic, assign) UINavigationController* nav;

/**
 *  添加没有商品时空视图
 */
//- (void)initErrorViewWithType:(LBErrorViewType)type
//                        frame:(CGRect)frame;
/**
 *  添加网络错误提示图
 */
//- (void)initNetworkErrorViewWithType:(LBErrorViewType)type
//                               frame:(CGRect)frame;
/**
 *  添加等待试图
 */
- (void)initLoadingView;
- (void)initLoadingViewWithFrame:(CGRect)frame;

/**
 *  等待试图显示并开始动画
 */
- (void)continueAnimate;

/**
 *  等待试图隐藏并关闭动画
 */
- (void)stopAnimate;

/**
 *  刷新网络错误
 */
- (void)refreshForNetworkError;



/**
 *  添加导航栏左边的返回按钮
 */
- (void)configBackButton;
- (void)back;

/**
 *  添加导航栏左边的搜索按钮
 */
- (void)configLeftSearchButton;

/**
 *  添加导航栏右边带文字的按钮
 */
- (void)configRightButtonWithTitle:(NSString *)title
                            target:(id)target
                          selector:(SEL)selector;
/**
 *  添加导航栏右边带图片的按钮
 */
- (void)configRightBarButtonWithImage:(UIImage*)image
                               target:(id)target
                             selector:(SEL)selector;
-(void)configRightBarButtonWithImage:(UIImage*)image
                              target:(id)target
                            selector:(SEL)selector
                               frame:(CGRect)frame;

/**
 *  添加导航栏左边带文字的按钮
 */
- (void)configLeftButtonWithTitle:(NSString *)title
                           target:(id)target
                         selector:(SEL)selector;


/**
 *  添加导航栏左边带图片的按钮
 */
- (void)configLeftButtonWithImage:(UIImage *)image
                           target:(id)target
                         selector:(SEL)selector;
- (void)configLeftBarButtonWithImage:(UIImage*)image
                              target:(id)target
                            selector:(SEL)selector
                               frame:(CGRect)frame;


- (void)configRightBarButtonWithCustomView:(UIView *)customView;
- (void)configLeftBarButtonWithCustomView:(UIView *)customView;
- (void)configTitleWithCustomView:(UIView *)customView;
- (void)configTitleWithString:(NSString *)title;

- (CGFloat)navBarHeight;

/**
 *  隐藏标签栏
 */
- (void)hiddenTabbar;
/**
 *  显示标签栏
 */
- (void)showTabbar;


/**
 *  网络请求
 */
- (void)loadNewData;

/**
 *  网络请求上传参数
 */
//- (LBNetworkServiceItem *)getServiceItem;
//
//- (void)startService;
//
//- (void)startServiceWithItem:(LBNetworkServiceItem *)item isShowLoading:(BOOL)isShowLoading;
//
//- (void)serviceSucceedWithResult:(id)result operation:(AFHTTPRequestOperation *)operation;
//- (void)serviceFailedWithError:(NSError *)error operation:(AFHTTPRequestOperation *)operation;
//
//- (BOOL)isEqualUrl:(NSString *)url forOperation:(AFHTTPRequestOperation *)operation;

- (void)showNetworkError;
- (void)showError;

/**
 * 释放键盘
 */
- (void)setUpForDismissKeyboard;


@end
