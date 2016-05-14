//
//  ViewController.m
//  TablevViewCell
//
//  Created by 蔡万鸿 on 16/5/14.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "ViewController.h"
#import "HHTableViewCell.h"

/** 表格的列数 */
static CGFloat const listNum = 40;

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
/** tableView */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 记录缓存数据的数组 */
@property(nonatomic,strong)NSMutableArray *array;
/** 文本框是否是第一次成为第一响应者，如果是就创建缓存数据，如果不是，就修改缓存数据 */
@property (nonatomic, assign) BOOL first;
@end

@implementation ViewController

#pragma mark - ViewLife
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSMutableArray alloc] init];
    self.title = @"自动缓存数据";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHTableViewCell *cell = [HHTableViewCell cellWithTableView:tableView];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.infoTextField.delegate = self;
    
    if (self.array.count != 0) {
        for (int i = 0; i < self.array.count; ++i) {
            NSMutableDictionary *mutabDic = self.array[i];
            if (mutabDic[@(indexPath.row)] != nil) {
                cell.infoTextField.text = mutabDic[@(indexPath.row)];
            }
        }
    }
    
    return cell;
}

#pragma mark - UITextFieldDelegate
//当文本框变为第一响应者的时候，将first属性设为NO
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.first = NO;
    return YES;
}

//记录文本框中输入的文本，并将它缓存起来
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //1.获取当前文本框所属cell的indexPath.row
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    //2.获得文本框中输入的字符串长度，长度为length + 1
    NSUInteger length = range.location - range.length;
    
    //3.判断当前操作是输入文字，还是删除文字
    if (range.length != 0) { //删除文字
        //遍历数组，得到与这个文本框相对应的缓存数据，然后删除缓存数据
        //每次点击，都会删除文本框总最后一个字符
        for (int i = 0; i < self.array.count; ++i) {
            NSMutableDictionary *mutabDic = self.array[i];
            if (mutabDic[@(indexPath.row)] != nil) {
                NSMutableString *mutableStr = mutabDic[@(indexPath.row)];
                [mutableStr deleteCharactersInRange:NSMakeRange (length + 1, 1)];
            }
        }
    }
    else { //输入文字
        //遍历数组，查询当前文本框缓存是否存在，如果存在就设置first属性为NO
        for (int i = 0; i < self.array.count; ++i) {
            NSMutableDictionary *mutabDic = self.array[i];
            if (mutabDic[@(indexPath.row)] != nil) {
                self.first = YES;
            }
        }
        
        //4.获的文本框文本
            //通过range.location 获得当前字符串的长度
            //通过textField.text获得当前字符串，但是少最后一位
            //加上String ，正好为当前字符串
        NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@%@",textField.text,string];
        
        //5.判断是否是第一次在该文本框输入文字
        if (!self.first) {  //第一次输入文字，创建缓存数据，并存入字典，然后存入数组
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               str1, @(indexPath.row),nil];
            [self.array addObject:mutableDic];
            self.first = YES;
        }
        else { //当不是第一个字符的时候，不需要重新创建字典
            for (int i = 0; i < self.array.count; ++i) {
                NSMutableDictionary *mutabDic = self.array[i];
                if (mutabDic[@(indexPath.row)] != nil) {
                    mutabDic[@(indexPath.row)] = str1;
                }
            }
        }
        
    }
    
    return YES;
}

//当点击clear button 的时候，清楚该文本框缓存数据
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    //1.获取当前文本框所属cell的indexPath.row
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    //2.找到缓存数据，并删除
    for (int i = 0; i < self.array.count; ++i) {
        NSMutableDictionary *mutabDic = self.array[i];
        if (mutabDic[@(indexPath.row)] != nil) {
            mutabDic[@(indexPath.row)] = @"";
        }
    }
    
    return YES;
}

@end
