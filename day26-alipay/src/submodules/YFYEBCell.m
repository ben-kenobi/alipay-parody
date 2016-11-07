//
//  YFYEBCell.m
//  day26-alipay
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFYEBCell.h"

@interface YFYEBCell ()


@property (nonatomic,weak)UILabel *yesLab;
@property (nonatomic,weak)UILabel *totalLab;

@end

@implementation YFYEBCell
+(instancetype)cellWithTv:(UITableView *)tv andDict:(NSDictionary *)dict{
    static NSString *iden=@"yebcelliden";
    YFYEBCell * cell=[tv dequeueReusableCellWithIdentifier:iden];
    if(!cell){
        cell=[[self alloc] initWithStyle:0 reuseIdentifier:iden];
        [cell setSelectionStyle:0];
    }
    [cell setDict:dict];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.color1=[UIColor colorWithRed:1.000 green:0.328 blue:0.287 alpha:1.000];
    self.color2=[UIColor whiteColor];
    
    UILabel *yeslab=[[UILabel alloc] init];
    self.yesLab=yeslab;
    [yeslab setTextColor:self.color2];
    [yeslab setFont:[UIFont boldSystemFontOfSize:65]];
    [self addSubview:yeslab];
    [yeslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).multipliedBy(.4).offset(-39);
        make.left.equalTo(@20);
        make.width.equalTo(self.mas_width).offset(-40);
    }];

    
    UILabel *totalLab=[[UILabel alloc] init];
    self.totalLab=totalLab;
    [totalLab setTextColor:self.color1];
    [totalLab setFont:[UIFont systemFontOfSize:47]];
    [self addSubview:totalLab];
    [totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).multipliedBy(.7).offset(-30);
        make.left.equalTo(@35);
        make.width.equalTo(self.mas_width);
    }];
    
    
}



-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    self.datas=dict[@"datas"];
    
    [self updateUI];
}

-(void)updateUI{
    [self setNeedsDisplay];
    
     self.yesLab.text=[NSString stringWithFormat:@"%.2f",[iPref(0) doubleForKey:[NSString stringWithFormat:@"%@_yesInterest",_dict[@"key"]]]];
     self.totalLab.text=[NSString stringWithFormat:@"%.2f",[iPref(0) doubleForKey:[NSString stringWithFormat:@"%@_totalInterest",_dict[@"key"]]]];
    
    [self animateValue:self.yesLab now:[_dict[@"yes"]doubleValue] key:[NSString stringWithFormat:@"%@_yesInterest",_dict[@"key"]]];
    [self animateValue:self.totalLab now:[_dict[@"total"] doubleValue] key:[NSString stringWithFormat:@"%@_totalInterest",_dict[@"key"]]];
    
}
-(void)doTimer:(id)sender{
    NSTimer *timer=sender;
    NSDictionary *dict=[timer userInfo];
    UILabel *lab=dict[@"lab"];
    double gap=[dict[@"gap"] doubleValue];
    double from=[lab.text doubleValue]+(arc4random_uniform(2)+1)*gap;
    double to=[dict[@"to"] doubleValue];
    
    
    
    if(from>=to){
        [timer invalidate];
        lab.text=[NSString stringWithFormat:@"%.2f",to];
    }else{
        lab.text=[NSString stringWithFormat:@"%.2f",from];
    }
    
    
    
}


-(NSString *)randomNum:(int)len fraction:(int)len2{
    static NSString *ary[]={@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"};
    NSMutableString *str=[NSMutableString stringWithCapacity:len+len2+1];
    for(int i=0;i<len;i++){
         [str appendString:ary[arc4random_uniform(10)]];
    }
    if(len2>0){
        [str appendString:@"."];
        for(int i=0;i<len2;i++){
            [str appendString:ary[arc4random_uniform(10)]];
        }
    }
    return str;
}


-(void)animateValue:(UILabel *)lab now:(double)now key:(NSString *)key{
       double former=[lab.text doubleValue];

    if(now-former>.01){
        [iPref(0) setDouble:now forKey:key];
        double gap=(now-former)*.02>.01?(now-former)*.02:.01;
        
        [[NSRunLoop mainRunLoop] addTimer:[NSTimer timerWithTimeInterval:.02 target:self selector:@selector(doTimer:) userInfo:@{@"gap":@(gap),@"lab":lab,@"to":@(now)} repeats:YES] forMode:NSRunLoopCommonModes];
    }
    
}


-(void)drawRect:(CGRect)rect{
    CGFloat h=rect.size.height,w=rect.size.width;
    
    CGContextRef con=UIGraphicsGetCurrentContext();
    CGContextAddRect(con, (CGRect){0,0,w,h*.4});
    [self.color1 setFill];
    CGContextDrawPath(con, 0);
    UIImage *img1= img(@"calendar");
    UIImage *img2=img(@"xiaobao");
    CGFloat pad=20;
    [img1 drawAtPoint:(CGPoint){pad,pad}];
    [@"昨日收益 (元)" drawAtPoint:(CGPoint){pad+img1.size.width+10, pad} withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:self.color2}];
    [img2 drawAtPoint:(CGPoint){w-pad-img2.size.width,pad}];
    
    
    
    CGContextAddRect(con, (CGRect){0,h*.4,w,h*.3});
    [self.color2 setFill];
    CGContextDrawPath(con, 0);
    [@"总金额 (元)" drawAtPoint:(CGPoint){pad,h*.4+pad} withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    
    CGContextAddRect(con, (CGRect){0,h*.7,w,h*.3});
    [[UIColor colorWithRed:0.853 green:0.869 blue:0.903 alpha:1.000]
     setFill];
    CGContextDrawPath(con, 0);
    
    
    NSString *str[4]={@"万分收益 (元)",@"累计收益 (元)",@"近一周收益 (元)",@"近一月收益 (元)"};
    CGPoint pos[4]={{pad,h*.7+pad},{w*.5+pad,h*.7+pad},{pad,h*.83+pad},{w*.5+pad,h*.83+pad}};
    for(int i=0;i<4;i++){
        [str[i] drawAtPoint:pos[i] withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        [self.datas[i] drawAtPoint:(CGPoint){pos[i].x,pos[i].y+25} withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
    
    
    
    
}

@end
