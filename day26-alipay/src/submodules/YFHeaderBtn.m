//
//  YFHeaderBtn.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFHeaderBtn.h"

@implementation YFHeaderBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return (CGRect){self.w*.2,self.h*.15,self.w*.6,self.h*.5};
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return (CGRect){0,self.h*.65,self.w,self.h*.3};
}


-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self setTitle:_dict[@"title"] forState:UIControlStateNormal];
    [self setImage:img(_dict[@"img"]) forState:UIControlStateNormal];
}


@end
