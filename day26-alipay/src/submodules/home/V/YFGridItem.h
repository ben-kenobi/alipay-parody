//
//  YFGridItem.h
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFGridItem : UIView
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,assign)BOOL hideDel;
@property (nonatomic,strong)UIImage *delImg;
@property (nonatomic,copy)void (^delegateBlock)(id sender,int flag,YFGridItem *item);
@end
