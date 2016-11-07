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
#import "WHget_product_detail.h"


@interface WHgetproducedetalViewController ()<UIScrollViewDelegate,UIWebViewDelegate>

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
@property (nonatomic, strong) UIScrollView *bigScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *ruleScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *rightScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *pdfScrollV;

// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;
//index = 2
@property (nonatomic ,strong) UIButton *btnRule;

//index = 3
@property (nonatomic ,strong) UIButton *btnRight;
//index = 4
@property (nonatomic ,strong) UIButton *btnPdf;
@property(nonatomic,strong)NSString * s1 ;

@property(nonatomic,strong)NSString * s2 ;

@property(nonatomic,strong)UIWebView * scw;

@property(nonatomic, strong)NSMutableArray * dataArr1;

@property(nonatomic,strong)NSString * StrCases;

@property(nonatomic,strong)NSString * right;

@property(nonatomic,strong)NSString * rule;

@property(nonatomic,strong)NSString * pdf;



@end

@implementation WHgetproducedetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 布局
    [self setupUI];
     self.scw.delegate = self;
    self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.16, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.8)];
    //self.scw.tintColor = [UIColor grayColor];
    
    
    [self.essentialScrollV addSubview:_scw];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
    
}
-(void)loadWithURLString:(NSString *)urlStr
{
    NSString  * content = [self.s1 stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",kScreenWitdh-16,kScreenWitdh-16,kScreenWitdh-16];
    //
    
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    //self.scw = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"00%@",contentTwo);
    
    [_scw loadHTMLString:html baseURL:nil];
}
//数据请求
-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.dataService get_product_detailWithPro_id:self.pro_id uid:@"" success:^(WHget_product_detail *userInfo) {
        [hud hide:YES];
        self.s2 = userInfo.clause;
       // NSLog(@"%@",userInfo.cases);
        self.StrCases = userInfo.cases;
        self.rule = userInfo.rule;
        self.right  = userInfo.rights;
        self.pdf = userInfo.pdf_path;
      
        
        self.staLaber.text = userInfo.sale_status_name;
     
        self.titLaber.text = userInfo.name;
        
        self.compLaber.text = userInfo.company_short_name;
        
        NSInteger stateM = [userInfo.is_main integerValue];
        switch (stateM) {
            case 1:
                self.mainImg.image =[UIImage imageNamed:@"p_zhu"];
                break;
            case 2:
                self.mainImg.image = [UIImage imageNamed:@"p_huangfu"];
                break;
            case 3:
                self.mainImg.image = [UIImage imageNamed:@"p_group"];
                break;
                
            default:
                break;
        }

        [self dataHead];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
}
//ad默认
-(void)dataHead
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    
    self.s1 = self.s2;
    [self loadWithURLString:self.s1];
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
   // self.mainImg.image = [UIImage imageNamed:@"p_huangfu"];
    [self.myView addSubview:_mainImg];
    //
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.mainImg.frame)+10, CGRectGetMinY(self.mainImg.frame), kScreenWitdh * 0.6, 30);
    self.titLaber.font = [UIFont systemFontOfSize:15.0];
    //self.titLaber.text = self.nameLaber;
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
    //self.staLaber.text = self.sale_status;
    self.staLaber.backgroundColor = [UIColor greenColor];
    self.staLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_staLaber];
    
    self.compLaber = [[UILabel alloc]init];
    self.compLaber.frame = CGRectMake(kScreenWitdh *0.65,  kScreenHeight * 0.15 -30, kScreenWitdh*0.2, 30);
    //self.compLaber.text = @"泰康人寿";
    self.compLaber.font = [UIFont systemFontOfSize:15.0];
   // self.compLaber.backgroundColor = [UIColor greenColor];
    [self.myView addSubview:_compLaber];
    //
    // 最大的UIScrollview bigScrollV;
    self.bigScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenWitdh, kScreenHeight - 64)];
    [self.view addSubview:_bigScrollV];
    //
    self.btnConditions = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnConditions.frame = CGRectMake(0, CGRectGetMaxY(_myView.frame), kScreenWitdh * 0.2, 44);
    [_btnConditions setTitle:@"详情" forState:UIControlStateNormal];
    [_btnConditions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnConditions setBackgroundColor:[UIColor blueColor]];
    [_btnConditions addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnConditions.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnConditions];

    // index = 1 btnEssentialMSG;
    self.btnEssentialMSG = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnEssentialMSG.frame = CGRectMake(CGRectGetMaxX(_btnConditions.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnEssentialMSG setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnEssentialMSG setBackgroundColor:[UIColor blueColor]];
    [_btnEssentialMSG addTarget:self action:@selector(btnMSGAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnEssentialMSG setTitle:@"责任" forState:UIControlStateNormal];
    _btnEssentialMSG.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnEssentialMSG];

    // index = 2
    self.btnRule = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRule.frame = CGRectMake(CGRectGetMaxX(self.btnEssentialMSG.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnRule setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRule setBackgroundColor:[UIColor blueColor]];
    [_btnRule addTarget:self action:@selector(bntRuleAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnRule setTitle:@"规则" forState:UIControlStateNormal];
    _btnRule.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnRule];

    // index = 3
    self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRight.frame = CGRectMake(CGRectGetMaxX(self.btnRule.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRight setBackgroundColor:[UIColor blueColor]];
    [_btnRight addTarget:self action:@selector(bntRightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnRight setTitle:@"条款" forState:UIControlStateNormal];
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnRight];
    
    //// index = 4
    self.btnPdf = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPdf.frame = CGRectMake(CGRectGetMaxX(self.btnRight.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnPdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPdf setBackgroundColor:[UIColor blueColor]];
    [_btnPdf addTarget:self action:@selector(bntpdfAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnPdf setTitle:@"案例" forState:UIControlStateNormal];
    _btnPdf.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnPdf];

    // 横向的UIScrollview horScrollV;
    self.horScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnConditions.frame), kScreenWitdh, kScreenHeight - 64 - CGRectGetMaxY(_btnConditions.frame))];
    _horScrollV.contentSize = CGSizeMake(kScreenWitdh * 5, CGRectGetHeight(_horScrollV.frame)*1.0);
    _horScrollV.pagingEnabled = YES;
    _horScrollV.showsVerticalScrollIndicator = NO;
    _horScrollV.showsHorizontalScrollIndicator = NO;
    _horScrollV.delegate = self;
    _horScrollV.backgroundColor = [UIColor yellowColor];
    [_bigScrollV addSubview:_horScrollV];
    
    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.conditionScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, CGRectGetHeight(_horScrollV.frame))];
     _conditionScrollV.backgroundColor = [UIColor grayColor];
    [_horScrollV addSubview:_conditionScrollV];
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.essentialScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_conditionScrollV.frame), CGRectGetMinY(_conditionScrollV.frame)-kScreenHeight*0.15, kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame)+kScreenHeight*0.15)];
     _essentialScrollV.backgroundColor = [UIColor whiteColor];
    [_horScrollV addSubview:_essentialScrollV];

    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.ruleScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 2.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _ruleScrollV.backgroundColor = [UIColor redColor];
    [_horScrollV addSubview:_ruleScrollV];
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.rightScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 3.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _rightScrollV.backgroundColor = [UIColor yellowColor];
    [_horScrollV addSubview:_rightScrollV];
//
    self.pdfScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 4.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _pdfScrollV.backgroundColor = [UIColor whiteColor];
    [_horScrollV addSubview:_pdfScrollV];

    
}
//责任事件
-(void)btnMSGAction:(UIButton *)sender
{
  
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    
    self.s1 = self.StrCases;
    [self loadWithURLString:self.s1];

}

//详情
-(void)btnAction:(UIButton *)sender
{
  
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);

    self.s1 = self.s2;
    [self loadWithURLString:self.s1];

}

//
-(void)bntRuleAction:(UIButton *)sender
{
    
   
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh , 0);
    
    self.s1 = self.rule;
    [self loadWithURLString:self.s1];

    
}

-(void)bntRightAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh , 0);
    
    self.s1 = self.right;
    [self loadWithURLString:self.s1];
}
-(void)bntpdfAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    self.s1 = self.pdf;
    [self loadWithURLString:self.s1];
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