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
    
    
AFHTTPSessionManager *manager = [[NetworkService shareManager] POST:@"http://www.dengcoo.net/p/home/home" parameters:nil progress:^(NSProgress *progress) {
    
} success:^(NSURLSessionDataTask *dataTask, id responseObject) {
    
} failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
    
}];
    

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
