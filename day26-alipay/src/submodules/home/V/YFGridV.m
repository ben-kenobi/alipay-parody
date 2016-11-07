//
//  YFGridV.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFGridV.h"
#import "YFGridItem.h"
#import "objc/runtime.h"
#import "YFAddMoreVC.h"
#import "YFBasicVC.h"
#import "YFPref.h"
#import "UIImageView+WebCache.h"
#import "YFSV.h"
#import "TAPageControl.h"

#define COL 4
#define ROW 3

@interface YFGridV ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *ary;
@property (nonatomic,weak)YFGridItem *curv;
@property (nonatomic,assign)BOOL change;
@property (nonatomic,strong)UIButton *more;
@property  (nonatomic,strong)NSMutableArray *rowary;
@property (nonatomic,strong)NSMutableArray *colary;

@property (nonatomic,weak)UIView *adbanner;

//@property (nonatomic,weak)UIPageControl *page;
@property (nonatomic,weak)TAPageControl *pc;

@property (nonatomic,weak)YFSV *sv;
@property (nonatomic,strong)NSTimer *timer;


@end
@implementation YFGridV

-(instancetype)init{
    if(self=[super init]){
        [self updateUI];
    }
    return self;
}

-(void)setDatas:(NSMutableArray *)datas{
    _datas =[NSMutableArray array];
    [_datas addObjectsFromArray:datas];
    [self updateUI];
    
}



-(void)updateUI{
    if(self.more)
        [self.ary removeObject:self.more];
    NSInteger delta=self.datas.count-self.ary.count;
    if(delta>0){
        for(NSInteger i=self.ary.count;i<self.datas.count;i++){
            YFGridItem *grid=[[YFGridItem alloc] init];
            [self.ary addObject:grid];
            [self addSubview:grid];
            
            [grid setDelegateBlock:^(id sender, int flag,YFGridItem *item) {
                YFBasicVC *vc;
                UILongPressGestureRecognizer *lp;
                
                switch(flag){
                    case 0:
                        lp=sender;
                        if (lp.state==1) {
                            lp.view.transform=CGAffineTransformMakeScale(1.1, 1.1);
                            [self bringSubviewToFront:lp.view];
                            [self.curv setHideDel:YES];
                            self.curv=(YFGridItem *)lp.view;
                            item.hideDel=NO;
                        }else if(lp.state==2){
                            CGPoint p=[lp locationInView:self];
                            lp.view.center=p;
                            [self.ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                UIView *v=obj;
                                if(v!=lp.view&&CGRectContainsPoint(v.frame, p)&&idx<self.ary.count-1){
                                    _change=1;
                                    id obj=[self.datas objectAtIndex:[self.ary indexOfObject:lp.view]];
                                    [self.datas removeObject:obj];
                                    [self.datas insertObject:obj atIndex:idx];
                                    [self.ary removeObject:lp.view];
                                    [self.ary insertObject:lp.view atIndex:idx];
                                    [self layout:YES ref:NO];
                                    *stop=YES;
                                }
                            }];
                        }else if(lp.state==3){
                            if(_change)
                                _curv.hideDel=YES;
                            lp.view.transform=CGAffineTransformIdentity;
                            self.change=0;
                            [self layout:YES ref:YES];
                        }
                        break;
                    case 1:
                        [item removeFromSuperview];
                        [YFPref delItem:item.dict fromItems:self.datas];
                        [self.ary removeObject:item];
                        [self layout:YES ref:YES];
                        break;
                    case 2:
                        if(self.curv&&!self.curv.hideDel){
                            self.curv.hideDel=YES;
                            return ;
                        }
                        vc=[[YFBasicVC alloc] init];
                        vc.title=item.dict[@"title"];
                        [UIViewController pushVC:vc];
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
    
    if(!self.more){
        UIButton *more=[[UIButton alloc] init];
        [more setImage:img(@"tf_home_more") forState:UIControlStateNormal];
        self.more=more;
        [self addSubview:more];
        [more addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.ary addObject:self.more];
    
    if(!self.adbanner){
        UIView *adbanner=[[UIView alloc] init];
        self.adbanner=adbanner;
        [adbanner setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:adbanner];
        YFSV *sv=[[YFSV alloc] init];
        [sv setBackgroundColor:[UIColor grayColor]];
        [adbanner addSubview:sv];
        [sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerY.equalTo(@0);
            make.height.equalTo(@74);
        }];
        self.sv=sv;
        [sv setBounces:NO];
        [sv setShowsHorizontalScrollIndicator:NO];
        [sv setPagingEnabled:YES];
        [self.sv setTouchBlock:^(NSInteger i){
            if(i==0){
                [self.timer invalidate];
            }else if(i==1){
                [self startTimer];
            }
        }];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [sv addGestureRecognizer:tap];
//        UIPageControl *page=[[UIPageControl alloc] init];
//        self.page=page;
//        [adbanner addSubview:page];
//        [page setPageIndicatorTintColor:[UIColor lightGrayColor]];
//        [page setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
//        [page mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@-5);
//            make.centerX.equalTo(@0);
//        }];
//        [page setUserInteractionEnabled:NO];
        
        TAPageControl *pc=[[TAPageControl alloc] init];
        pc.dotSize=(CGSize){7,7};
        pc.dotColor=[UIColor whiteColor];
        self.pc=pc;
        [adbanner addSubview:pc];
        [pc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-20);
            make.centerX.equalTo(@0);
        }];
        
        sv.delegate=self;
    }
}

-(void)onTap:(UITapGestureRecognizer *)tap{
    CGPoint p=[tap locationInView:self.sv];
    int idx=(int)(p.x/self.sv.w);
    YFBasicVC *vc=[[YFBasicVC alloc] init];
    vc.title=[NSString stringWithFormat:@"广告_%02d",idx];
    [UIViewController pushVC:vc];
}
-(void)onBtnClicked:(id)sender{
    if(sender==self.more){
        YFAddMoreVC *more=[[YFAddMoreVC alloc] init];
        more.title=@"add more";
        [UIViewController pushVC:more];
    }
}



-(void)layout:(BOOL)ani ref:(BOOL)ref{
    __block NSInteger row=0,col=0;
    CGFloat wid=self.w/COL,hei=wid*1.1;
    
    if(ani){
        [UIView animateWithDuration:.3 animations:^{
            for(NSInteger i=0;i<self.ary.count;i++){
                row=i/COL,col=i%COL;
                if(row>=ROW)row+=1;
                if (self.ary[i]!=self.curv||!_change) {
                    [self.ary[i] setFrame:(CGRect){col*wid,row*hei,wid,hei}];
                }
            }
             self.contentSize=(CGSize){0,[self.ary.lastObject b]};
        }];
        
    }else{
        for(NSInteger i=0;i<self.ary.count;i++){
            row=i/COL,col=i%COL;
            if(row>=ROW)row+=1;
            if (self.ary[i]!=self.curv||!_change) {
                [self.ary[i] setFrame:(CGRect){col*wid,row*hei,wid,hei}];
            }
        }
         self.contentSize=(CGSize){0,[self.ary.lastObject b]};
    }
   
    
    if(!ref)return ;
    self.adbanner.frame=(CGRect){0,ROW*hei,self.w,hei};
    
    row=row<ROW-1?(ROW-1):row;
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
    [self bringSubviewToFront:self.adbanner];
}

-(void)setAds:(NSArray *)ads{
    _ads=ads;
    [self updateAds];
    [self startTimer];
}

-(void)startTimer{
    [self.timer invalidate];
    self.timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(doTimer:) userInfo:0 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
-(void)doTimer:(id)sender{
   
        CGPoint p=self.sv.contentOffset;
        p.x+=self.sv.w;
        if(p.x==self.sv.contentSize.width)
            p.x=0;
    [UIView animateWithDuration:p.x?.5:0 animations:^{
        [self.sv setContentOffset:p];
    } completion:^(BOOL finished) {
       [self.pc setCurrentPage:self.sv.contentOffset.x/self.sv.w];
    }];

}
-(void)updateAds{
    
    [self.pc setNumberOfPages:self.ads.count];
    [self.pc setCurrentPage:0];
    [[self.sv subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.sv setContentOffset:(CGPoint){0,0}];
    
    UIImageView *lastiv=0;
    for(NSInteger i=0;i<self.ads.count;i++){
        UIImageView *iv=[[UIImageView alloc]init];
        [self.sv addSubview:iv];
        [iv setBackgroundColor:[UIColor randomColor]];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastiv?lastiv.mas_right:@0);
            make.top.equalTo(@0);
            make.height.equalTo(self.sv);
            make.width.equalTo(self.sv);
        }];
        lastiv=iv ;
//        [iv sd_setImageWithURL:iURL(_ads[i][@"image"]) placeholderImage:0 options:0 progress:0 completed:0];
        [iv sd_setImageWithURL:iURL(_ads[i]) placeholderImage:0 options:0 progress:0 completed:0];
    }
    [lastiv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        
    }];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self.pc setCurrentPage:scrollView.contentOffset.x/scrollView.w];
    [self startTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if(!_done){
        [self layout:NO ref:YES];
    }
    _done=1;
}


iLazy4Ary(ary, _ary)

iLazy4Ary(rowary, _rowary)
iLazy4Ary(colary, _colary)
@end
