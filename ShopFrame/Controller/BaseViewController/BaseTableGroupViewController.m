//
//  BaseTableGroupViewController.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/31.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "BaseTableGroupViewController.h"
#import "BaseTableGropItem.h"
#import "BaseTableItem.h"
#import "BaseTableViewCell.h"

@interface BaseTableGroupViewController ()

@end

@implementation BaseTableGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)serviceWithResult:(NSArray *)result operation:(NSURLSessionDataTask *)operation
{
    [super serviceWithResult:result operation:operation];
    NSInteger resultCount = 0;
    for (BaseTableGropItem *item in result) {
        if ([item isKindOfClass:[BaseTableGropItem class]]) {
            resultCount += [item.sectionData count];
        }
    }
    self.tableView.mj_footer.hidden = resultCount < [PageSize intValue] ? YES : NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tbDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseTableGropItem *item = [self.tbDataArray objectAtIndex:section];
    return [item.sectionData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BaseTableGropItem *item = [self.tbDataArray objectAtIndex:section];
    return item.sectionTitle;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableGropItem *item = [self.tbDataArray objectAtIndex:indexPath.section];
    BaseTableItem *subItem = [item.sectionData objectAtIndex:indexPath.row];
    
    return [subItem cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableGropItem *item = [self.tbDataArray objectAtIndex:indexPath.section];
    BaseTableItem *subItem = [item.sectionData objectAtIndex:indexPath.row];
    
    static NSString* cellIdentification=@"currentCell";
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentification];
    
    if (!cell) {

        cell = [[[NSBundle mainBundle] loadNibNamed:[subItem cellClassName] owner:self options:0] objectAtIndex:0];
 
    }
    
    cell.indexPath = indexPath;
    if ([subItem isKindOfClass:[BaseTableItem class]]) {
        [cell updateCell:subItem];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
