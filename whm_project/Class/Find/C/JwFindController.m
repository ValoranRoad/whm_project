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
#import "WHorginTableViewController.h"
#import "WHnearAgentTableViewController.h"
@interface JwFindController ()
@property(nonatomic,strong)UIView * myview;
@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)UIView * blackView;
@property(nonatomic,strong)UIImageView * moonImg;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UIImageView * cityImg;
@property(nonatomic,strong)UIImageView * findImg;
@property(nonatomic,strong)UILabel * nearLaber;
@property(nonatomic,strong)UILabel * orgLaber;
@property(nonatomic,strong)UILabel * hosLaber;
@property(nonatomic,strong)UILabel * mesLaber;



@end

@implementation JwFindController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUI];
     self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];
}

-(void)left:(UIBarButtonItem *)sender
{
        self.tabBarController.tabBar.hidden= NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    
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
    self.blackView.frame = CGRectMake(20, kScreenHeight * 0.3, kScreenWitdh - 40, kScreenHeight * 0.4);
    self.blackView.backgroundColor = [UIColor whiteColor];
    [self.myview addSubview:_blackView];
    //
    self.moonImg = [[UIImageView alloc]init];
    self.moonImg.frame = CGRectMake(30, 20, kScreenWitdh * 0.15, kScreenWitdh * 0.15);
    self.moonImg.image = [UIImage imageNamed:@"Moon"];
    self.moonImg.layer.masksToBounds = YES;
    self.moonImg.layer.cornerRadius = kScreenWitdh * 0.075;
    
    [self.blackView addSubview:_moonImg];
    self.nearLaber = [[UILabel alloc]init];
    self.nearLaber.frame = CGRectMake(CGRectGetMinX(self.moonImg.frame), CGRectGetMaxY(self.moonImg.frame)+5, CGRectGetWidth(self.moonImg.frame)*1.2, 25);
    self.nearLaber.text = @"附近代理人";
    //self.nearLaber.textColor = [UIColor grayColor];
    self.nearLaber.font = [UIFont systemFontOfSize:12.0];
    [self.blackView addSubview:_nearLaber];
    
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.moonImg.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self.moonImg addGestureRecognizer:tapGesture];
    
    
    //
    self.mapImg = [[UIImageView alloc]init];
    self.mapImg.frame = CGRectMake((kScreenWitdh - 40 )*0.4, CGRectGetMinY(self.moonImg.frame), CGRectGetWidth(self.moonImg.frame), CGRectGetHeight(self.moonImg.frame));
    self.mapImg.image = [UIImage imageNamed:@"Map"];
    self.mapImg.layer.masksToBounds = YES;
    self.mapImg.layer.cornerRadius = kScreenWitdh * 0.075;
    [self.blackView addSubview:_mapImg];
    self.orgLaber = [[UILabel alloc]init];
    self.orgLaber.frame = CGRectMake(CGRectGetMinX(self.mapImg.frame)+3, CGRectGetMinY(self.nearLaber.frame), CGRectGetWidth(self.mapImg.frame), CGRectGetHeight(self.nearLaber.frame));
    self.orgLaber.font = [UIFont systemFontOfSize:12.0];
    self.orgLaber.text = @"分支机构";
    [self.blackView addSubview:_orgLaber];
    //
    UITapGestureRecognizer *tapGesture1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.mapImg.userInteractionEnabled = YES;
    tapGesture1.numberOfTapsRequired = 1;
    tapGesture1.numberOfTouchesRequired = 1;
    [self.mapImg addGestureRecognizer:tapGesture1];

    //
    self.cityImg = [[UIImageView alloc]init];
    self.cityImg.frame = CGRectMake((kScreenWitdh - 40 )*0.7,
                                    CGRectGetMinY(self.moonImg.frame), CGRectGetWidth(self.moonImg.frame), CGRectGetHeight(self.moonImg.frame));
    self.cityImg.image = [UIImage imageNamed:@"City"];
    self.cityImg.layer.masksToBounds = YES;
    self.cityImg.layer.cornerRadius = kScreenWitdh * 0.075;
    
    [self.blackView addSubview:_cityImg];
    
    self.hosLaber = [[UILabel alloc]init];
    self.hosLaber.frame = CGRectMake(CGRectGetMinX(self.cityImg.frame)+3, CGRectGetMinY(self.nearLaber.frame), CGRectGetWidth(self.cityImg.frame), CGRectGetHeight(self.nearLaber.frame));
    self.hosLaber.font = [UIFont systemFontOfSize:12.0];
    self.hosLaber.text = @"定点医院";
    [self.blackView addSubview:_hosLaber];
    //
    self.findImg = [[UIImageView alloc]init];
    self.findImg.frame = CGRectMake(CGRectGetMinX(self.moonImg.frame), kScreenHeight * 0.2, CGRectGetWidth(self.moonImg.frame), CGRectGetHeight(self.moonImg.frame));
    self.findImg.image = [UIImage imageNamed:@"Finder"];
    self.findImg.layer.masksToBounds = YES;
    self.findImg.layer.cornerRadius = kScreenWitdh * 0.075;
    
    [self.blackView addSubview:_findImg];
    self.mesLaber = [[UILabel alloc]init];
    self.mesLaber.frame = CGRectMake(CGRectGetMinX(self.findImg.frame)+3, CGRectGetMaxY(self.findImg.frame)+5, CGRectGetWidth(self.findImg.frame), CGRectGetHeight(self.nearLaber.frame));
    self.mesLaber.font = [UIFont systemFontOfSize:12.0];
    self.mesLaber.text = @"信息批漏";
    [self.blackView addSubview:_mesLaber];
    
}
//定义响应事件

-(void)onClickUILable:(UITapGestureRecognizer *)sender{
    
    WHnearAgentTableViewController * near = [[WHnearAgentTableViewController alloc]init];
    [self.navigationController pushViewController:near animated:YES];
    
    
}
-(void)onClickUILable1:(UITapGestureRecognizer *)sender{
    
    WHorginTableViewController * orgin = [[WHorginTableViewController alloc]init];
    [self.navigationController pushViewController:orgin animated:YES];
    
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
