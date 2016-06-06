//
//  BaseTableItem.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTableItem : NSObject

- (BOOL)isXib;

- (CGFloat)cellHeight;

- (NSString *)cellClassName;

- (void)setupWithItem:(id)dic;

@end
