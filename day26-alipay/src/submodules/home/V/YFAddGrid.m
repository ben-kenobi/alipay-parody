//
//  YFAddGrid.m
//  day26-alipay
//
//  Created by apple on 15/10/29.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFAddGrid.h"
#import "YFGridItem.h"
#import "YFBasicVC.h"
#import "YFPref.h"

#define COL 4


@interface YFAddGrid ()
@property (nonatomic,strong)NSMutableArray *ary;
@property (nonatomic,weak)YFGridItem *curv;
@property (nonatomic,assign)BOOL change;
@property (nonatomic,assign)YFGridItem *last;
@property  (nonatomic,strong)NSMutableArray *rowary;
@property (nonatomic,strong)NSMutableArray *colary;
@end

@implementation YFAddGrid


-(void)setDatas:(NSMutableArray *)datas{
    _datas =[NSMutableArray array];
    [_datas addObjectsFromArray:datas];
    [self updateUI];
    
}



-(void)updateUI{
    NSInteger delta=self.datas.count-self.ary.count;
    if(delta>0){
        for(NSInteger i=self.ary.count;i<self.datas.count;i++){
            YFGridItem *grid=[[YFGridItem alloc] init];
            [self.ary addObject:grid];
            [self addSubview:grid];
            [grid setDelImg:img(@"app_add")];
            [grid setDelegateBlock:^(id sender, int flag,YFGridItem *item) {
                YFBasicVC *vc;
                UILongPressGestureRecognizer *lp;
                
                switch(flag){
                    case 0:
                        lp=sender;
                        if (lp.state==1) {
                            lp.view.transform=CGAffineTransformMakeScale(1.1, 1.1);
                            [self insertSubview:lp.view aboveSubview:self.last?self.last:self.ary.lastObject];
                            self.last=lp.view;
                            [self.curv setHideDel:YES];
                            self.curv=(YFGridItem *)lp.view;
                            item.hideDel=NO;
                        }else if(lp.state==2){
                            CGPoint p=[lp locationInView:self];
                            lp.view.center=p;
                            [self.ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                UIView *v=obj;
                                if(v!=lp.view&&CGRectContainsPoint(v.frame, p)){
                                    _change=1;
                                    id obj=[self.datas objectAtIndex:[self.ary indexOfObject:lp.view]];
                                    [self.datas removeObject:obj];
                                    [self.datas insertObject:obj atIndex:idx];
                                    [self.ary removeObject:lp.view];
                                    [self.ary insertObject:lp.view atIndex:idx];
                                    [self layout:YES];
                                    *stop=YES;
                                }
                            }];
                        }else if(lp.state==3){
                            if(_change)
                                _curv.hideDel=YES;
                            lp.view.transform=CGAffineTransformIdentity;
                            self.change=0;
                            [self layout:YES];
                        }
                        break;
                    case 1:
                        [item removeFromSuperview];
                        [YFPref addItem:item.dict fromItems:self.datas];
                        self.last=0;
                        [self.ary removeObject:item];
                        [self layout:YES];
                        break;
                    case 2:
                        if(self.curv&&!self.curv.hideDel){
                            self.curv.hideDel=YES;
                            return ;
                        }
                        break;
                }
            }];
        }
    }else{
        for(int i=0;i<delta;i++){
            [[self.ary lastObject] removeFromSuperview];
            [self.ary removeLastObject];
        }

    }
    for(int i=0;i<self.ary.count;i++)
        [_ary[i] setDict:self.datas[i]];
    
 
}




-(void)layout:(BOOL)ani{
    __block NSInteger row=-1,col=0;
    CGFloat wid=self.w/COL,hei=wid*1.1;
    if(ani){
        [UIView animateWithDuration:.3 animations:^{
            for(NSInteger i=0;i<self.ary.count;i++){
                row=i/COL,col=i%COL;
                if (self.ary[i]!=self.curv||!_change) {
                    [self.ary[i] setFrame:(CGRect){col*wid,row*hei,wid,hei}];
                }
            }
             self.contentSize=(CGSize){0,[self.ary.lastObject b]};
        }];
       
    }else{
        for(NSInteger i=0;i<self.ary.count;i++){
            row=i/COL,col=i%COL;
          if (self.ary[i]!=self.curv||!_change) {
            [self.ary[i] setFrame:(CGRect){col*wid,row*hei,wid,hei}];
          }
        }
        self.contentSize=(CGSize){0,[self.ary.lastObject b]};
    }
    
    
    
     NSInteger rowdelta=row-self.rowary.count+1;
     NSInteger coldelta=COL-self.colary.count;

    for(NSInteger i=0;i<abs(rowdelta);i++){
        if(rowdelta>0){
            UIView *v= [[UIView alloc] init];
            [v setBackgroundColor:[UIColor lightGrayColor]];
            [self addSubview:v];
            [self.rowary addObject:v];
        }else{
            [[self.rowary lastObject] removeFromSuperview];
            [self.rowary removeLastObject];
        }
    }
    
    for(NSInteger i=0;i<abs(coldelta);i++){
        if(coldelta>0){
            UIView *v= [[UIView alloc] init];
            [v setBackgroundColor:[UIColor lightGrayColor]];
            [self.colary addObject:v];
            [self addSubview:v];
        }else{
            [[self.colary lastObject] removeFromSuperview];
            [self.colary removeLastObject];
        }
    }
    for(NSInteger i=0;i<self.rowary.count;i++){
        [self.rowary[i] setFrame:(CGRect){0,(i+1)*hei,self.w,.4}];
        [self bringSubviewToFront:self.rowary[i]];
    }
    
    for(NSInteger i=0;i<self.colary.count;i++){
        [self.colary[i] setFrame:(CGRect){i*wid,0,.4,hei*(row+1)}];
        [self bringSubviewToFront:self.colary[i]];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(!_done){
        [self layout:NO];
    }
    _done=1;
}



iLazy4Ary(ary, _ary)
iLazy4Ary(rowary, _rowary)
iLazy4Ary(colary, _colary)


@end
