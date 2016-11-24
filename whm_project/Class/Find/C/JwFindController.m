//
//  JwFindController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwFindController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
@interface JwFindController ()
@property(nonatomic,strong)UIView * myview;
@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)UIView * blackView;
@property(nonatomic,strong)UIImageView * moonImg;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UIImageView * cityImg;
@property(nonatomic,strong)UIImageView * findImg;



@end

@implementation JwFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}


-(void)setUI
{
    
    self.view .backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    self.myview = [[UIView alloc]init];
    self.myview.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight * 0.4 );
    self.myview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"findblack"]];
    [self.view addSubview:_myview];
    
    self.logoImg = [[UIImageView alloc]init];
    self.logoImg.frame = CGRectMake(kScreenWitdh * 0.3, kScreenWitdh * 0.05, kScreenWitdh * 0.4,kScreenWitdh * 0.4);
    self.logoImg.image = [UIImage imageNamed:@"logoimg"];
    [self.myview addSubview:_logoImg];
    
    self.blackView = [[UIView alloc]init];
    self.blackView.frame = CGRectMake(20, kScreenHeight * 0.3, kScreenWitdh - 40, kScreenHeight * 0.3);
    self.blackView.backgroundColor = [UIColor whiteColor];
    [self.myview addSubview:_blackView];
    //
    self.moonImg = [[UIImageView alloc]init];
    self.moonImg.frame = CGRectMake(30, 20, kScreenWitdh * 0.2, kScreenWitdh * 0.2);
    self.moonImg.image = [UIImage imageNamed:@"Moon"];
    self.moonImg.layer.masksToBounds = YES;
    self.moonImg.layer.cornerRadius = kScreenWitdh * 0.1;

    [self.blackView addSubview:_moonImg];
    //
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake((kScreenWitdh - 40 )*0.4, CGRectGetMinY(self.moonImg.frame), CGRectGetWidth(self.moonImg.frame), CGRectGetHeight(self.moonImg.frame));
    self.mapImg.image = [UIImage imageNamed:@"Map"];
    self.mapImg.layer.masksToBounds = YES;
    self.mapImg.layer.cornerRadius = kScreenWitdh * 0.1;
    [self.blackView addSubview:_mapImg];
    //
    self.cityImg = [[UIImageView alloc]init];
    self.cityImg.frame = CGRectMake((kScreenWitdh - 40 )*0.7,
    CGRectGetMinY(self.moonImg.frame), CGRectGetWidth(self.moonImg.frame), CGRectGetHeight(self.moonImg.frame));
    self.cityImg.image = [UIImage imageNamed:@"City"];
    self.cityImg.layer.masksToBounds = YES;
    self.cityImg.layer.cornerRadius = kScreenWitdh * 0.1;

    [self.blackView addSubview:_cityImg];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
