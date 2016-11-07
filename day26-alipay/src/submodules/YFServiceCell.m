//
//  YFServiceCell.m
//  day26-alipay
//
//  Created by apple on 15/11/4.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "YFServiceCell.h"
#import "UIImageView+WebCache.h"

@interface YFServiceCell ()
@property (nonatomic,weak)UILabel *title;
@property (nonatomic,weak)UILabel *subtitle;
@property  (nonatomic,weak)UIImageView *iv;
@end


@implementation YFServiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UILabel *title=[[UILabel alloc] init];
    UILabel *subtitle=[[UILabel alloc] init];
    subtitle.textColor=[UIColor grayColor] ;
    subtitle.font=[UIFont systemFontOfSize:13];
    UIImageView *iv=[[UIImageView alloc] init];
    [title setNumberOfLines:0];
    [subtitle setNumberOfLines:0];
    self.subtitle=subtitle;
    self.title=title;
    self.iv=iv;
    [iv.layer setMasksToBounds:YES];
    [iv.layer setCornerRadius:4];
    
    [self.contentView addSubview:title];
    [self.contentView addSubview:subtitle];
    [self.contentView addSubview:iv];
    
    CGFloat pad=10;
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(pad));
        make.width.height.equalTo(@80);
        make.bottom.lessThanOrEqualTo(@(-pad));
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iv.mas_right).offset(15);
        make.right.equalTo(@-15);
        make.top.equalTo(@(pad));
        make.bottom.equalTo(self.contentView.mas_centerY);
    }];
    [subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(title);
        make.top.equalTo(self.contentView.mas_centerY);
        make.bottom.equalTo(@(-pad));
    }];
    
}
-(void)setDict:(NSDictionary *)dict{
    _dict=dict;
    [self updateUI];
}

-(void)updateUI{
    self.title.text=_dict[@"title"];
    self.subtitle.text=_dict[@"subtitle"];
    [self.iv sd_setImageWithURL:iURL(_dict[@"img"]) placeholderImage:0 options:0 progress:0 completed:0];
}

//-(void)drawRect:(CGRect)rect{
//    [[UIColor orangeColor] setStroke];
//    CGContextRef con=UIGraphicsGetCurrentContext();
//    CGPoint ps[]={{0,self.h-.5},{self.w,self.h-.5}};
//    CGContextSetLineWidth(con, .5);
//    CGContextAddLines(con,ps , 2);
//    CGContextDrawPath(con, 2);
//}
@end
