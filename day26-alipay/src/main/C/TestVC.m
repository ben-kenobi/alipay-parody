//
//  TestVC.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "TestVC.h"
#import "Testv.h"


@interface TestVC ()
@property (nonatomic,weak)Testv *tv;
@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    Testv *tv=[[Testv alloc] init];
    [tv setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}


@end
