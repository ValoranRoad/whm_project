//
//  WHnearAgentTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnearAgentTableViewCell.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>


@implementation WHnearAgentTableViewCell

-(UIImageView *)myImage
{
    if (_myImage == nil) {
        self.myImage = [[UIImageView alloc]init];
        self.myImage.frame = CGRectMake(10, 10,kScreenWitdh * 0.2 , kScreenWitdh * 0.2);
        self.myImage.layer.masksToBounds = YES;
        self.myImage.layer.cornerRadius = kScreenWitdh * 0.1;
        [self.contentView addSubview:_myImage];
    }
    return _myImage;
}

-(UILabel *)nameLaber
{
    if (_nameLaber == nil) {
        self.nameLaber = [[UILabel alloc]init];
        self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, 10, kScreenWitdh *0.15, 30);
        self.nameLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLaber];
    }
    return _nameLaber;
}

-(UIImageView * )sexImg
{
    if (_sexImg == nil) {
        self.sexImg = [[UIImageView alloc]init];
        self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+2, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
        [self.contentView addSubview:_sexImg];
    }
    return _sexImg;
}

-(UILabel*)ageLaber
{
    if (_ageLaber == nil) {
        self.ageLaber = [[UILabel alloc]init];
        self.ageLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.sexImg.frame), 40, 20);
        self.ageLaber.font = [UIFont systemFontOfSize:13.0];
        self.ageLaber.textColor = [UIColor grayColor];
        [self.contentView addSubview:_ageLaber];
    }
    return _ageLaber;
}

-(UILabel *)professLaber
{
    if (_professLaber == nil) {
        self.professLaber = [[UILabel alloc]init];
        self.professLaber.frame = CGRectMake(CGRectGetMaxX(self.companyLaber.frame)+3, CGRectGetMaxY(self.nameLaber.frame)+10, kScreenWitdh * 0.15, 20);
        self.professLaber.textColor = [UIColor grayColor];
        self.professLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_professLaber];
    }
    return _professLaber;
}
-(UILabel *)companyLaber
{
    if (_companyLaber == nil) {
        self.companyLaber = [[UILabel alloc]init];
        self.companyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+10, kScreenWitdh * 0.15, 20);
        self.companyLaber.textColor = [UIColor grayColor];
        self.companyLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_companyLaber];
    }
    return _companyLaber;
}

-(UILabel *)workLaber
{
    if (_workLaber == nil) {
        self.workLaber = [[UILabel alloc]init];
        self.workLaber.frame = CGRectMake(CGRectGetMaxX(self.professLaber.frame)+3, CGRectGetMinY(self.professLaber.frame), 20, 20);
        self.workLaber.textColor = [UIColor grayColor];
        self.workLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_workLaber];
    }
    return _workLaber;
}

-(UILabel *)areaLaber
{
    if (_areaLaber == nil) {
        self.areaLaber = [[UILabel alloc]init];
        self.areaLaber.frame = CGRectMake(CGRectGetMaxX(self.workLaber.frame)+3, CGRectGetMinY(self.workLaber.frame), kScreenWitdh * 0.1, CGRectGetHeight(self.workLaber.frame));
        self.areaLaber.textColor = [UIColor grayColor];
        self.areaLaber.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:_areaLaber];
    }
    return _areaLaber;
}


-(UIButton *)telBut
{
    if (_telBut == nil) {
        self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.telBut.frame = CGRectMake(kScreenWitdh * 0.85, CGRectGetMidY(self.nameLaber.frame), 40, 40);
        [self.contentView addSubview:_telBut];
        
    }
    return _telBut;
}

-(UIButton *)mesBut
{
    if (_mesBut == nil) {
        self.mesBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.mesBut.frame = CGRectMake(kScreenWitdh * 0.70, CGRectGetMinY(self.telBut.frame), CGRectGetWidth(self.telBut.frame), CGRectGetHeight(self.telBut.frame));
        [self.contentView addSubview:_mesBut];
    }
    return _mesBut;
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
