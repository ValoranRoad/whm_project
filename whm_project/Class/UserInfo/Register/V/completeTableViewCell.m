//
//  completeTableViewCell.m
//  小胖的demo
//
//  Created by YiTu8 on 2016/10/19.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "completeTableViewCell.h"

@implementation completeTableViewCell



-(UIImageView *)headImage
{
    if (_headImage == nil)
    {
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12.5, 60, 25)];
        [self.contentView addSubview:_headImage];
    }
    return _headImage;
}



-(UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame), 12.5, 150, 25)];
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLab];
        
    }
    return _titleLab;
}




- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
