//
//  MeViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/2.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableGropItem.h"
#import "MeTableItem.h"
#import "MeTableViewCell.h"
#import "PasswordInputWindow.h"


#import "RuntimePushListViewController.h"

#define sectionViewH 30.0


@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showTabbar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *functionArray = @[@{@"labelTile":@"runtime跳转到制定页面", @"controllerTitle":@"RuntimePushListViewController"}, @{@"labelTile":@"利用window实现密码锁定功能（密码：1234）", @"controllerTitle":@"PasswordInputWindow"}];
    [self getGropTileCreateItem:@"功能" getSubTitleArray:functionArray];
    
    
    
    
    [self.tableView reloadData];
    

}

- (void)getGropTileCreateItem:(NSString *)gropTitle getSubTitleArray:(NSArray *)subTitleArray
{
    MeTableGropItem *gropItem = [[MeTableGropItem alloc] init];
    gropItem.gropTitle = gropTitle;
    [gropItem reloadSubItemWithArray:subTitleArray];
    [self.tbDataArray addObject:gropItem];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, sectionViewH )];
    view.backgroundColor = [UIColor grayColor];
    UIView *wihtView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, AI_SCREEN_WIDTH, sectionViewH - 10)];
    wihtView.backgroundColor = [UIColor whiteColor];
    [view addSubview:wihtView];

    MeTableGropItem *gropItem = self.tbDataArray[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, wihtView.height - 1)];
    label.text = gropItem.gropTitle;
    label.font = [UIFont systemFontOfSize:13];
    [wihtView addSubview:label];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, wihtView.frame.size.height - 1, AI_SCREEN_WIDTH, 0.5)];
    lineImageView.backgroundColor = [UIColor blackColor];
    [wihtView addSubview:lineImageView];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionViewH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableGropItem *item = [self.tbDataArray objectAtIndex:indexPath.section];
    BaseTableItem *subItem = [item.sectionData objectAtIndex:indexPath.row];
    
    static NSString* cellIdentification=@"currentCell";
    
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentification];
    
    if (!cell) {
        
        cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentification];
        
    }
    
    cell.indexPath = indexPath;
    if ([subItem isKindOfClass:[BaseTableItem class]]) {
        [cell updateCell:subItem];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableGropItem *gropItem = self.tbDataArray[indexPath.section];
    MeTableItem *item = gropItem.sectionData[indexPath.row];
    if ([item.controllerTitle isEqualToString:@"PasswordInputWindow"]) {
        [[PasswordInputWindow shareInstance] show];
    } else {
        [ZUtility runtimePush:item.controllerTitle dic:nil nav:self.navigationController];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
