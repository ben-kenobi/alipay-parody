//
//  YFPref.h
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFPref : NSObject
+(NSArray *)itemCache;
+(NSArray *)mainGridItems;
+(void)saveMainGridItems:(NSArray *)datas;

+(NSArray *)moreGridItems;
+(void)saveMoreItems:(NSArray *)datas;

+(void)delItem:(NSDictionary *)dict fromItems:(NSMutableArray *)items ;
+(void)addItem:(NSDictionary *)dict fromItems:(NSMutableArray *)items ;
@end
