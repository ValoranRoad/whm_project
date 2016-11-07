//
//  JwLookForController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwLookForController.h"
#import "UIColor+Hex.h"
#import "WHgetprofirst.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHpelicyTableViewController.h"
#import "WHpayTableViewController.h"
#import "WHhistoryTableViewController.h"
#import <UIImageView+WebCache.h>
#import "WHpowSearTableViewController.h"

#import "JwRela.h"


@interface JwLookForController ()<UIScrollViewDelegate>

// 最大的UIScrollview
@property (nonatomic, strong) UIScrollView *bigScrollV;
// 搜索View
@property (nonatomic, strong) UIView *searchView;
// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;
@property (nonatomic, strong) CALayer *segmentLineLayer;
// 横向的UIScrollview
@property (nonatomic, strong) UIScrollView *horScrollV;
// 纵向的UIScrollview2 --- 筛选条件
@property (nonatomic, strong) UIScrollView *conditionScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *essentialScrollV;

@property(nonatomic,strong)NSMutableArray * dataArry;

//
@property(nonatomic,strong)UIImageView * image;
@property(nonatomic,strong)UITextField * searText;
@property(nonatomic,strong)UIImageView * searImg;
@property(nonatomic,strong)UIButton * shaiBut;
@property(nonatomic,strong)UIButton * baseBut;
@property(nonatomic,strong)UIView * myview;
//
@property(nonatomic,strong)UILabel * myLaber1;
@property(nonatomic,strong)UITextField * myText1;
@property(nonatomic,strong)UITextField * myText2;
@property(nonatomic,strong)UILabel * myText3;
@property(nonatomic,strong)UILabel * myText4;
@property(nonatomic,strong)UIButton * serchBut;
//基本信息
@property(nonatomic,strong)UIImageView * basImg;
@property(nonatomic,strong)UITextField * basText1;
@property(nonatomic,strong)UITextField * basText2;
@property(nonatomic,strong)UITextField * basText3;
@property(nonatomic,strong)UITextField * basText4;
//搜索框里边的数据
@property(nonatomic,strong)UIImageView * soundImg;
@property(nonatomic,strong)UIButton * searchBut;



@end

@implementation JwLookForController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self quartData];
    [self UI];
    [self setupUI];
}
-(void)quartData
{
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getprofirstWithUid:nil success:^(WHgetprofirst *profirst) {
        
        [hud hide:YES];
        JwRela *rela = [profirst.rela firstObject];
        DLog(@"%@", rela.yearly_income);
        if (rela.avatar.length != 0) {
            [self.basImg sd_setImageWithURL:[NSURL URLWithString:rela.avatar]];

        }
        else
        {
        self.basImg.image = [UIImage imageNamed:@"test_head"];
        }
        if ([rela.sex integerValue] == 1) {
            self.basText1.text = @"男";
        }
        if ([rela.sex integerValue] == 2) {
            self.basText1.text = @"女";
        }
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:rela.birthday.doubleValue];

        NSString * s2 = [NSString stringWithFormat:@"%@",confromTimesp];
        
        self.basText2.text = [s2 substringToIndex:11];
        
        self.basText3.text = rela.yearly_income;
        
        self.basText4.text = rela.yearly_out;

        
    } failure:^(NSError *error) {
        [hud hide:YES];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    
    // 布局
    [self setupView];
    
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];
   

    
}

-(void)left:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark -- 布局
-(void)setupView
{
    self.title = @"找险种";
  
    
    // 最大的UIScrollview bigScrollV;
    self.bigScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64)];
    [self.view addSubview:_bigScrollV];
    
    // 搜索View searchView;
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 100)];
//    _searchView.backgroundColor =  [UIColor colorWithHex:0x4367FF];
    _searchView.layer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"xianzhong.png"].CGImage;
    //_searchView.backgroundColor = [ui]
    
    [self.bigScrollV addSubview:_searchView];
    //
//    self.image= [[UIImageView alloc]init];
//    self.image.frame = CGRectMake(0,0 , CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.24);
//    self.image.image = [UIImage imageNamed:@"xianzhong.png"];
//    [self.bigScrollV addSubview:_image];
    //
    self.searText = [[UITextField alloc]init];
    self.searText.frame = CGRectMake(20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.07, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 46);
    self.searText.placeholder = @"请输入关键词";
    self.searText.borderStyle = UITextBorderStyleLine;
    self.searText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searImg = [[UIImageView alloc]init];
    self.searImg.frame = CGRectMake(0, 0, 20, 20);
    self.searImg.image = [UIImage imageNamed:@"sousu"];
    self.searText.leftView = self.searImg;
    self.searText.leftViewMode = UITextFieldViewModeAlways;
    self.searText.backgroundColor = [UIColor whiteColor];
    [self.bigScrollV addSubview:_searText];
    //
    self.serchBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.serchBut.frame = CGRectMake(0, 0, 60, 30);
    [self.serchBut setTitle:@"搜索" forState:(UIControlStateNormal)];
    self.searText.rightView = self.serchBut;
    self.searText.rightViewMode = UITextFieldViewModeAlways;
    [self.serchBut addTarget:self action:@selector(serchButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    //
    // index = 0 btnConditions;
    self.btnConditions = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnConditions.frame = CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWitdh * 0.5, 54);
    [_btnConditions setTitle:@"筛选条件" forState:UIControlStateNormal];
    [_btnConditions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnConditions setBackgroundImage:[UIImage imageNamed:@"xianzhong"] forState:UIControlStateNormal];
    [_btnConditions addTarget:self action:@selector(btnConditionsAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnConditions.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnConditions];
    //
   
    
    
    // index = 1 btnEssentialMSG;
    self.btnEssentialMSG = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnEssentialMSG.frame = CGRectMake(CGRectGetMaxX(_btnConditions.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnEssentialMSG setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnEssentialMSG setBackgroundImage:[UIImage imageNamed:@"xianzhong"] forState:UIControlStateNormal];
    [_btnEssentialMSG addTarget:self action:@selector(btnEssentialMSGAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnEssentialMSG setTitle:@"基本信息" forState:UIControlStateNormal];
    _btnEssentialMSG.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnEssentialMSG];
    
    self.segmentLineLayer = [CALayer layer];
    _segmentLineLayer.frame = CGRectMake(CGRectGetMinX(_btnConditions.frame), CGRectGetMaxY(_btnConditions.frame) - 5, CGRectGetWidth(_btnConditions.frame), 5);
    _segmentLineLayer.contents = (__bridge id _Nullable)[UIImage imageNamed:@"lookForInsured"].CGImage;
    [self.view.layer addSublayer:_segmentLineLayer];
    
    // 横向的UIScrollview horScrollV;
    self.horScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnConditions.frame), kScreenWitdh, kScreenHeight - 64 - CGRectGetMaxY(_btnConditions.frame))];
    _horScrollV.contentSize = CGSizeMake(kScreenWitdh * 2, CGRectGetHeight(_horScrollV.frame));
    _horScrollV.pagingEnabled = YES;
    _horScrollV.showsVerticalScrollIndicator = NO;
    _horScrollV.showsHorizontalScrollIndicator = NO;
    _horScrollV.delegate = self;
    //_horScrollV.backgroundColor = [UIColor yellowColor];
    [_bigScrollV addSubview:_horScrollV];
    
    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.conditionScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, CGRectGetHeight(_horScrollV.frame))];
   // _conditionScrollV.backgroundColor = [UIColor redColor];
    [_horScrollV addSubview:_conditionScrollV];
    
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.essentialScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_conditionScrollV.frame), CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
   // _essentialScrollV.backgroundColor = [UIColor greenColor];
    [_horScrollV addSubview:_essentialScrollV];
    
}

-(void)serchButAction:(UIButton *)sender
{
    NSLog(@"kkk");
    WHhistoryTableViewController * history = [[WHhistoryTableViewController alloc]init];
    [self.navigationController pushViewController:history animated:YES];
}

-(void)UI
{
    _horScrollV.contentOffset = CGPointMake(0, 0);
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(30, CGRectGetHeight([UIScreen mainScreen].bounds)*0.07, 60, 20);
    lab.text = @"筛选条件";
    lab.font = [UIFont systemFontOfSize:13.0];
    lab.textColor =[UIColor grayColor];
    [self.conditionScrollV addSubview:lab];
    //
    UIImageView * myImage1 = [[UIImageView alloc]init];
    myImage1.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lab.frame)+10, 20, 20);
    myImage1.image = [UIImage imageNamed:@"shoujin"];
    [self.conditionScrollV addSubview:myImage1];
    //
    UILabel * Laber1 = [[UILabel alloc]init];
    Laber1.frame = CGRectMake(CGRectGetMaxX(myImage1.frame)+10, CGRectGetMinY(myImage1.frame)-5, 60, 30);
    Laber1.textColor = [UIColor grayColor];
    Laber1.font = [UIFont systemFontOfSize:13.0];
    Laber1.text = @"首年保费";
    [self.conditionScrollV addSubview:Laber1];
    self.myText1 = [[UITextField alloc]init];
    self.myText1.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber1.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber1.frame));
    
    self.myText1.borderStyle = UITextBorderStyleNone;
    self.myText1.textColor = [UIColor grayColor];
    self.myText1.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img1 = [[UIImageView alloc]init];
    img1.frame = CGRectMake(0, 0, 20, 20);
    self.myText1.rightView = img1;
    self.myText1.rightViewMode = UITextFieldViewModeAlways;
    self.myText1.keyboardType = UIKeyboardTypeNumberPad;
    img1.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.conditionScrollV addSubview:_myText1];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(20, CGRectGetMaxY(_myText1.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView1.backgroundColor = [UIColor grayColor];
    [self.conditionScrollV addSubview:lineView1];
    
    //
    
    UIImageView * myImage2 = [[UIImageView alloc]init];
    myImage2.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView1.frame)+10, 20, 20);
    myImage2.image = [UIImage imageNamed:@"baojin"];
    [self.conditionScrollV addSubview:myImage2];
    //
    UILabel * Laber2 = [[UILabel alloc]init];
    Laber2.frame = CGRectMake(CGRectGetMaxX(myImage2.frame)+10, CGRectGetMinY(myImage2.frame)-5, 60, 30);
    Laber2.textColor = [UIColor grayColor];
    Laber2.font = [UIFont systemFontOfSize:13.0];
    Laber2.text = @"保险金额";
    [self.conditionScrollV addSubview:Laber2];
    
    self.myText2 = [[UITextField alloc]init];
    self.myText2.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber2.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber2.frame));
    
    self.myText2.borderStyle = UITextBorderStyleNone;
    self.myText2.textColor = [UIColor grayColor];
    self.myText2.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img2 = [[UIImageView alloc]init];
    img2.frame = CGRectMake(0, 0, 20, 20);
    self.myText2.rightView = img2;
    self.myText2.rightViewMode = UITextFieldViewModeAlways;
    self.myText2.keyboardType = UIKeyboardTypeNumberPad;
    img2.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.conditionScrollV addSubview:_myText2];
    
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.frame = CGRectMake(20, CGRectGetMaxY(_myText2.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView2.backgroundColor = [UIColor grayColor];
    [self.conditionScrollV addSubview:lineView2];
    
    //
    UIImageView * myImage3 = [[UIImageView alloc]init];
    myImage3.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView2.frame)+10, 20, 20);
    myImage3.image = [UIImage imageNamed:@"qijian"];
    [self.conditionScrollV addSubview:myImage3];
    //    //
    UILabel * Laber3 = [[UILabel alloc]init];
    Laber3.frame = CGRectMake(CGRectGetMaxX(myImage3.frame)+10, CGRectGetMinY(myImage3.frame)-5, 60, 30);
    Laber3.textColor = [UIColor grayColor];
    Laber3.font = [UIFont systemFontOfSize:13.0];
    Laber3.text = @"保险期间";
    [self.conditionScrollV addSubview:Laber3];
    
    self.myText3 = [[UILabel alloc]init];
    self.myText3.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber3.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber3.frame));
    //
    //self.myText3.borderStyle = UITextBorderStyleNone;
    self.myText3.textColor = [UIColor grayColor];
    self.myText3.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img3 = [[UIImageView alloc]init];
    img3.frame = CGRectMake(CGRectGetMaxX(self.myText3.frame)-20, CGRectGetMinY(self.myText3.frame), 20, 20);
    //self.myText3.rightView = img3;
    //self.myText3.rightViewMode = UITextFieldViewModeAlways;
    // self.myText3.keyboardType = UIKeyboardTypeNumberPad;
    img3.image = [UIImage imageNamed:@"p_arrowleft"];
    [self.conditionScrollV addSubview:img3];
    //
    [self.conditionScrollV addSubview:_myText3];
    //
    
    //给self.view添加一个手势监测；
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.myText3.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired=1;
    
    [self.myText3 addGestureRecognizer:tapGesture];
    
    
    
    
    
    UIView * lineView3 = [[UIView alloc]init];
    lineView3.frame = CGRectMake(20, CGRectGetMaxY(_myText3.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView3.backgroundColor = [UIColor grayColor];
    [self.conditionScrollV addSubview:lineView3];
    //
    //
    UIImageView * myImage4 = [[UIImageView alloc]init];
    myImage4.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView3.frame)+10, 20, 20);
    myImage4.image = [UIImage imageNamed:@"jiaofei"];
    [self.conditionScrollV addSubview:myImage4];
    //    //
    UILabel * Laber4 = [[UILabel alloc]init];
    Laber4.frame = CGRectMake(CGRectGetMaxX(myImage4.frame)+10, CGRectGetMinY(myImage4.frame)-5, 60, 30);
    Laber4.textColor = [UIColor grayColor];
    Laber4.font = [UIFont systemFontOfSize:13.0];
    Laber4.text = @"缴费期间";
    [self.conditionScrollV addSubview:Laber4];
    
    self.myText4 = [[UILabel alloc]init];
    self.myText4.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber4.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber4.frame));
    //
    // self.myText4.borderStyle = UITextBorderStyleNone;
    self.myText4.textColor = [UIColor grayColor];
    self.myText4.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img4 = [[UIImageView alloc]init];
    img4.frame = CGRectMake(CGRectGetMaxX(self.myText4.frame)-20, CGRectGetMinY(self.myText4.frame), 20, 20);
    //    self.myText4.rightView = img4;
    //    self.myText4.rightViewMode = UITextFieldViewModeAlways;
    //    self.myText4.keyboardType = UIKeyboardTypeNumberPad;
    img4.image = [UIImage imageNamed:@"p_arrowleft"];
    [self.conditionScrollV addSubview:img4];
    //
    [self.conditionScrollV addSubview:_myText4];
    //
    //给self.view添加一个手势监测；
    UITapGestureRecognizer *tapGesture1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.myText4.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired=1;
    
    [self.myText4 addGestureRecognizer:tapGesture1];
    
    
    UIView * lineView4 = [[UIView alloc]init];
    lineView4.frame = CGRectMake(20, CGRectGetMaxY(_myText4.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView4.backgroundColor = [UIColor grayColor];
    [self.conditionScrollV addSubview:lineView4];
    
    //
    self.serchBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.serchBut.frame = CGRectMake(30, CGRectGetMaxY(lineView4.frame)+20, CGRectGetWidth([UIScreen mainScreen].bounds)-60, 50);
    self.serchBut.backgroundColor = [UIColor colorWithHex:0xFF4545];
    self.serchBut.layer.cornerRadius = 25;
    [self.serchBut setTitle:@"高级搜索" forState:(UIControlStateNormal)];
    [self.serchBut addTarget:self action:@selector(powSearch:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.serchBut setTintColor:[UIColor whiteColor]];
    [self.conditionScrollV addSubview:_serchBut];
    
    
    

}

-(void)powSearch:(UIButton *)sender
{
    WHpowSearTableViewController * powsearch = [[WHpowSearTableViewController alloc]init];
    [self.navigationController pushViewController:powsearch animated:YES];
}

- (void)setupUI
{
    self.basImg = [[UIImageView alloc]init];
    self.basImg.frame = CGRectMake(kScreenWitdh*0.4, CGRectGetHeight([UIScreen mainScreen].bounds)*0.07, 60, 60);
  
    self.basImg.layer.masksToBounds = YES;
    self.basImg.layer.cornerRadius = 30;
    [self.essentialScrollV addSubview:_basImg];
    //
    UIImageView * myImage1 = [[UIImageView alloc]init];
    myImage1.frame = CGRectMake(30, CGRectGetMaxY(self.basImg.frame)+20, 20, 20);
    myImage1.image = [UIImage imageNamed:@"test_sex"];
    [self.essentialScrollV addSubview:myImage1];
    //
    UILabel * Laber1 = [[UILabel alloc]init];
    Laber1.frame = CGRectMake(CGRectGetMaxX(myImage1.frame)+10, CGRectGetMinY(myImage1.frame)-5, 60, 30);
    Laber1.textColor = [UIColor grayColor];
    Laber1.font = [UIFont systemFontOfSize:13.0];
    Laber1.text = @"性别";
    [self.essentialScrollV addSubview:Laber1];
    
    self.basText1 = [[UITextField alloc]init];
    self.basText1.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber1.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber1.frame));
    
    self.basText1.borderStyle = UITextBorderStyleNone;
    self.basText1.textColor = [UIColor grayColor];
    self.basText1.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img1 = [[UIImageView alloc]init];
    img1.frame = CGRectMake(0, 0, 20, 20);
    self.basText1.rightView = img1;
    self.basText1.rightViewMode = UITextFieldViewModeAlways;
    self.basText1.keyboardType = UIKeyboardTypeNumberPad;
    img1.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.essentialScrollV addSubview:_basText1];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(20, CGRectGetMaxY(_basText1.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView1.backgroundColor = [UIColor grayColor];
    [self.essentialScrollV addSubview:lineView1];
    //
    UIImageView * myImage2 = [[UIImageView alloc]init];
    myImage2.frame = CGRectMake(CGRectGetMinX(myImage1.frame), CGRectGetMaxY(lineView1.frame)+10, 20, 20);
    myImage2.image = [UIImage imageNamed:@"test_date"];
    [self.essentialScrollV addSubview:myImage2];
    //
    UILabel * Laber2 = [[UILabel alloc]init];
    Laber2.frame = CGRectMake(CGRectGetMaxX(myImage2.frame)+10, CGRectGetMinY(myImage2.frame)-5, 60, 30);
    Laber2.textColor = [UIColor grayColor];
    Laber2.font = [UIFont systemFontOfSize:13.0];
    Laber2.text = @"出生日期";
    [self.essentialScrollV addSubview:Laber2];
    self.basText2 = [[UITextField alloc]init];
    self.basText2.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber2.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber2.frame));
    
    self.basText2.borderStyle = UITextBorderStyleNone;
    self.basText2.textColor = [UIColor grayColor];
    self.basText2.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img2 = [[UIImageView alloc]init];
    img2.frame = CGRectMake(0, 0, 20, 20);
    self.basText2.rightView = img2;
    self.basText2.rightViewMode = UITextFieldViewModeAlways;
    self.basText2.keyboardType = UIKeyboardTypeNumberPad;
    img2.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.essentialScrollV addSubview:_basText2];
    //
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.frame = CGRectMake(20, CGRectGetMaxY(_basText2.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView2.backgroundColor = [UIColor grayColor];
    [self.essentialScrollV addSubview:lineView2];
    //
    UIImageView * myImage3 = [[UIImageView alloc]init];
    myImage3.frame = CGRectMake(CGRectGetMinX(myImage1.frame), CGRectGetMaxY(lineView2.frame)+10, 20, 20);
    myImage3.image = [UIImage imageNamed:@"test_year"];
    [self.essentialScrollV addSubview:myImage3];
    
    UILabel * Laber3 = [[UILabel alloc]init];
    Laber3.frame = CGRectMake(CGRectGetMaxX(myImage3.frame)+10, CGRectGetMinY(myImage3.frame)-5, 60, 30);
    Laber3.textColor = [UIColor grayColor];
    Laber3.font = [UIFont systemFontOfSize:13.0];
    Laber3.text = @"年收入";
    [self.essentialScrollV addSubview:Laber3];
    //
    self.basText3 = [[UITextField alloc]init];
    self.basText3.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber3.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber3.frame));
    //
    self.basText3.borderStyle = UITextBorderStyleNone;
    self.basText3.textColor = [UIColor grayColor];
    self.basText3.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img3 = [[UIImageView alloc]init];
    img3.frame = CGRectMake(0, 0, 20, 20);
    self.basText3.rightView = img3;
    self.basText3.rightViewMode = UITextFieldViewModeAlways;
    self.basText3.keyboardType = UIKeyboardTypeNumberPad;
    img3.image = [UIImage imageNamed:@"p_arrowleft"];
    //
    [self.essentialScrollV addSubview:_basText3];
    UIView * lineView3 = [[UIView alloc]init];
    lineView3.frame = CGRectMake(20, CGRectGetMaxY(_basText3.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView3.backgroundColor = [UIColor grayColor];
    [self.essentialScrollV addSubview:lineView3];
    
    //
    UIImageView * myImage4 = [[UIImageView alloc]init];
    myImage4.frame = CGRectMake(CGRectGetMinX(myImage1.frame), CGRectGetMaxY(lineView3.frame)+10, 20, 20);
    myImage4.image = [UIImage imageNamed:@"test_debts"];
    [self.essentialScrollV addSubview:myImage4];
    UILabel * Laber4 = [[UILabel alloc]init];
    Laber4.frame = CGRectMake(CGRectGetMaxX(myImage4.frame)+10, CGRectGetMinY(myImage4.frame)-5, 60, 30);
    Laber4.textColor = [UIColor grayColor];
    Laber4.font = [UIFont systemFontOfSize:13.0];
    Laber4.text = @"负债总额";
    [self.essentialScrollV addSubview:Laber4];
    
    self.basText4 = [[UITextField alloc]init];
    self.basText4.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber4.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber4.frame));
    self.basText4.borderStyle = UITextBorderStyleNone;
    self.basText4.textColor = [UIColor grayColor];
    self.basText4.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img4 = [[UIImageView alloc]init];
    img4.frame = CGRectMake(0, 0, 20, 20);
    self.basText4.rightView = img4;
    self.basText4.rightViewMode = UITextFieldViewModeAlways;
    self.basText4.keyboardType = UIKeyboardTypeNumberPad;
    img4.image = [UIImage imageNamed:@"p_arrowleft"];
    //
    [self.essentialScrollV addSubview:_basText4];
    UIView * lineView4 = [[UIView alloc]init];
    lineView4.frame = CGRectMake(20, CGRectGetMaxY(_basText4.frame), CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView4.backgroundColor = [UIColor grayColor];
    [self.essentialScrollV addSubview:lineView4];
}

#pragma mark -- Private
// 点击方法
-(void)btnConditionsAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(0, 0);
    
    [UIView animateWithDuration:1.0 animations:^{
        CGRect rect_old = _segmentLineLayer.frame;
        CGRect rect_new = CGRectMake(CGRectGetMinX(sender.frame), rect_old.origin.y, rect_old.size.width, rect_old.size.height);
        _segmentLineLayer.frame = rect_new;
    }];


}

-(void)btnEssentialMSGAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    
    [UIView animateWithDuration:1.0 animations:^{
        CGRect rect_old = _segmentLineLayer.frame;
        CGRect rect_new = CGRectMake(CGRectGetMinX(sender.frame), rect_old.origin.y, rect_old.size.width, rect_old.size.height);
        _segmentLineLayer.frame = rect_new;
    }];

    
}

//保险期间选择
-(void)onClickUILable:(UITapGestureRecognizer *)sender{

    NSLog(@"ssss");
    WHpelicyTableViewController * pelic = [[WHpelicyTableViewController alloc]init];
   pelic.mblock2 = ^(NSString * s1)
    {
       
        self.myText3.text = s1;
        
    };

    
    [self.navigationController pushViewController:pelic animated:YES];
}

//缴费期间选择
-(void)onClickUILable1:(UITapGestureRecognizer *)sender{
    
    NSLog(@"ssss");
    WHpayTableViewController * pay = [[WHpayTableViewController alloc]init];
    pay.mblock2 = ^(NSString * s1)
    {
        
        self.myText4.text = s1;
        
    };

    [self.navigationController pushViewController:pay animated:YES];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- scroll view delegate
// scrollview 已经滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_horScrollV]) {
        if (scrollView.contentOffset.x < kScreenWitdh * 0.5) {
            // 滑动到左侧
            CGRect rect_old = _segmentLineLayer.frame;
            _segmentLineLayer.frame = CGRectMake(CGRectGetMinX(_btnConditions.frame), rect_old.origin.y, rect_old.size.width, rect_old.size.height);
        }
        else
        {
            // 滑动到右侧
            CGRect rect_old = _segmentLineLayer.frame;
            _segmentLineLayer.frame = CGRectMake(CGRectGetMinX(_btnEssentialMSG.frame), rect_old.origin.y, rect_old.size.width, rect_old.size.height);
        }
    }
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
