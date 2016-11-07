//
//  YFServiceHeader.h
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFServiceHeader : UIView
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,copy)void (^onSearch)(NSString *key);
@end
