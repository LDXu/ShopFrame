//
//  NetworkServiceItem.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkServiceItem : NSObject
/**
 *  网络接口
 */
@property (nonatomic, copy) NSString *url;
/**
 *  请求成功
 */
@property (nonatomic, copy) NSString *method;
/**
 *  请求的参数
 */
@property (nonatomic, copy) NSMutableDictionary *parameters;

@end
