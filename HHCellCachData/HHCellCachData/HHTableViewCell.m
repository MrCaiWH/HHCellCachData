//
//  HHTableViewCell.m
//  TablevViewCell
//
//  Created by 蔡万鸿 on 16/5/14.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "HHTableViewCell.h"

@implementation HHTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"Cell";
    HHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.infoTextField.text = nil;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

@end
