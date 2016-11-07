//
//  YFAssetHeader.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAssetHeader.h"

@interface YFAssetHeader ()
@property (nonatomic,weak)UIButton *qrbtn;
@property (nonatomic,weak)UIButton *balancebtn;
@property (nonatomic,weak)UIButton *carbtn;

@end

@implementation YFAssetHeader


-(void)drawRect:(CGRect)rect{
    CGFloat pad=10;
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(con, 0, self.h*.7);
    CGContextAddLineToPoint(con, self.w, self.h*.7);
    CGContextMoveToPoint(con, self.w*.5, self.h*.7);
    CGContextAddLineToPoint(con, self.w*.5, self.h);
    CGContextSetRGBStrokeColor(con, .5, .5, .5, 1);
    CGContextSetLineWidth(con, .7);
    CGContextDrawPath(con, 2);
    CGRect iconf={pad,pad,self.h*.7-20,self.h*.7-20};
    [self.icon drawInRect:iconf];
    [self.name drawAtPoint:(CGPoint){CGRectGetMaxX(iconf)+pad*2,pad} withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [self.num drawAtPoint:(CGPoint){CGRectGetMaxX(iconf)+pad*2,CGRectGetMaxY(iconf)-22} withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]}];
    CGFloat qrw=30;
    [self.qr drawInRect:(CGRect){self.w-qrw-40,(self.h*.7-qrw)*.5,qrw,qrw}];

    [@"余额" drawAtPoint:(CGPoint){pad,self.h*.7+(self.h*.3-18)*.5} withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [@"银行卡"  drawAtPoint:(CGPoint){self.w*.5+pad,self.h*.7+(self.h*.3-18)*.5} withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    CGFloat qrw=30,pad=10;
    
    
    UIButton *(^newb)(CGRect)=^(CGRect frame){
        UIButton *b=[[UIButton alloc] initWithFrame:frame];
        [b setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self addSubview:b];
        [b addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [b setTitleEdgeInsets:(UIEdgeInsets){0,0,0,pad}];
        [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        return b;
    };
    
    self.qrbtn=newb((CGRect){self.w-qrw-40,(self.h*.7-qrw)*.5,qrw+20,qrw});
    
    self.balancebtn=newb((CGRect){0,self.h*.7,self.w*.5,self.h*.3});
    
    self.carbtn=newb((CGRect){self.w*.5,self.h*.7,self.w*.5,self.h*.3});

    
}

-(void)setArrow:(UIImage *)arrow{
    _arrow=arrow;
    [self.qrbtn setImage:self.arrow forState:UIControlStateNormal];
}
-(void)setBalance:(CGFloat)balance{
    _balance=balance;
    [self.balancebtn setTitle:[NSString stringWithFormat:@"%.2f",balance] forState:UIControlStateNormal];
    
}
-(void)setCardNum:(NSInteger)cardNum{
    _cardNum=cardNum;
    [self.carbtn setTitle: [ NSString stringWithFormat:@"%ld张",cardNum ] forState:UIControlStateNormal];
  
}

-(void)onBtnClicked:(id)sender{
    if(sender==self.qrbtn){
        
    }else if(sender==self.balancebtn){
        
    }else if(sender==self.carbtn){
        
    }
}





@end
