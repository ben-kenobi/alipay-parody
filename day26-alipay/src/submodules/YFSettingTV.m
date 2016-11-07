//
//  YFSettingTV.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSettingTV.h"
#import "YFSettingCell.h"

@interface YFSettingTV ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation YFSettingTV


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_datas[section][@"mems"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _datas[section][@"header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return _datas[section][@"footer"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[self dictBy:indexPath];
    return [YFSettingCell cellWithTv:tableView dict:dict];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[self dictBy:indexPath];
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self =[super initWithFrame:frame style:style]){
        self.delegate=self;
        self.dataSource=self;
        [self setSeparatorInset:(UIEdgeInsets){0,0,0,0}];
    }
    return self;

}



-(NSDictionary *)dictBy:(NSIndexPath *)path{
    return _datas[path.section][@"mems"][path.row];
}

-(void)appendDatas:(NSArray *)datas{
    [self.datas addObjectsFromArray:datas];
    [self reloadData];
}


iLazy4Ary(datas, _datas)


@end
