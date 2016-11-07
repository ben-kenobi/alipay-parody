//
//  YFSV.h
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFSV : UIScrollView

@property (nonatomic,copy)void (^touchBlock)(NSInteger);

@end
