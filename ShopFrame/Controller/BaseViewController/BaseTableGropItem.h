//
//  BaseTableGropItem.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTableGropItem : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *sectionData;
@property (nonatomic, assign) BOOL isSectionSelected;

- (instancetype)init;

@end
