//
//  WHmyMessageTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/10/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyMessageTableViewCell.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width

@implementation WHmyMessageTableViewCell

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(10, 10, kScreenW-20, 30);
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenW * 0.1, 20);
        self.nameLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UILabel *)addressLaber
{
    if (_addressLaber == nil) {
        self.addressLaber = [[UILabel alloc]init];
        self.addressLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+10, CGRectGetMinY(self.nameLaber.frame), kScreenW * 0.2, CGRectGetHeight(self.nameLaber.frame));
        self.addressLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_addressLaber];
    }
    
    return _addressLaber;
    
}

-(UILabel *)statuLaber
{
    if (_statuLaber == nil) {
        self.statuLaber = [[UILabel alloc]init];
        self.statuLaber.frame = CGRectMake(CGRectGetMaxX(self.addressLaber.frame), CGRectGetMinY(self.addressLaber.frame), kScreenW* 0.2, CGRectGetHeight(self.addressLaber.frame));
        self.statuLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_statuLaber];
        
    }
    return _statuLaber;
}


-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(kScreenW * 0.75, CGRectGetMinY(self.statuLaber.frame), kScreenW* 0.2, CGRectGetHeight(self.statuLaber.frame));
        self.timeLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_timeLaber];
        
    }
    
    return _timeLaber;
}

-(void)setModel:(WHgetmessage *)model
{
    _model = model;
    self.titLaber.text = model.message;
    self.nameLaber.text = model.req_name;
    self.statuLaber.text = model.reply_status;
    self.addressLaber.text = model.city_name;
    self.timeLaber.text = model.create_time;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
