//
//  YFPref.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFPref.h"
static NSString *griditems=@"gridItemsCache";
static NSString *moreitems=@"moreItemsCache";
@implementation YFPref
+(NSArray *)mainGridItems{
    return [iPref(0) objectForKey:griditems];
}

+(void)saveMainGridItems:(NSArray *)datas{
    [iPref(0) setObject:datas forKey:griditems];
    [iPref(0) synchronize];
}

+(NSArray *)moreGridItems{
    return [iPref(0) objectForKey:moreitems];
}

+(void)saveMoreItems:(NSArray *)datas{
    [iPref(0) setObject:datas forKey:moreitems];
    [iPref(0) synchronize];
}




+(void)delItem:(NSDictionary *)dict fromItems:(NSMutableArray *)items {

    [items removeObject:dict];
    [self saveMainGridItems:items];
    NSMutableArray *mary=[NSMutableArray array];
    [mary addObjectsFromArray:[self moreGridItems]];
    [mary addObject:dict];
    [self saveMoreItems:mary];
}

+(void)addItem:(NSDictionary *)dict fromItems:(NSMutableArray *)items {

    [items removeObject:dict];
    [self saveMoreItems:items];
    NSMutableArray *mary=[NSMutableArray array];
    [mary addObjectsFromArray:[self mainGridItems]];
    [mary addObject:dict];
    [self saveMainGridItems:mary];
}


+(NSArray *)itemCache{
    NSArray *ary=[YFPref mainGridItems];
    if(!ary){
        ary =  @[@{@"title":@"淘宝"   ,@"img" : @"i00"},
                 @{@"title":@"生活缴费" ,@"img": @"i01"},
                 @{@"title":@"教育缴费" ,@"img": @"i02"},
                 @{@"title":@"红包"   ,@"img" : @"i03"},
                 @{@"title":@"物流"   ,@"img" : @"i04"},
                 @{@"title":@"信用卡"  ,@"img" : @"i05"},
                 @{@"title":@"转账"   ,@"img" : @"i06"},
                 @{@"title":@"爱心捐款" ,@"img": @"i07"},
                 @{@"title":@"彩票"   ,@"img" : @"i08"},
                 @{@"title":@"当面付"  ,@"img" :@"i09"},
                 @{@"title":@"余额宝"  ,@"img" :@"i10"},
                 @{@"title":@"AA付款" ,@"img"  : @"i11"},
                 @{@"title":@"国际汇款" ,@"img":@"i12"},
                 @{@"title":@"淘点点"  ,@"img" : @"i13"},
                 @{@"title":@"淘宝电影" ,@"img":@"i14"},
                 @{@"title":@"亲密付"  ,@"img" : @"i15"},
                 @{@"title":@"股市行情" ,@"img":@"i16"},
                 @{@"title":@"汇率换算" ,@"img":@"i17"}
                 ];
        
        [YFPref saveMainGridItems:ary];
    }
    return ary;
    
}
@end
