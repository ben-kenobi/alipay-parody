//
//  YFGridItem.m
//  day26-alipay
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFGridItem.h"
#import "YFBtn01.h"

@interface YFGridItem ()
@property (nonatomic,weak)YFBtn01 *btn;
@property (nonatomic,weak)UIButton *del;

@end

@implementation YFGridItem

-(instancetype)init{
    if(self=[super init]){
        [self initUI];
    }
    return self;
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}
-(void)updateUI{
    [self.btn setTitle:_dict[@"title"] forState:UIControlStateNormal];
    [self.btn setImage:img(_dict[@"img"]) forState:UIControlStateNormal];
}



-(void)initUI{
    [self setBackgroundColor:[UIColor whiteColor]];
    YFBtn01 *btn=[[YFBtn01 alloc] init];
    [self addSubview:btn];
    self.btn=btn;
    
    UIButton *del=[[UIButton alloc] init];
    [del setImage:img(@"Home_delete_icon") forState:UIControlStateNormal];
    [self addSubview:del];
    del.hidden=YES;
    self.del=del;
    
    [btn addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [del addTarget:self action:@selector(onBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.left.equalTo(self);
    }];
    [del mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(@10);
    }];
    
    UILongPressGestureRecognizer *lp=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onBtnClicked:)];
    [self addGestureRecognizer:lp];
    
}
-(void)setHideDel:(BOOL)hideDel{
    self.del.hidden=hideDel;
    _hideDel=hideDel;
}
-(void)setDelImg:(UIImage *)delImg{
    _delImg=delImg;
    [self.del setImage:delImg forState:UIControlStateNormal];
}


-(void)onBtnClicked:(id)sender{
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]]){
        if(self.delegateBlock)
            self.delegateBlock(sender,0,self);
    }else if(sender==self.del){
        if(self.delegateBlock)
            self.delegateBlock(sender,1,self);
    }else if(sender==self.btn){
        if(self.delegateBlock)
            self.delegateBlock(sender,2,self);
    }
}


@end
