//
//  YFSettingTV.h
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFSettingTV : UITableView

@property (nonatomic,strong)NSMutableArray *datas;
-(void)appendDatas:(NSArray *)datas;
@end
