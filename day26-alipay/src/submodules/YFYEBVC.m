//
//  YFYEBVC.m
//  day26-alipay
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFYEBVC.h"
#import "objc/runtime.h"
#import "YFYEBCell.h"

@interface YFYEBVC ()
@property (nonatomic,strong)NSMutableArray *datas;

@end

@implementation YFYEBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     objc_setAssociatedObject(iApp, iVCKey, self, OBJC_ASSOCIATION_ASSIGN);
    [self.tableView reloadData];
}

-(void)initUI{
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor randomColor]];
    [self.refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self.tableView setSeparatorStyle:0];
    [self.tableView setRowHeight:450];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self  loadDatas ];
}

-(void)loadDatas{
    [self appendDatas:@[@{@"datas":@[@"10.3892",@"10.3892",@"10.3892",@"10.3892"],@"yes":@"903.1231",@"total":@"92225.833",@"key":@"a"},
  @{@"datas":@[@"10.3892",@"10.3892",@"10.3892",@"10.3892"],@"yes":@"89182.1231",@"total":@"91283.333",@"key":@"b"},
  @{@"datas":@[@"10.3892",@"10.3892",@"10.3892",@"10.3892"],@"yes":@"89182.1231",@"total":@"91283.333",@"key":@"c"},
  @{@"datas":@[@"10.3892",@"10.3892",@"10.3892",@"10.3892"],@"yes":@"89182.1231",@"total":@"91283.333",@"key":@"d"},
  @{@"datas":@[@"10.3892",@"10.3892",@"10.3892",@"10.3892"],@"yes":@"89189.9231",@"total":@"91284.333",@"key":@"f"}]];
}
-(void)appendDatas:(NSArray *)ary{
    for(NSDictionary *dict in ary){
        NSMutableDictionary *md=[NSMutableDictionary dictionaryWithDictionary:dict];
        [self.datas addObject:md];
    }
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [YFYEBCell cellWithTv:tableView andDict:self.datas[indexPath.row]];
}


-(void)onRefresh:(id)sender{
    dispatch_after(dispatch_time(0, .5e9), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
    
}
iLazy4Ary(datas, _datas)



@end
