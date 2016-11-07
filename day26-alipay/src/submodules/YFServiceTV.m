//
//  YFServiceTV.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFServiceTV.h"
#import "YFServiceCell.h"

static NSString *iden=@"servicecelliden";
@interface YFServiceTV  ()<UITableViewDataSource,UITableViewDelegate>




@end

@implementation YFServiceTV



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

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self=[super initWithFrame:frame style:style]){
        self.delegate=self,self.dataSource=self;
        [self setRowHeight:UITableViewAutomaticDimension];
        [self setEstimatedRowHeight:44];
        [self registerClass:[YFServiceCell class] forCellReuseIdentifier:iden];
//        [self setSeparatorStyle:0];
    }
    return self;
}

-(void)appendDatas:(NSArray *)ary{
    [self.datas addObjectsFromArray:ary];
    [self reloadData];
}

iLazy4Ary(datas, _datas)

@end
