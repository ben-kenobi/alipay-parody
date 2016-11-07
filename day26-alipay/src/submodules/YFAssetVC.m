//
//  YFAssetVC.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAssetVC.h"
#import "YFSettingTV.h"
#import "YFAssetHeader.h"
@interface YFAssetVC ()
@property (nonatomic,weak)YFSettingTV *tv;
@end

@implementation YFAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    YFSettingTV *tv=[[YFSettingTV alloc] initWithFrame:(CGRect){0,0,self.view.w,self.tabBarController.tabBar.y} style:UITableViewStyleGrouped];
    self.tv=tv;
    [self.view addSubview:tv];
    [tv setTableHeaderView:[self headerView]];
    [self loadDatas];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tv reloadData];
}

-(void)loadDatas{
    if(!self.pname) return ;
    if([[[self.pname substringWithRange:(NSRange){0,7}] lowercaseString] isEqualToString:@"http://"]){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:iURL(self.pname)] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tv appendDatas:ary];
            });
        }];
    }else{
        [self.tv appendDatas:iRes4ary(self.pname)];
    }
}
-(UIView *)headerView{
    UIView *bg=[[UIView alloc] initWithFrame:(CGRect){0,0,self.view.w,140}];
    YFAssetHeader *header=[[YFAssetHeader alloc] initWithFrame:(CGRect){0,0,self.view.w,122}];
    [bg addSubview:header];
    [header setBackgroundColor:[UIColor whiteColor]];
    [header setIcon:img(@"tmall_icon")];
    [header setArrow:img(@"Tables_Arrow")];
    [header setQr:img(@"ppc_qr")];
    [header setBalance:1823.45];
    [header setCardNum:4];
    [header setName:@"wwwwwww"];
    [header setNum:@"12903819203809"];
    
    
    
    return bg;
}


@end
