//
//  YFAddMoreVC.m
//  day26-alipay
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAddMoreVC.h"
#import "YFAddGrid.h"
#import "YFPref.h"

@interface YFAddMoreVC ()
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,weak)YFAddGrid *grid;

@end

@implementation YFAddMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    YFAddGrid *grid=[[YFAddGrid alloc] init];
    [self.view addSubview:grid];
    self.grid=grid;
    [grid setShowsVerticalScrollIndicator:NO];
    [grid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    [grid setDatas:[YFPref moreGridItems]];
}

@end
