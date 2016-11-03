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

@interface JwLookForController ()<UIScrollViewDelegate>

// 最大的UIScrollview
@property (nonatomic, strong) UIScrollView *bigScrollV;
// 搜索View
@property (nonatomic, strong) UIView *searchView;
// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;
// 横向的UIScrollview
@property (nonatomic, strong) UIScrollView *horScrollV;
// 纵向的UIScrollview2 --- 筛选条件
@property (nonatomic, strong) UIScrollView *conditionScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *essentialScrollV;

@property(nonatomic,strong)NSMutableArray * dataArry;



@end

@implementation JwLookForController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self quartData];
}
-(void)quartData
{
    [self.dataService getprofirstWithUid:@"" success:^(NSArray *lists) {
        
        for (WHgetprofirst * model in lists) {
            NSLog(@"##########%@",model.period);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    
    // 布局
    [self setupView];
    
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
    _searchView.backgroundColor = [UIColor blueColor];
    [self.bigScrollV addSubview:_searchView];
    
    // index = 0 btnConditions;
    self.btnConditions = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnConditions.frame = CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWitdh * 0.5, 44);
    [_btnConditions setTitle:@"筛选条件" forState:UIControlStateNormal];
    [_btnConditions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnConditions setBackgroundColor:[UIColor blueColor]];
    [_btnConditions addTarget:self action:@selector(btnConditionsAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnConditions.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnConditions];
    
    // index = 1 btnEssentialMSG;
    self.btnEssentialMSG = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnEssentialMSG.frame = CGRectMake(CGRectGetMaxX(_btnConditions.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
    [_btnEssentialMSG setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnEssentialMSG setBackgroundColor:[UIColor blueColor]];
    [_btnEssentialMSG addTarget:self action:@selector(btnEssentialMSGAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnEssentialMSG setTitle:@"基本信息" forState:UIControlStateNormal];
    _btnEssentialMSG.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollV addSubview:_btnEssentialMSG];
    
    // 横向的UIScrollview horScrollV;
    self.horScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btnConditions.frame), kScreenWitdh, kScreenHeight - 64 - CGRectGetMaxY(_btnConditions.frame))];
    _horScrollV.contentSize = CGSizeMake(kScreenWitdh * 2, CGRectGetHeight(_horScrollV.frame));
    _horScrollV.pagingEnabled = YES;
    _horScrollV.showsVerticalScrollIndicator = NO;
    _horScrollV.showsHorizontalScrollIndicator = NO;
    _horScrollV.delegate = self;
    _horScrollV.backgroundColor = [UIColor yellowColor];
    [_bigScrollV addSubview:_horScrollV];
    
    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.conditionScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, CGRectGetHeight(_horScrollV.frame))];
    _conditionScrollV.backgroundColor = [UIColor redColor];
    [_horScrollV addSubview:_conditionScrollV];
    
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.essentialScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_conditionScrollV.frame), CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _essentialScrollV.backgroundColor = [UIColor greenColor];
    [_horScrollV addSubview:_essentialScrollV];
    
}


#pragma mark -- Private
// 点击方法
-(void)btnConditionsAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(0, 0);
}

-(void)btnEssentialMSGAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
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
        }
        else
        {
            // 滑动到右侧
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
