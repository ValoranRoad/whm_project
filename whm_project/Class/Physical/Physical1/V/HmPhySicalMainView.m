//
//  HmPhySicalMainView.m
//  whm_project
//
//  Created by zhaoHm on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmPhySicalMainView.h"
#import "MacroUtility.h"

@implementation HmPhySicalMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//         imgHead;
        self.imgHead = [[UIImageView alloc] init];
        [self addSubview:_imgHead];
//        
//         layerLine;
        self.layerLine = [CALayer layer];
        [self.layer addSublayer:_layerLine];
//        
//         imgName;
        self.imgName = [[UIImageView alloc] init];
        [self addSubview:_imgName];
//         lblName;
        self.lblName = [[UILabel alloc] init];
        [self addSubview:_lblName];
//        
//         imgSex;
        self.imgSex = [[UIImageView alloc] init];
        [self addSubview:_imgSex];
//        
//         imgRelationship;
        self.imgRelationship = [[UIImageView alloc] init];
        [self addSubview:_imgRelationship];
//         lblRelationship;
        self.lblRelationship = [[UILabel alloc] init];
        [self addSubview:_lblRelationship];
//        
//         imgDate;
        self.imgDate = [[UIImageView alloc] init];
        [self addSubview:_imgDate];
//         lblDate;
        self.lblDate = [[UILabel alloc] init];
        [self addSubview:_lblDate];
//        
//         imgYearCost;
        self.imgYearCost = [[UIImageView alloc] init];
        [self addSubview:_imgYearCost];
//         lblYearCost;
        self.lblYearCost = [[UILabel alloc] init];
        [self addSubview:_lblYearCost];
//        
//         imgPay;
        self.imgPay = [[UIImageView alloc] init];
        [self addSubview:_imgPay];
//         lblPay;
        self.lblPay = [[UILabel alloc] init];
        [self addSubview:_lblPay];
//        
//         imgOwn;
        self.imgOwn = [[UIImageView alloc] init];
        [self addSubview:_imgOwn];
//         lblOwn;
        self.lblOwn = [[UILabel alloc] init];
        [self addSubview:_lblOwn];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //         imgHead;
    _imgHead.frame = CGRectMake(0, 0, 50, 50);
    _imgHead.center = CGPointMake(28, self.center.y);
    _imgHead.backgroundColor = [UIColor greenColor];
    _imgHead.layer.cornerRadius = 25;
    _imgHead.layer.masksToBounds = YES;
    //
    //         layerLine;
    _layerLine.frame = CGRectMake(self.center.y, CGRectGetMaxX(_imgHead.frame) + 3, kScreenWitdh - CGRectGetMaxX(_imgHead.frame) - 6, 2);
    // @吴豪明 从这开始  给_layerLine设置个颜色好了  继续布局下面的
//    _layerLine.backgroundColor =
    //
    
 
    self.imgName.frame = CGRectMake(CGRectGetMaxX(self.imgHead.frame)+5, 0, 20, 20);
    self.imgName.image = [UIImage imageNamed:@"test_name"];
    self.lblName.frame = CGRectMake(CGRectGetMaxX(self.imgName.frame)+3, CGRectGetMinY(self.imgName.frame), kScreenWitdh*0.15, 20);
    self.lblName.font = [UIFont systemFontOfSize:14.0];
    self.imgSex.frame = CGRectMake(CGRectGetMaxX(self.lblName.frame), CGRectGetMinY(self.lblName.frame), 20, 20);
    
    self.imgRelationship.frame = CGRectMake(CGRectGetMaxX(self.imgSex.frame)+3, CGRectGetMinY(self.lblName.frame), 20, 20);
    self.imgRelationship.image = [UIImage imageNamed:@"test_spouse"];
    
    self.lblRelationship.frame = CGRectMake(CGRectGetMaxX(self.imgRelationship.frame)+3, CGRectGetMinY(self.lblName.frame), kScreenWitdh * 0.15, CGRectGetHeight(self.imgRelationship.frame));
    self.imgDate.frame = CGRectMake(CGRectGetMaxX(self.lblRelationship.frame)+5, CGRectGetMinY(self.lblName.frame), 20, 20);
    self.imgDate.image = [UIImage imageNamed:@"test_date"];
    
    self.lblDate.frame = CGRectMake(CGRectGetMaxX(self.imgDate.frame)+10, CGRectGetMinY(self.lblName.frame), kScreenWitdh * 0.3, CGRectGetHeight(self.lblName.frame));
    self.lblDate.font = [UIFont systemFontOfSize:14.0];
    
    self.imgYearCost.frame = CGRectMake(CGRectGetMinX(self.imgName.frame), CGRectGetMaxY(self.imgName.frame)+5, 20, 20);
    self.imgYearCost.image = [UIImage imageNamed:@"test_year"];
    self.lblYearCost.frame = CGRectMake(CGRectGetMinX(self.lblName.frame), CGRectGetMinY(self.imgYearCost.frame), kScreenWitdh* 0.15, CGRectGetHeight(self.imgYearCost.frame));
    self.lblYearCost.font = [UIFont systemFontOfSize:12.0];
    
    self.imgPay.frame = CGRectMake(CGRectGetMinX(self.imgRelationship.frame), CGRectGetMinY(self.imgYearCost.frame), 20, 20);
    self.imgPay.image = [UIImage imageNamed:@"test_money"];
    self.lblPay.frame = CGRectMake(CGRectGetMinX(self.lblRelationship.frame), CGRectGetMinY(self.lblRelationship.frame), CGRectGetWidth(self.lblRelationship.frame), CGRectGetHeight(self.lblRelationship.frame));
    self.lblPay.font = [UIFont systemFontOfSize:12.0];
    self.imgOwn.frame = CGRectMake(CGRectGetMinX(self.imgDate.frame), CGRectGetMinY(self.imgPay.frame), 20, 20);
    self.imgOwn.image = [UIImage imageNamed:@"test_debts"];
    self.lblOwn.frame = CGRectMake(CGRectGetMinX(self.lblDate.frame), CGRectGetMinY(self.lblPay.frame), CGRectGetWidth(self.lblDate.frame), CGRectGetHeight(self.lblDate.frame));
    
    
    
    //         imgName;
    //         lblName;
    //
    //         imgSex;
    //
    //         imgRelationship;
    //         lblRelationship;
    //
    //         imgDate;
    //         lblDate;
    //
    //         imgYearCost;
    //         lblYearCost;
    //
    //         imgPay;
    //         lblPay;
    //
    //         imgOwn;
    //         lblOwn;
}

@end
