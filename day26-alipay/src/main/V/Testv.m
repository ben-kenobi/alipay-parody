//
//  Testv.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "Testv.h"

@implementation Testv

-(void)drawRect:(CGRect)rect{
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGFloat cx=100,cy=100;
    CGContextTranslateCTM(con, cx, cy);
    CGContextRotateCTM(con, M_PI_4);
     CGContextTranslateCTM(con, -cx, -cy);
    CGContextAddRect(con, (CGRect){50,50,100,100});
    
   
    CGContextDrawPath(con,0);
}

@end
