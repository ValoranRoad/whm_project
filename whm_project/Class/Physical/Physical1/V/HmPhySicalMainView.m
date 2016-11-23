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
