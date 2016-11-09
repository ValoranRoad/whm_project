//
//  WHprosearchTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/9.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHprosearchTableViewCell.h"

@implementation WHprosearchTableViewCell

-(UIImageView *)myImg
{
    if (_myImg == nil) {
        self.myImg = [[UIImageView alloc]init];
        self.myImg.frame = CGRectMake(10, 10, 30, 30);
        self.myImg.layer.masksToBounds = YES;
        self.myImg.layer.cornerRadius = 15;
        [self.contentView addSubview:_myImg];
    }
    return _myImg;
}

-(UILabel *)myLaber
{
    if (_myLaber == nil) {
        self.myLaber = [[UILabel alloc]init];
        self.myLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, CGRectGetMinY(self.myImg.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetHeight(self.myImg.frame));
        [self.contentView addSubview:_myLaber];
        self.myLaber.textColor = [UIColor grayColor];
        self.myLaber.font = [UIFont systemFontOfSize:15.0];
    }
    return _myLaber;
    
}

-(void)setModel:(WHgetproduct *)model
{
    _model = model;
    
    NSInteger stateM = [model.is_main integerValue];
    switch (stateM) {
        case 1:
            self.myImg.image =[UIImage imageNamed:@"p_zhu"];
            break;
        case 2:
            self.myImg.image = [UIImage imageNamed:@"p_huangfu"];
            break;
        case 3:
            self.myImg.image = [UIImage imageNamed:@"p_group"];
            break;
            
        default:
            break;
    }
    
    self.myLaber.text = model.name;

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
