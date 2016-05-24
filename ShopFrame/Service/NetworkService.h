//
//  NetworkService.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (instancetype)shareManager;
/**
 *  get请求
 */
- (AFHTTPSessionManager *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(NSURLSessionDataTask * dataTask, id responseObject))success failure:(void (^)(NSURLSessionDataTask * dataTask, NSError * error))failure;
/**
 *  post请求
 */
- (AFHTTPSessionManager *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(NSURLSessionDataTask * dataTask, id responseObject))success failure:(void (^)(NSURLSessionDataTask * dataTask, NSError * error))failure;
@end
