//
//  YFHomeVC.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHomeVC.h"
#import "YFScanVC.h"
#import "YFGridV.h"
#import "YFPref.h"

#define kHeaderH 110
@interface YFHomeVC ()<YFGridVDele>
@property (nonatomic,weak)UIView *header;
@property (nonatomic,weak)YFGridV *grid;


@end

@implementation YFHomeVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}


-(void)initUI{
    UIView *header=[[UIView alloc] init];
    header.frame=(CGRect){0,0,self.view.w,kHeaderH};
    header.backgroundColor = [UIColor colorWithRed:(38 / 255.0) green:(42 / 255.0) blue:(59 / 255.0) alpha:1];
    [self.view addSubview:header];
    self.header=header;
    
    UIButton *scan=[[UIButton alloc] initWithFrame:(CGRect){0,0,header.w*.5,header.h}];
    [scan setImage:img(@"home_scan") forState:UIControlStateNormal];
    [scan addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:scan];
    scan.tag=1;
    
    UIButton *pay=[[UIButton alloc] initWithFrame:(CGRect){header.w*.5,0,header.w*.5,header.h}];
    [pay setImage:img(@"home_pay") forState:UIControlStateNormal];
    [header addSubview:pay];
    
    YFGridV *grid=[[YFGridV alloc] init];
    grid.dele=self;
    grid.showsVerticalScrollIndicator=NO;
    [grid setAds:@[@"http://ww3.sinaimg.cn/bmiddle/9d857daagw1er7lgd1bg1j20ci08cdg3.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/763cc1a7jw1esr747i13xj20dw09g0tj.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/67307b53jw1esr4z8pimxj20c809675d.jpg"]];

    [self.view addSubview:grid];
    self.grid=grid;
    [grid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(-50));

    }];
    [self.grid setBackgroundColor:[UIColor whiteColor]];
    [self loadAds];
}

-(void)loadAds{
    NSURLRequest *req=[NSURLRequest requestWithURL:iURL(@"http://localhost/resources/ads.json") cachePolicy:1 timeoutInterval:5];
    [NSURLConnection sendAsynchronousRequest:req queue:[[NSOperationQueue                                           alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.grid setAds:ary];
//        });
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.grid setDatas:[YFPref itemCache]];
    self.grid.done=0;
}

-(void)onBtnClicked:(id)sender{
    NSInteger tag=[sender tag];
    if(tag==1){
        [self.navigationController pushViewController:[[YFScanVC alloc] init] animated:YES];
    }
}
-(void)onItemClicked:(id)sender{
    
}

@end






