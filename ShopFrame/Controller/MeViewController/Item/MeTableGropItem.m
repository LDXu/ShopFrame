//
//  MeTableGropItem.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/6.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "MeTableGropItem.h"

@implementation MeTableGropItem

- (void)reloadSubItemWithArray:(NSArray *)array
{
    for (NSDictionary *dic in array) {
        MeTableItem *item = [[MeTableItem alloc] init];
        [item setupWithItem:dic];
        [self.sectionData addObject:item];
    }
}

@end
