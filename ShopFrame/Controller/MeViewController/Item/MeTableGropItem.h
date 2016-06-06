//
//  MeTableGropItem.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/6.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseTableGropItem.h"
#import "MeTableItem.h"

@interface MeTableGropItem : BaseTableGropItem

@property (nonatomic, copy) NSString *gropTitle;

- (void)reloadSubItemWithArray:(NSArray *)array;

@end
