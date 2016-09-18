//
//  FoldingView.m
//  FoldingCellDemo
//
//  Created by ifilmo on 9/18/16.
//  Copyright © 2016 zhiyuanFan. All rights reserved.
//

#import "FoldingView.h"
#import "DBTool.h"
#import "UIColor+IFMHexColor.h"


#define screenWidth ([UIScreen mainScreen].bounds.size.width)

@interface FoldingView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) UITableView *cityTableView;

@end

@implementation FoldingView

static NSString *cellId = @"cityCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.cityTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.cityTableView.delegate = self;
        self.cityTableView.dataSource = self;
        [self.cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        self.cityTableView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.cityTableView];
    }
    return self;
}

- (void)setProvinceId:(NSString *)provinceId {
    _provinceId = provinceId;
    DBTool *tool = [[DBTool alloc] init];
    NSArray *cityArray = [tool getCityListWithProvinceID:provinceId];
    self.cityArr = [NSMutableArray arrayWithArray:cityArray];
    [self.cityTableView reloadData];
}

#pragma mark - UITableview DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = self.cityArr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithHexString:@"#63BBFF"];
    return cell;
}

@end
