//
//  MeTableViewCell.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/6.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "MeTableViewCell.h"
#import "MeTableItem.h"

@implementation MeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.frame = CGRectMake(20, 0, AI_SCREEN_WIDTH - 40, self.frame.size.height);
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.frame.size.height - 1, AI_SCREEN_WIDTH, 0.5)];
        lineImageView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineImageView];
        
    }
    return self;
}

- (void)updateCell:(MeTableItem *)item
{
    self.textLabel.text = item.title;
}



@end
