//
//  BaseTableItem.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseTableItem.h"

@implementation BaseTableItem
- (NSString *)cellClassName
{
    return @"default";
}
- (CGFloat)cellHeight
{
    return 44;
}
- (void)setupWithItem:(id)dic
{
    
}

@end
