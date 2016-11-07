//
//  YFYEBCell.h
//  day26-alipay
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFYEBCell : UITableViewCell

@property (nonatomic,strong)UIColor *color1;
@property (nonatomic,strong)UIColor *color2;

@property (nonatomic,assign)NSDictionary *dict;

@property (nonatomic,assign)NSArray *datas;

+(instancetype)cellWithTv:(UITableView *)tv andDict:(NSDictionary *)dict;

@end
