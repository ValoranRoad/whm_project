//
//  WHreplymessage.m
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHreplymessage.h"
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#import "UIColor+Hex.h"
@implementation WHreplymessage
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self setUI ];
    }
    
    return self;
    
}

-(void)setUI
{
    self.mesLaber = [[UILabel alloc]init];
    self.mesLaber.frame = CGRectMake(10, 10, 40, 30);
    self.mesLaber.text = @"留言";
    self.mesLaber.backgroundColor = [UIColor orangeColor];
    [self addSubview:_mesLaber];
    //
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMinX(self.mesLaber.frame), CGRectGetMaxY(self.mesLaber.frame)+10, kScreenW-20, 30);
    [self addSubview:_titLaber];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenW * 0.1, 20);
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_nameLaber];
    
    //
    self.addressLaber = [[UILabel alloc]init];
    self.addressLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+10, CGRectGetMinY(self.nameLaber.frame), kScreenW * 0.2, CGRectGetHeight(self.nameLaber.frame));
    self.addressLaber.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_addressLaber];
    //
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(kScreenW * 0.75, CGRectGetMinY(self.addressLaber.frame), kScreenW* 0.2, CGRectGetHeight(self.addressLaber.frame));
    self.timeLaber.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_timeLaber];
    
    //
    self.lineView = [[UIView alloc]init];
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.nameLaber.frame)+5, kScreenW, 1);
    self.lineView.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self addSubview:_lineView];
    
    //
    
    self.replyLaber = [[UILabel alloc]init];
    self.replyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.lineView.frame)+5, 40, 30);
    self.replyLaber.text = @"回复";
    self.replyLaber.backgroundColor = [UIColor greenColor];
    [self addSubview:_replyLaber];
    
    //
    
    self.delBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.delBut.frame = CGRectMake(CGRectGetMinX(self.timeLaber.frame), CGRectGetMinY(self.replyLaber.frame), 30, 30);
    [self.delBut setTitle:@"删除" forState:(UIControlStateNormal)];
    [self addSubview:_delBut];
    
    
    //
    self.contentLaber  = [[UILabel alloc]init];
    self.contentLaber.frame = CGRectMake(10, CGRectGetMaxY(self.replyLaber.frame)+10, kScreenW-20, 30);
    
    self.contentLaber.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_contentLaber];
    
    //
    
    self.repTitLaber = [[UILabel alloc]init];
    self.repTitLaber.frame = CGRectMake(10, CGRectGetMaxY(self.contentLaber.frame)+10, kScreenW*0.2, 30);
    self.repTitLaber.text = @"内容回复";
    [self addSubview:_repTitLaber];
    //
    self.myTextView = [[UITextView alloc]init];
    self.myTextView.frame = CGRectMake(10, CGRectGetMaxY(self.repTitLaber.frame)+10, kScreenW-20, 30);
    [self.myTextView setFont:[UIFont systemFontOfSize:15]];
    [self.myTextView.layer setBorderWidth:1.0f];
    self.myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    self.myTextView.text = @"请输入你要回复的留言内容";
    
    [self addSubview:_myTextView];
    
    //
    self.repBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.repBut.frame = CGRectMake(30, CGRectGetMaxY(self.myTextView.frame)+20, kScreenW-60, CGRectGetHeight(self.titLaber.frame)*1.2);
    [self.repBut setTitle:@"立即回复" forState:(UIControlStateNormal)];
    
    self.repBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.repBut.layer.shadowOpacity = 0.8;
    self.repBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    [self.repBut setTintColor:[UIColor whiteColor]];
    self.repBut.layer.cornerRadius = 20.0;
    [self addSubview:_repBut];
    
}




@end
