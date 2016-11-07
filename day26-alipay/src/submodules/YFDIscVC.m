//
//  YFDIscVC.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFDIscVC.h"
#import "YFSettingTV.h"
#import "YFHeaderBtn.h"

@interface YFDIscVC ()

@property (nonatomic,weak)YFSettingTV *tv;

@end

@implementation YFDIscVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}

-(void)initUI{
    YFSettingTV *tv=[[YFSettingTV alloc] initWithFrame:(CGRect){0,0,self.view.w,self.view.h-150} style:UITableViewStyleGrouped];
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
            if (data) {
            NSArray *ary=[NSJSONSerialization JSONObjectWithData:data options:0 error:0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tv appendDatas:ary];
            });
            }
        }];
    }else{
        [self.tv appendDatas:iRes4ary(self.pname)];
    }
}
-(UIView *)headerView{
    UIView *header=[[UIView alloc] initWithFrame:(CGRect){0,0,self.view.w,110}];
    UIView *view=[[UIView alloc] initWithFrame:(CGRect){0,0,self.view.w,90}];
    [header addSubview:view];
    [view setBackgroundColor:[UIColor whiteColor]];
    NSArray *ary=iRes4ary(@"discHeader.plist");
    CGFloat w=view.w/ary.count;
    __weak typeof(self)wself=self;
    for(NSInteger i=0;i<ary.count;i++){
        YFHeaderBtn *btn=[[YFHeaderBtn alloc] initWithFrame:(CGRect){i*w,0,w,view.h}];
        [btn setDict:ary[i]];
        [view addSubview:btn];
        [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return header;
}
-(void)onBtnClicked:(id)sender{
    if([sender isKindOfClass:[YFHeaderBtn class]]){
        YFHeaderBtn *btn=sender;
        UIViewController *vc=[[NSClassFromString(btn.dict[@"vc"]) alloc] init];
        vc.title=btn.dict[@"title"];
        [UIViewController pushVC:vc];
    }
}



@end
