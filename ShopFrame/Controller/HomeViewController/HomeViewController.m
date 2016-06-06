//
//  HomeViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar nav_setBackgroundColor:[UIColor clearColor]];
    self.scrollView.frame = CGRectMake(0, -64, AI_SCREEN_WIDTH, AI_SCREEN_HEIGHT);
    self.scrollView.contentSize = CGSizeMake(0, AI_SCREEN_HEIGHT * 2);
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.delegate = self;
    [self configTitleWithString:@"首页"];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, AI_SCREEN_WIDTH)];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.scrollView addSubview:imageView];
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor *color = RGBACOLOR(0, 175, 240, 1);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar nav_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar nav_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
