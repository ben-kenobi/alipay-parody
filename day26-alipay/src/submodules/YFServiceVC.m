//
//  YFServiceVC.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFServiceVC.h"
#import "YFServiceTV.h"
#import "YFServiceHeader.h"


@interface YFServiceVC ()
@property (nonatomic,weak)YFServiceTV *tv;
@property (nonatomic,weak)YFServiceHeader *header;
@property (nonatomic,strong)UIRefreshControl *ref;
@end

@implementation YFServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    YFServiceTV *tv=[[YFServiceTV alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-64} style:UITableViewStylePlain];
    self.tv=tv;
    [self.view addSubview:tv];
    
    YFServiceHeader *header=[[YFServiceHeader alloc] initWithFrame:(CGRect){0,0,0,60}];
    [header setBackgroundColor:[UIColor lightGrayColor]];
    self.header=header;
    
    [tv setTableHeaderView:header];
    
    self.ref= [[UIRefreshControl alloc] init];
    [self.ref addTarget:self action:@selector(pullDownRefreshOperation) forControlEvents:UIControlEventValueChanged];
    
    [self loadDatas];
}

-(void)loadDatas{
    NSMutableArray *ary=[NSMutableArray array];
    for (int i=0;i<10; i++) {
        [ary addObject:@{@"title":[NSString stringWithFormat: @"title_%02d",i],@"subtitle":[NSString stringWithFormat:@"subtitle_%02d",i],@"img":@"http://localhost/resources/images/minion_01.png",@"vc":@"YFBasicVC"}];
    }
    [self.tv setDatas:ary];
}


- (void)pullDownRefreshOperation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.ref endRefreshing];
    });
}


@end
