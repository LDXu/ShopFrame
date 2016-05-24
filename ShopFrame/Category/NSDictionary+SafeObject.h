//
//  NSDictionary+SafeObject.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeObject)
/**
 *  容错查找字典中是否有这个值
 */
- (id)safeObjectForKey:(id)key;
@end
