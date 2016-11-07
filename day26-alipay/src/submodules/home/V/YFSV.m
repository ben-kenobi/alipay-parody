//
//  YFSV.m
//  day26-alipay
//
//  Created by apple on 15/11/3.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFSV.h"

@implementation YFSV

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    if(self.touchBlock){
        self.touchBlock(0);
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.touchBlock){
        self.touchBlock(1);
    }

}
@end
