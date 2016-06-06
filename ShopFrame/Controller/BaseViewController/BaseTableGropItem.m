//
//  BaseTableGropItem.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseTableGropItem.h"

@implementation BaseTableGropItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionData = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
