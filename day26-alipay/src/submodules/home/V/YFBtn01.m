//
//  YFBtn01.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFBtn01.h"

@implementation YFBtn01

-(instancetype)init{
    if(self=[super init]){
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat h=self.h*.3,w=h;
    return (CGRect){(self.w-w)*.5,self.h*.3,w,h};
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return (CGRect){0,self.h*.6,self.w,self.h*.3};
}

@end
