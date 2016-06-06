//
//  AdvertiseView.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/3.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const adImageName = ADIMAGENAME;
static NSString *const adUrl = @"adUrl";

@interface AdvertiseView : UIView

/**
 *  显示广告页面
 */
- (void)show;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

@end
