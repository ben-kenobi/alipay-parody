//
//  YFServiceHeader.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFServiceHeader.h"

@interface YFServiceHeader ()
@property (nonatomic,weak)UITextField *tf;
@property (nonatomic,weak)UIView *bg;
@property (nonatomic,weak)UILabel *phlab;
@property (nonatomic,weak)UIView *mdv;


@end

@implementation YFServiceHeader


-(void)initUI{
    
    UIView *bg=[[UIView alloc] init];
    self.bg=bg;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo((UIEdgeInsets){10,15,10,15});
    }];
    [bg setBackgroundColor:[UIColor whiteColor]];
    bg.layer.cornerRadius=10;
    [bg.layer setMasksToBounds:YES];
    bg.layer.borderColor=[[UIColor grayColor] CGColor];
    bg.layer.borderWidth=.7;
    
    
    UITextField *tf=[[UITextField alloc] init];
    self.tf=tf;
    [bg addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(@0);
    }];
    tf.leftViewMode=UITextFieldViewModeAlways;
    tf.clearButtonMode=UITextFieldViewModeAlways;
    
    UIView *mdv=[[UIView alloc] init];
    [tf addSubview:mdv];
    [mdv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    self.mdv=mdv;
    
    UIImageView *iv=[[UIImageView alloc] initWithImage:img(@"search_logo")];
    iv.contentMode=UIViewContentModeScaleAspectFill;
    [mdv addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@5);
    }];
    
    
    UILabel *phlab=[[UILabel alloc] init];
    self.phlab=phlab;
    [mdv addSubview:phlab];
    phlab.textColor=[UIColor grayColor];
    [phlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iv.mas_right).offset(5);
        make.centerY.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange:) name:UITextFieldTextDidChangeNotification object:tf];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange:) name:UITextFieldTextDidEndEditingNotification object:tf];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChange:) name:UITextFieldTextDidBeginEditingNotification object:tf];
    
    
   
    UIView *lefv=[[UIView alloc] initWithFrame:(CGRect){0,0,0,0}];
    tf.leftView=lefv;
    [tf addSubview:lefv];
    [lefv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(iv).offset(10);
    }];
    [self.mdv setUserInteractionEnabled:NO];
    
}

-(void)onChange:(NSNotification *)sender{
    NSString *str=sender.name;
    if([str isEqualToString:UITextFieldTextDidChangeNotification]){
        self.phlab.hidden=self.tf.text.length;
        if(self.onSearch)
            self.onSearch(self.tf.text);

    }else if([str isEqualToString:UITextFieldTextDidBeginEditingNotification]){
        if(!self.tf.text.length)
        [UIView animateWithDuration:.3 animations:^{
            self.mdv.transform=CGAffineTransformMakeTranslation(-self.mdv.x, 0);

        }];
    }else if([str isEqualToString:UITextFieldTextDidEndEditingNotification]){
        if(!self.tf.text.length)
            [UIView animateWithDuration:.3 animations:^{
                self.mdv.transform=CGAffineTransformIdentity;
            }];
    }
}





-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initUI];
    }
    return self;
}

-(void)updateUI{
    self.phlab.text=_dict[@"ph"];
}

-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}


@end
