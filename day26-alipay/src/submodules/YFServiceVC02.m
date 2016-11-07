//
//  YFServiceVC02.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFServiceVC02.h"
#import "YFServiceCell.h"
#import "YFServiceHeader.h"
#import "objc/runtime.h"

static NSString *iden=@"servicecelliden";
@interface YFServiceVC02 ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableArray *orinDatas;
@property (nonatomic,weak)YFServiceHeader *header;
@property (nonatomic,copy)NSString *key;
@end

@implementation YFServiceVC02
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:44];
    [self.tableView registerClass:[YFServiceCell class] forCellReuseIdentifier:iden];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    objc_setAssociatedObject(iApp, iVCKey, self, OBJC_ASSOCIATION_ASSIGN);
    [self.tableView reloadData];
}

-(void)initUI{
    
    
    YFServiceHeader *header=[[YFServiceHeader alloc] initWithFrame:(CGRect){0,0,0,55}];
    [header setBackgroundColor:[UIColor lightGrayColor]];
    header.dict=@{@"ph":@"请输入..."};
    self.header=header;
    [self.header setOnSearch:^(NSString * key) {
        self.key=key;
    }];
    [self.tableView setTableHeaderView:header];
    self.refreshControl= [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor randomColor]];
    [self.refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self loadDatas];
}

-(void)loadDatas{
    NSMutableArray *ary=[NSMutableArray array];
    for (int i=0;i<10; i++) {
        [ary addObject:@{@"title":[NSString stringWithFormat: @"title_%02d",i],@"subtitle":[NSString stringWithFormat:@"subtitle_%02d",i],@"img":@"http://localhost/resources/images/minion_01.png",@"vc":@"YFBasicVC"}];
    }
    [self appendDatas:ary];
}


- (void)onRefresh:(id)sender{
    dispatch_after(dispatch_time(0, .5e9), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YFServiceCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    NSDictionary *dict=self.datas[indexPath.row];
    [cell setDict:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[self datas][indexPath.row];
    if(dict[@"vc"]){
        Class clz=NSClassFromString(dict[@"vc"]);
        UIViewController * obj=[[clz alloc] init];
        SEL sel=NSSelectorFromString(@"setPname:");
        if(obj){
            if([obj respondsToSelector:sel])
                [obj performSelector:sel withObject:dict[@"pname"]];
            obj.title=dict[@"title"];
            [UIViewController pushVC:obj];
        }
    }else if(dict[@"sel"]){
        SEL selec=NSSelectorFromString(dict[@"sel"]);
        if([self respondsToSelector:selec])
            [self performSelector:selec withObject:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.separatorInset = insets;
    [cell setLayoutMargins:insets];
    [cell setPreservesSuperviewLayoutMargins:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.header endEditing:YES];
}

-(void)appendDatas:(NSArray *)ary{
    [self.orinDatas addObjectsFromArray:ary];

    [self setKey:self.key];
}
-(void)setKey:(NSString *)key{
    _key=key;
    [self.datas removeAllObjects];
    for (NSDictionary* dict in self.orinDatas) {
        [self screenDict:dict];
    }
    [self.tableView reloadData];
}

-(void)screenDict:(NSDictionary *)dict{
    if(!self.key||!self.key.length||[dict[@"title"] containsString:self.key])
        [self.datas addObject:dict];
}

iLazy4Ary(orinDatas, _orinDatas)
iLazy4Ary(datas, _datas)
@end
