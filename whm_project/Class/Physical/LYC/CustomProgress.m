
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress
//@synthesize bgimg,leftimg,presentlab,mylaber,Img1,bgimg1,leftimg1,presentlab1,mylaber1,Img2;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgimg.layer.borderColor = [UIColor clearColor].CGColor;
        _bgimg.layer.borderWidth =  1;
        //bgimg.layer.cornerRadius = 5;
        [_bgimg.layer setMasksToBounds:YES];

        [self addSubview:_bgimg];
        _leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        _leftimg.layer.borderColor = [UIColor clearColor].CGColor;
        _leftimg.layer.borderWidth =  1;
       // leftimg.layer.cornerRadius = 5;
        [_leftimg.layer setMasksToBounds:YES];
        [self addSubview:_leftimg];
        
        _presentlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, self.frame.size.height)];
        _presentlab.textAlignment = NSTextAlignmentCenter;
        
        _presentlab.textColor = [UIColor whiteColor];
        _presentlab.font = [UIFont systemFontOfSize:12];
        [self addSubview:_presentlab];

        _mylaber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.31, 0,CGRectGetWidth([UIScreen mainScreen].bounds)*0.1 , self.frame.size.height)];
        _mylaber.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_mylaber];
        
        _Img1 = [[UIImageView alloc]init];
        _Img1.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 5);
        _Img1.image = [UIImage imageNamed:@"img1"];
        [self addSubview:_Img1];
           
    }
    return self;
}
-(void)setPresent:(int)present title:(NSString *)title labelText:(NSString *)labelText;
{
    //presentlab.text = [NSString stringWithFormat:@"%d/20",present];
    _presentlab.text = title;
    _mylaber.text = labelText;
    _leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*present, self.frame.size.height);
    //
   
  
}
//-(void)setPresent1:(int)present1
//{
//    presentlab.text = @"保费是否全理";
//    mylaber.text = @"8分";
//    leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue1*present1, self.frame.size.height);
//
//}
//
//-(void)setPresent2:(int)present2
//{
//    presentlab.text = @"重大疾病保额";
//    mylaber.text = @"30分";
//
//}
//-(void)setPresent3:(int)present3
//{
//    presentlab.text = @"意外保险保额";
//    mylaber.text = @"70分";
//    
//}
//
//-(void)setPresent4:(int)present4
//{
//    presentlab.text = @"人寿保险保额";
//    mylaber.text = @"18分";
//
//}
//-(void)setPresent5:(int)present5
//{
//    presentlab.text = @"个人缺少保障";
//    mylaber.text = @"3分";
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
