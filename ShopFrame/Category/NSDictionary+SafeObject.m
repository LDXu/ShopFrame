//
//  NSDictionary+SafeObject.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "NSDictionary+SafeObject.h"

@implementation NSDictionary (SafeObject)
- (id)safeObjectForKey:(id)key
{
    id result = [self objectForKey:key];
    if ([result isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [result stringValue];
    }
    return result;
}

@end
