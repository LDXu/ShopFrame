//
//  MeTableItem.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/6.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "MeTableItem.h"

@implementation MeTableItem

- (NSString *)cellClassName
{
    return @"MeTableViewCell";
}

- (BOOL)isXib
{
    return NO;
}

- (CGFloat)cellHeight
{
    return 40.0;
}

- (void)setupWithItem:(id)dic
{
    self.title = [dic safeObjectForKey:@"labelTile"];
    self.controllerTitle = [dic safeObjectForKey:@"controllerTitle"];
}

@end
