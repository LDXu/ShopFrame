//
//  NetworkService.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "NetworkService.h"

@implementation NetworkService

+ (instancetype)shareManager
{
    static NetworkService *_shareManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shareManager = [self alloc];
    });
    return _shareManager;
}

- (AFHTTPSessionManager *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    return manager;
}

- (AFHTTPSessionManager *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * progress))downloadProgress success:(void (^)(NSURLSessionDataTask * dataTask, id responseObject))success failure:(void (^)(NSURLSessionDataTask * dataTask, NSError * error))failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
            if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
                NSString *code = [jsonObject safeObjectForKey:@"code"];
                NSString *msg = [jsonObject safeObjectForKey:@"msg"];
                if (code && [code isEqualToString:@"2000"]) {
                    if (msg && msg.length> 0) {
                        [[UIApplication sharedApplication].keyWindow makeToast:msg];
                    }
                    success(task, [jsonObject safeObjectForKey:@"data"]);
                    
                } else {
                
                    NSString *msg = [jsonObject safeObjectForKey:@"msg"];
                    if (msg && msg.length > 0) {
                        [[UIApplication sharedApplication].keyWindow makeToast:msg];
                    }
                    NSError *error = [NSError errorWithDomain:@"123" code:[code integerValue] userInfo:nil];
                    failure(task, error);
                }
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"服务器繁忙"];
    }];
    return manager;
}

@end
