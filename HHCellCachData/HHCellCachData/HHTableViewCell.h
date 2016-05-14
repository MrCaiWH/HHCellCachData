//
//  HHTableViewCell.h
//  TablevViewCell
//
//  Created by 蔡万鸿 on 16/5/14.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@end

