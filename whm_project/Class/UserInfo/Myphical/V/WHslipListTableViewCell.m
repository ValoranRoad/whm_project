//
//  WHslipListTableViewCell.m
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHslipListTableViewCell.h"
#import "MacroUtility.h"

@implementation WHslipListTableViewCell

-(UIButton *)selectBut
{
    if (_selectBut == nil) {
        self.selectBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.selectBut.frame = CGRectMake(10, 30, 30, 30);
        [self.contentView addSubview:_selectBut];
    
    }
    return _selectBut;
}

-(UILabel *)titLaber
{
    if (_titLaber == nil) {
        self.titLaber = [[UILabel alloc]init];
        self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.selectBut.frame)+5, 10, kScreenWitdh * 0.6, 30);
        self.titLaber.textColor = [UIColor grayColor];
        self.titLaber.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_titLaber];
    }
    return _titLaber;
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
