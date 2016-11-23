//
//  HmPhysicalGroupView.m
//  whm_project
//
//  Created by zhaoHm on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmPhysicalGroupView.h"
#import "MacroUtility.h"

@implementation HmPhysicalGroupView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
//    @property (nonatomic, strong) UIImageView *imgHeader;
    self.imgHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    _imgHeader.center = CGPointMake(25 / 2 + 7, self.center.y);
    _imgHeader.image = [UIImage imageNamed:@"p_group"];
    [self addSubview:_imgHeader];
    
//    @property (nonatomic, strong) UILabel *lblName;
    self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgHeader.frame) + 10, self.center.y - 10, kScreenWitdh - CGRectGetMaxX(_imgHeader.frame) - 20 - 25 - 20 - 20, 20)];
    _lblName.text = @"国寿附加瑞鑫提前给付重大疾病保险(2013版)";
    _lblName.font = [UIFont systemFontOfSize:12];
    _lblName.textColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:1];
    [self addSubview:_lblName];
    
//    @property (nonatomic, strong) UIButton *btnDelete;
    self.btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDelete.frame = CGRectMake(CGRectGetMaxX(_lblName.frame) + 10, CGRectGetMinY(_lblName.frame), 20, 20);
    [_btnDelete setBackgroundImage:[UIImage imageNamed:@"p_delete"] forState:UIControlStateNormal];
    [self addSubview:_btnDelete];
    
//    @property (nonatomic, strong) UIImageView *imgPoint;
    self.imgPoint = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_btnDelete.frame) + 10, CGRectGetMinY(_imgHeader.frame), 25, 25)];
    _imgPoint.image = [UIImage imageNamed:@"p_listDown"];
    [self addSubview:_imgPoint];
    
}

@end
