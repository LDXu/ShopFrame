//
//  BaseTableViewCell.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableItem.h"


@interface BaseTableViewCell : UITableViewCell


@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, strong) NSMutableArray *requestArray;

- (void)updateCell:(BaseTableItem *)item;

@end
