//
//  WHgetproducedetalViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHgetproducedetalViewController.h"
#import "MacroUtility.h"
#import "JGProgressHelper.h"


@interface WHgetproducedetalViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrow;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * mainImg;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * prostatusLaber;
@property(nonatomic,strong)UILabel * staLaber;
@property(nonatomic,strong)UILabel * compLaber;
// 横向的UIScrollview
@property (nonatomic, strong) UIScrollView *horScrollV;
// 纵向的UIScrollview2 --- 筛选条件
@property (nonatomic, strong) UIScrollView *conditionScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *essentialScrollV;
// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;

@end

@implementation WHgetproducedetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 布局
    [self setupUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
    
}

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"产品详情";
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(20, 35, kScreenWitdh - 40, kScreenHeight * 0.15);
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
    self.view.backgroundColor = [UIColor blueColor];
    //
    self.mainImg = [[UIImageView alloc]init];
    self.mainImg.frame = CGRectMake(kScreenWitdh *0.1, 20, 30, 30);
    self.mainImg.layer.masksToBounds = YES;
    self.mainImg.layer.cornerRadius = 15;
    self.mainImg.image = [UIImage imageNamed:@"p_huangfu"];
    [self.myView addSubview:_mainImg];
    //
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.mainImg.frame)+10, CGRectGetMinY(self.mainImg.frame), kScreenWitdh * 0.6, 30);
    self.titLaber.font = [UIFont systemFontOfSize:15.0];
    self.titLaber.text = @"泰康康怡人生两全保险";
    [self.myView addSubview:_titLaber];
    //
    self.prostatusLaber = [[UILabel alloc]init];
    self.prostatusLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame)+5, CGRectGetMaxY(self.titLaber.frame), kScreenWitdh * 0.25, 20);
    self.prostatusLaber.text = @"产品状态|";
    self.prostatusLaber.textColor = [UIColor grayColor];
    self.prostatusLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_prostatusLaber];
    //
    self.staLaber = [[UILabel alloc]init];
    self.staLaber.frame = CGRectMake(CGRectGetMaxX(self.prostatusLaber.frame)+5, CGRectGetMinY(self.prostatusLaber.frame), 30, 20);
    self.staLaber.layer.cornerRadius = 10;
    self.staLaber.layer.masksToBounds = YES;
    self.staLaber.text = @"在售";
    self.staLaber.backgroundColor = [UIColor greenColor];
    self.staLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_staLaber];
    
    self.compLaber = [[UILabel alloc]init];
    self.compLaber.frame = CGRectMake(kScreenWitdh *0.65,  kScreenHeight * 0.15 -30, kScreenWitdh*0.2, 30);
    self.compLaber.text = @"泰康人寿";
    self.compLaber.font = [UIFont systemFontOfSize:15.0];
    self.compLaber.backgroundColor = [UIColor greenColor];
    [self.myView addSubview:_compLaber];
    
    
    
}

-(void)quartData
{

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
