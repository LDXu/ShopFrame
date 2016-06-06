//
//  RuntimePushSuperViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/6.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "RuntimePushSuperViewController.h"

@interface RuntimePushSuperViewController ()

@end

@implementation RuntimePushSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.view.backgroundColor = color;
}

- (void)setCustomtitle:(NSString *)customtitle
{
    _customtitle = customtitle;
    [self configTitleWithString:customtitle];
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
