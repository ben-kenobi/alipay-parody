//
//  YFGridV.h
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YFGridVDele;

@interface YFGridV : UIScrollView

@property (nonatomic,weak)id<YFGridVDele> dele;
@property (nonatomic,strong)NSArray *ads;
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,assign)BOOL done;
@end



@protocol YFGridVDele<NSObject>



@end