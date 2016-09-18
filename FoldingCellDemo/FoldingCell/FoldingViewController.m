//
//  FoldingViewController.m
//  FoldingCellDemo
//
//  Created by ifilmo on 9/18/16.
//  Copyright © 2016 zhiyuanFan. All rights reserved.
//

#import "FoldingViewController.h"
#import "DBTool.h"
#import "ProvinceItem.h"
#import "FoldingView.h"

#define screenWidth ([UIScreen mainScreen].bounds.size.width)

@interface FoldingViewController ()

@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation FoldingViewController

static NSString *cellId = @"foldingCell";

- (NSMutableArray *)provinceArr {
    
    DBTool *tool = [[DBTool alloc] init];
    NSArray *tempArr = [tool getProvinceList];
    
    if (!_provinceArr) {
        if (tempArr) {
            _provinceArr = [NSMutableArray arrayWithArray:tempArr];
        } else {
            _provinceArr = [NSMutableArray array];
        }
    }
    return _provinceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.provinceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProvinceItem *item = self.provinceArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    label.text = item.ProvinceName;
    [cell.contentView addSubview:label];
    
    FoldingView *openView = [[FoldingView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, 160)];
    openView.hidden = !([self.indexPath isEqual:indexPath]);
    openView.provinceId = item.ProvinceID;
    [cell.contentView addSubview:openView];
    
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.indexPath isEqual:indexPath]) {
        return 200;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showCithWithIndexPath:indexPath];
}

#pragma mark -- method

-(void)showCithWithIndexPath:(NSIndexPath *)indexPath {
    
    if (self.indexPath && [self.indexPath isEqual:indexPath]) {
        //页面收回
        self.indexPath = nil;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        if (self.indexPath) {
            //切换cell
            NSIndexPath * oldIndexPath = [NSIndexPath indexPathForRow:self.indexPath.row inSection:self.indexPath.section];
            
            self.indexPath = indexPath;
            [self.tableView reloadRowsAtIndexPaths:@[oldIndexPath,indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        } else {
            //页面弹出
            self.indexPath = indexPath;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}



@end
