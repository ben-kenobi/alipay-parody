//
//  YFAssetHeader.h
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YFAssetHeader : UIView
@property (nonatomic,strong)UIImage *icon;
@property (nonatomic,strong)UIImage *arrow;
@property (nonatomic,strong)UIImage *qr;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *num;
@property (nonatomic,assign)CGFloat balance;
@property (nonatomic,assign)NSInteger cardNum;
@end
