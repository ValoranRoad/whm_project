//
//  WHrecommentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrecommentTableViewCell.h"
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#import <UIImageView+WebCache.h>


@implementation WHrecommentTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 10, kScreenW * 0.2, kScreenW * 0.2);
        [self.contentView addSubview:_myImage];
    }
    
    return _myImage;
}

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, CGRectGetMinY(self.myImage.frame), kScreenW * 0.6, 30);
        [self.contentView addSubview:_titLaber];
        
    }
    
    return _titLaber;
}

-(UIImageView *)mainImage
{
    if (_mainImage == nil) {
        self.mainImage = [[UIImageView alloc]init];
        self.mainImage.frame = CGRectMake(CGRectGetMaxX(self.titLaber.frame)+10, CGRectGetMinY(self.titLaber.frame), kScreenW *0.1, kScreenW *0.1);
        [self.contentView addSubview:_mainImage];
    }
    
    return _mainImage;
    
}

//

-(UILabel *)yearLaber
{
    if (_yearLaber == nil) {
        self.yearLaber = [[UILabel alloc]init];
        self.yearLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame), CGRectGetMaxY(self.titLaber.frame)+5, kScreenW * 0.3, 20);
        self.yearLaber.font = [UIFont systemFontOfSize:13.0];
        self.yearLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_yearLaber];
    }
    
    return _yearLaber;
}

//
-(UILabel *)statuLaber
{
    if (_statuLaber == nil) {
        self.statuLaber = [[UILabel alloc]init];
        self.statuLaber.frame = CGRectMake(CGRectGetMaxX(self.yearLaber.frame)+10, CGRectGetMinY(self.yearLaber.frame), kScreenW*0.3, CGRectGetHeight(self.yearLaber.frame));
        self.statuLaber.font = [UIFont systemFontOfSize:13.0];
        self.statuLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_statuLaber];
        
    }
    
    return _statuLaber;
    
    
}

-(UILabel *)timeLaber
{
    if (_timeLaber == nil) {
        self.timeLaber = [[UILabel alloc]init];
        self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.yearLaber.frame), CGRectGetMaxY(self.yearLaber.frame)+5, kScreenW * 0.4, CGRectGetHeight(self.yearLaber.frame));
        self.timeLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_timeLaber];
    }
    
    return _timeLaber;
}

-(void)setModel:(WHgetrec *)model
{
    _model = model;
    [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.titLaber.text = model.name;
    self.yearLaber.text = model.limit_age;
    self.statuLaber.text = model.prod_type_code_name;
    
    
    
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