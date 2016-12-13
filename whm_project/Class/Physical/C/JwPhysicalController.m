//
//  JwPhysicalController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwPhysicalController.h"
#import "MacroUtility.h"
#import "HmPhysicalGroupCell.h"   // 高度定值 50
#import "HmPhysicalMainPageCell.h"   // 高度定值 90
#import "UIColor+Hex.h"
#import "HmDetailsCell.h"
#import "HmSelectInsuredController.h"
#import "HmFujiaCell.h"
#import "HmSelectCompanyController.h"
#import "WHageTableViewController.h"
#import "WHperiodTableViewController.h"
//
#import "JSCollectViewController.h"
#import "LYTestOneViewController.h"
#import "LYTestTwoViewController.h"
#import "LYTestThreeViewController.h"
#import "JGProgressHelper.h"
//
#import "JwUserCenter.h"
#import "JwLoginController.h"

#import "HmMultistageTableView.h"
#import "HmPhysicalGroupView.h"
#import "HmPhySicalMainView.h"
#import "HmDetailsCodeCell.h"
#import "HMConfirmView.h"
#import "HmBaoeCell.h"

//数据
#import "WHget_pro_rate.h"
#import "WHrate.h"

#import "WHselectCompanyViewController.h"

typedef enum {
    TYPE_AGE = 0,   // 年龄
    TYPE_PERIOD,   // 保障期间
    TYPE_PAY_PERIOD,   // 缴费期间
    TYPE_PAY_OUT,   // 给付方式
} CONTENT_ENUM_TYPE;


#define kHmPhysicalGroupCellIdentifier @"kHmPhysicalGroupCellIdentifier"
#define kHmPhysicalMainCellIdentifier @"kHmPhysicalMainCellIdentifier"
#define kHmPhysicalDetailsCellIdentifier @"dddkHmPhysicalDetailsCellIdentifier"
#define kHmPhysicalFujiaCellIdentifier @"kHmPhysicalFujiaCellIdentifier"
#define kHmPhysicalBaoeCellIdentifier @"kHmPhysicalBaoeCellIdentifier"

@interface JwPhysicalController ()<HmTableViewDelegate,HmTableViewDataSource,HMConfirmDelegate,UITextFieldDelegate>

// 大TableView
@property (nonatomic, strong) HmMultistageTableView *tableVB;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) WHget_user_realtion *firstUser;
@property(nonatomic,strong)UIButton * addBut;
@property(nonatomic,strong)NSString * age;

@property(nonatomic,strong)NSString * period;

@property(nonatomic,strong)UITextField *userNameTextField;

@property(nonatomic,strong)NSString * rela_id; //被保人ID

@property(nonatomic,strong)NSString * rate;

@property(nonatomic,strong)NSString * pay_period;

@property(nonatomic,strong)NSString * payout;

@property(nonatomic,strong)NSString * insured_amount;
//
@property(nonatomic,strong)NSString  * selectRelaID;
//@property(nonatomic,strong)NSString * selectProID;
//
// 性别
@property (nonatomic, strong) NSString *dataSex;

@property(nonatomic,strong)NSMutableArray * dataArry;
@property (nonatomic, strong) UIPickerView *pickerV;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSString *contentName;
@property (nonatomic, strong) NSIndexPath *myIndexPath;

@property (nonatomic, strong) HMConfirmView *confir;


@property(nonatomic, strong)NSMutableArray * arr1;
@property(nonatomic, strong)NSMutableArray * arr2;

@property(nonatomic,strong)NSMutableArray * ageArry;
//

@property (nonatomic, assign) NSInteger openSection;

//
@property(nonatomic,weak)JSCollectViewController * jsCollView;


@end

@implementation JwPhysicalController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新第一行数据
//    [self.tableVB reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    self.tabBarController.tabBar.hidden= NO;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    NSLog(@"%@",self.name);
    if (self.modelType) {
        [self requartData];
    }
   
    [self.tableVB reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.modelType = nil;
    self.dataSex = nil;
}

//数据请求
-(void)requartData
{
    
    NSString *gender;
    if (self.dataSex) {
        gender = self.dataSex;
    }else {
        gender = @"1";
    }
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getprorateWithPid:self.modelType.id uid:@"" gender:gender success:^(NSArray * lists,NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict) {
        [hud hide:YES];
        
        self.dataArry = [NSMutableArray array];
        self.ageArry =  [NSMutableArray array];
        
        NSArray *keyArr = [self.contentMutableDict allKeys];
        if ([keyArr containsObject:_modelType.id]) {
            [JGProgressHelper showError:@"已经选过这个险种"];
        } else {
            [self.groupMutableArr addObject:_modelType];
        }
        
        
        WHget_pro_rate * pro = [lists firstObject];
        WHmongorate * mon = [pro.mongo_rate firstObject];
        NSArray * periods = mon.rate;
        for (WHrate * rate in periods) {
            
            //保险期间
            [self.dataArry addObject:rate.period];
            //年龄
            [self.ageArry addObject:rate.age];
           NSLog(@"=====%@",rate.pay_period);
        }
        //保险期间
        self.arr1 =[NSMutableArray array];
        self.arr2 = [NSMutableArray array];
        for (int i = 0 ;i<self.dataArry.count;i++) {
            if ([_arr1 containsObject:[self.dataArry  objectAtIndex:i]] == NO) {
                [_arr1 addObject:[self.dataArry  objectAtIndex:i]];
                NSLog(@"%@",_arr1);
            }
        }
        //年龄
        for (int i = 0 ;i<self.dataArry.count;i++) {
            if ([_arr2  containsObject:[self.ageArry  objectAtIndex:i]] == NO) {
                [_arr2  addObject:[self.ageArry  objectAtIndex:i]];
                NSLog(@"%@",_arr2 );
            }
            
//            WHget_pro_rate *pro = [lists firstObject];
//            WHmongorate *mon = [pro.mongo_rate firstObject];
//            NSArray *ages = mon.rate;
//            for (WHrate *rate in ages) {
//                NSLog(@"%@", rate.age);
//                
//            }
        }
        NSMutableDictionary *pickerDict = [NSMutableDictionary dictionary];
        if (payoutArr.count != 0) {
            [pickerDict setObject:payoutArr forKey:@"给付方式"];
        }
        [pickerDict setObject:pay_periodArr forKey:@"缴费方式"];
        [pickerDict setObject:_arr1 forKey:@"保障期间"];
        [pickerDict setObject:_arr2 forKey:@"投保年龄"];

        if (![self.contentMutableDict.allKeys containsObject:_modelType.id]) {
            // 不存在
            [self.contentMutableDict setObject:pickerDict forKey:self.modelType.id];
            [self fuzhiAge:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"投保年龄"]).firstObject
                Type:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"缴费方式"]).firstObject
                Baozhang:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"保障期间"]).firstObject
                Give:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"给付方式"]).firstObject
                Key:_modelType.id
             ];
        }
        
        
        [self.tableVB reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
}

- (void)fuzhiAge:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give Key:(NSString *)key {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (((NSMutableDictionary *)[self.contentMutableDict objectForKey:key]).count == 3) {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
        [dict setObject:@"" forKey:@"保额"];
        [dict setObject:@"" forKey:@"保费"];
    }else {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
        [dict setObject:give forKey:@"给付方式"];
        [dict setObject:@"" forKey:@"保额"];
        [dict setObject:@"" forKey:@"保费"];
    }
    [self.fuzhiDict setObject:dict forKey:key];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    // 布局
//    if ([JwUserCenter sharedCenter].uid != nil) {
//         [self setupUI];
//    }
//    else
//    {
//        [JGProgressHelper showError:@"请登录账号"];
//        JwLoginController * login = [[JwLoginController alloc]init];
//        [self.navigationController pushViewController:login animated:YES];
//    }
    self.openSection = -1;
    [self setupUI];
    
//    self.groupMutableArr = [NSMutableArray array];
//    self.contentMutableDict = [NSMutableDictionary dictionary];

//    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];

    
}
-(void)left:(UIBarButtonItem *)sender
{
//    self.tabBarController.tabBar.hidden= NO;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark -- 布局
-(void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.tableVB = [[HmMultistageTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64 - 44 -15)];
    _tableVB.delegate = self;
    _tableVB.dataSource = self;
    _tableVB.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    [_tableVB mRegisterClass:[HmDetailsCodeCell class] forCellReuseIdentifier:kHmPhysicalDetailsCellIdentifier];
    [self.view addSubview:_tableVB];
    
       // 底部  开始体检 按钮
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableVB.frame)-44, CGRectGetWidth(_tableVB.frame), 44)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWitdh / 4, 7, kScreenWitdh / 2, 30)];
    [btnStart setTitle:@"开始体检" forState:UIControlStateNormal];
    [btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnStart setBackgroundColor:[UIColor colorWithHex:0x4367FF]];
    btnStart.layer.masksToBounds = YES;
    btnStart.layer.cornerRadius = 15;
    [bottomV addSubview:btnStart];
    
    [btnStart addTarget:self action:@selector(btnStart:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewSafeAction:)];
    
    //
    self.addBut = [ UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addBut.frame = CGRectMake(kScreenWitdh * 0.80, CGRectGetMinY(btnStart.frame)-30, 40, 40);
    [bottomV addSubview:_addBut];
    //self.addBut .backgroundColor = [UIColor redColor];
    [self.addBut setBackgroundImage:[UIImage imageNamed:@"p_addGroup"] forState:(UIControlStateNormal)];
    [self.addBut addTarget:self action:@selector(addButAtion:) forControlEvents:(UIControlEventTouchUpInside)];
    self.addBut.layer.cornerRadius = 20;
  
    
//    self.pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 216 - 64, kScreenWitdh, 216)];
//    _pickerV.delegate = self;
//    _pickerV.dataSource = self;
//    _pickerV.backgroundColor = [UIColor greenColor];
//    
//    self.toolBar = [self setupToolBar];
    
    

    
}

//- (UIToolbar *)setupToolBar {
//    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"收起" style:UIBarButtonItemStylePlain target:self action:@selector(keyDownAction:)];
//    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 216 - 39 - 64, kScreenWitdh, 39)];
//    toolBar.backgroundColor = [UIColor yellowColor];
//    toolBar.items = @[leftBarBtn,rightBarBtn];
//    return toolBar;
//}

//- (void)keyDownAction:(UIBarButtonItem *)sender {
//    [self removePickerVAndToolBar];
//}

//- (void)showPickerViewAndToolBar {
//    [self.view addSubview:_toolBar];
//    [self.view addSubview:_pickerV];
//}
//
//- (void)removePickerVAndToolBar {
//    [_toolBar removeFromSuperview];
//    [_pickerV removeFromSuperview];
//}

//开始体检事件
-(void)btnStart:(UIButton *)sender
{
    /*
    LYTestOneViewController * oneVC = [[LYTestOneViewController alloc]initWithNibName:@"LYTestOneViewController" bundle:nil];
    oneVC.rela_id = self.rela_id;
    oneVC.pro_id = self.ids;
    oneVC.is_main_must = self.is_main;
    oneVC.period = self.period;
    oneVC.rate = self.rate;
    
    LYTestTwoViewController * twoVC = [[LYTestTwoViewController alloc]initWithNibName:@"LYTestTwoViewController" bundle:nil];
    LYTestThreeViewController * threeVC = [[LYTestThreeViewController alloc]initWithNibName:@"LYTestThreeViewController" bundle:nil];
    
    JSCollectViewController * collectVC = [[JSCollectViewController alloc]initWithAddVCARY:@[oneVC,twoVC,threeVC] TitleS:@[@"基本信息",@"保险利益",@"分析建议"]];
    [self presentViewController:collectVC animated:YES completion:nil];

    //    NSLog(@"开始体检");
     */
    
    
    NSLog(@"jjhh%@",self.selectProID);
    
    NSLog(@"%@ %@ %@  %@ %@" ,self.selectRelaID,self.rate,self.pay_period,self.insured_amount,self.period);
    NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //读取文件路径
    NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
    
    NSString *s = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",s );
    
    
    self.selectRelaID = s ;
    if (self.selectRelaID != nil) {
    
    if (self.selectProID  != nil && self.pay_period != nil && self.rate != nil) {
        
       
  LYTestOneViewController * oneVC = [[LYTestOneViewController alloc]initWithNibName:@"LYTestOneViewController" bundle:nil];
        oneVC.rela_id = self.selectRelaID; //被保人ID
        oneVC.pro_id = self.selectProID;//险种ID
        //oneVC.is_main_must = self.is_main;
        oneVC.pay_period = self.pay_period;//缴费期间
        oneVC.rate = self.rate; //保费
        oneVC.period = self.period; //保障期间
        oneVC.payout = self.payout;
        oneVC.insured_amount = self.insured_amount; //保额
        oneVC.mblock1 = ^(CGFloat s1)
        {
           // CGFloat  s2 =  s1 ;
            
            [self.jsCollView getprogressValue:s1];
        };
        
    LYTestTwoViewController * twoVC = [[LYTestTwoViewController alloc]initWithNibName:@"LYTestTwoViewController" bundle:nil];
        twoVC.rela_id = self.selectRelaID; //被保人ID
        twoVC.pro_id = self.selectProID;//险种ID
        //oneVC.is_main_must = self.is_main;
        twoVC.pay_period = self.pay_period;//缴费期间
        twoVC.rate = self.rate; //保费
        twoVC.period = self.period; //保障期间
        twoVC.payout = self.payout;
        twoVC.insured_amount = self.insured_amount; //保额
    LYTestThreeViewController * threeVC = [[LYTestThreeViewController alloc]initWithNibName:@"LYTestThreeViewController" bundle:nil];
    
    JSCollectViewController * collectVC = [[JSCollectViewController alloc]initWithAddVCARY:@[oneVC,twoVC,threeVC] TitleS:@[@"基本信息",@"保险利益",@"分析建议"]];
        self.jsCollView = collectVC;
       
       // [collectVC getprogressValue:50.f];
    [self presentViewController:collectVC animated:YES completion:nil];
    }
    else
    {
        [JGProgressHelper showError:@"请选择险种的信息"];
    }

    }
    else
    {
        [JGProgressHelper showError:@"请选择保险险种"];
    }

}

#pragma mark --添加事件
-(void)addButAtion:(UIButton *)sender
{
    if (!_isSelectPersonName) {
        [JGProgressHelper showError:@"请先选择被保人"];
        return;
    }
    //选择公司
    WHselectCompanyViewController * company = [[WHselectCompanyViewController alloc]init];
    
    //HmSelectCompanyController * company = [[HmSelectCompanyController alloc]init];
    company.groupArr = self.groupMutableArr;
    company.isSelects = self.isSelectPersonName;
    company.contentDict = _contentMutableDict;
    company.fuzhiDict = _fuzhiDict;
    [self.navigationController pushViewController:company animated:YES];

}

#pragma mark -- Private
-(void)addNewSafeAction:(UIBarButtonItem *)sender
{
    if ([JwUserCenter sharedCenter].uid == nil) {
        [JGProgressHelper showError:@"请登录账号"];
        JwLoginController * loging = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:loging animated:YES];
    } else{
    HmSelectInsuredController *VC = [[HmSelectInsuredController alloc] init];
    [VC returnInsured:^(WHget_user_realtion *user) {
        self.firstUser = user;
        //self.selectRelaID  = user.id;
        NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        //新建文件沙盒
        NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
        NSString *loveContent = user.id;
        [loveContent writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSString *ss = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",ss );
        
        if (self.isSelectPersonName) {
            // 选过人了
            [self.groupMutableArr replaceObjectAtIndex:0 withObject:user];
        }else {
            [self.groupMutableArr insertObject:user atIndex:0];
        }
        self.isSelectPersonName = YES;
        self.dataSex = user.sex;
        [self.tableVB reloadData];
    }];
    [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark -- HmMultistageTableView DataSource
// 返回组数
- (NSInteger)numberOfSectionsInTableView:(HmMultistageTableView *)mTableView {
    return self.groupMutableArr.count;
//    return 5;
}

// 返回组内行数
- (NSInteger)mTableView:(HmMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSelectPersonName) {
        // 有人
        if (section == 0) {
            return 0;
        }
    }
    return ((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[section]).id]).count + 2;
//    return 3;
}

// cell
- (UITableViewCell *)mTableView:(HmMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 投保年龄cell
//    BOOL nibsRegistered = NO;
//    if (!nibsRegistered) {
//        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmDetailsCell class]) bundle:nil];
//        [mTableView mRegisterNib:nib forCellReuseIdentifier:kHmPhysicalDetailsCellIdentifier];
//        nibsRegistered = YES;
//    }
//    HmDetailsCell *cell = [mTableView dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier];
    
    
    
    HmDetailsCodeCell *cell = [mTableView dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier];
    if (cell == nil) {
        cell = [[HmDetailsCodeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHmPhysicalDetailsCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    HmBaoeCell *baoeCell = [self setBaoeCell:mTableView];
//    @"给付方式"];
//    @"缴费方式"];
//    @"保障期间"];
//    @"投保年龄"];
    // 赋值
    NSString *key = ((WHgetproduct *)self.groupMutableArr[indexPath.section]).id;
    id result = [self setupDataForCellCode:cell IndexPath:indexPath Age:[[_fuzhiDict objectForKey:key] objectForKey:@"投保年龄"] Type:[[_fuzhiDict objectForKey:key] objectForKey:@"缴费方式"] Baozhang:[[_fuzhiDict objectForKey:key] objectForKey:@"保障期间"] Give:[[_fuzhiDict objectForKey:key] objectForKey:@"给付方式"] BaoE:baoeCell BaoEData:[[_fuzhiDict objectForKey:key] objectForKey:@"保额"] BaoFei:[[_fuzhiDict objectForKey:key] objectForKey:@"保费"]];
    
    NSLog(@"%@,%@",cell,cell.myLaber.text);
    return result;
}

- (HmBaoeCell *)setBaoeCell:(HmMultistageTableView *)mTableView {
    HmBaoeCell *cell = [mTableView dequeueReusableCellWithIdentifier:kHmPhysicalBaoeCellIdentifier];
    if (cell == nil) {
        cell = [[HmBaoeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHmPhysicalBaoeCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)fuzhiForCellDataAge:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give IndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (((NSMutableDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[indexPath.section]).id]).count == 3) {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
    }else {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
        [dict setObject:give forKey:@"给付方式"];
    }
    NSLog(@"%ld",indexPath.section);
    [self.fuzhiDict setObject:dict forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
}

- (id)setupDataForCellCode:(HmDetailsCodeCell *)cell IndexPath:(NSIndexPath *)indexPath Age:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give BaoE:(HmBaoeCell *)baoeCell BaoEData:(NSString *)baoeData BaoFei:(NSString *)baofei {
    if (indexPath.row == 0) {
        // 投保年两
        cell.headImg.image = [UIImage imageNamed:@"p_safeYear"];
        cell.myLaber.text = @"投保年龄";
        cell.selectLaber.text = age;
        NSLog(@"吴豪%@",age);
        return cell;
    }else if (indexPath.row == 1) {
        // 缴费方式
        cell.headImg.image = [UIImage imageNamed:@"p_payType"];
        cell.myLaber.text = @"缴费方式";
        cell.selectLaber.text = type;
        self.pay_period = type;
        NSLog(@"ming%@",type);
        return cell;
    }else if (indexPath.row == 2) {
        // 保险期间
        cell.headImg.image = [UIImage imageNamed:@"p_dateDuration"];
        cell.myLaber.text = @"保障期间";
        cell.selectLaber.text = baozhang;
        self.period = baozhang;
        return cell;
    }
    if (((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[indexPath.section]).id]).count == 4) {
        if (indexPath.row == 3) {
            // 给付方式
            cell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            cell.myLaber.text = @"给付方式";
            cell.selectLaber.text = give;
            self.payout = give;
            return cell;
        }else if (indexPath.row == 4) {
            // 保额
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保额";
            baoeCell.selectLaber.enabled = YES;
            baoeCell.selectLaber.placeholder = @"请输入保额";
            [baoeCell.selectLaber addTarget:self action:@selector(baoeSelectLaberAction:) forControlEvents:UIControlEventAllEditingEvents];
            baoeCell.selectLaber.text = baoeData;
            self.insured_amount = baoeData;
            return baoeCell;
        }else {
            // 保费
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保费";
            baoeCell.selectLaber.enabled = NO;
            baoeCell.selectLaber.text = baofei;
            self.rate = baofei;
            return baoeCell;
        }
    }else {
        if (indexPath.row == 3) {
            // 保额
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保额";
            baoeCell.selectLaber.enabled = YES;
            baoeCell.selectLaber.placeholder = @"请输入保额";
            [baoeCell.selectLaber addTarget:self action:@selector(baoeSelectLaberAction:) forControlEvents:UIControlEventAllEditingEvents];
            baoeCell.selectLaber.text = baoeData;
            self.insured_amount = baoeData;
            return baoeCell;
        }else {
            // 保费
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保费";
            baoeCell.selectLaber.enabled = NO;
            baoeCell.selectLaber.text = baofei;
            self.rate = baofei;
            return baoeCell;
        }
    }
}

- (void)baoeSelectLaberAction:(UITextField *)sender {
    NSLog(@"sender.text:%@",sender.text);
    sender.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self requestForBaofeiData:textField.text];
}

- (void)requestForBaofeiData:(NSString *)sender {
//    id hud = [JGProgressHelper showProgressInView:self.view];
    NSString *uid = ((WHget_user_realtion *)self.groupMutableArr.firstObject).id;
    NSString *pid = ((WHgetproduct *)self.groupMutableArr[self.openSection]).id;
    NSString *gender = ((WHget_user_realtion *)self.groupMutableArr.firstObject).sex;
    [self.dataService getprorateWithPid:pid uid:uid gender:gender success:^(NSArray *lists, NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict) {
        WHget_pro_rate * pro = [lists firstObject];
        WHmongorate * mon = [pro.mongo_rate firstObject];
//        NSArray * periods = mon.rate;
        if ([mon.bee_type isEqualToString:@"1"]) {
            // 1   保费= 保额(自己输入的值) * 基本保费(insured) / 基本保额(pay_period)
            NSMutableDictionary *dict = [_fuzhiDict objectForKey:((WHgetproduct *)self.groupMutableArr[self.openSection]).id];
            NSString *pay = [dict objectForKey:@"缴费方式"];
            CGFloat baofei = [sender floatValue] * [mon.insured floatValue] / [[typeDict objectForKey:pay] floatValue];
            [dict setObject:sender forKey:@"保额"];
            [dict setObject:[NSString stringWithFormat:@"%ld",(long)baofei] forKey:@"保费"];
            [self.tableVB reloadData];
        }else {
            
        }
    } failure:^(NSError *error) {
        [JGProgressHelper showError:nil];
    }];
}

#pragma mark -- HmMultistageTableView Delegate
- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSelectPersonName) {
        // 有人
        if (section == 0) {
            return 90;
        }
    }
    return 44;
}

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

// 返回组头(两种)
- (UIView *)mTableView:(HmMultistageTableView *)mTableView viewForHeaderAtSection:(NSInteger)section {
    if (self.isSelectPersonName) {
        // 有人
        if (section == 0) {
            // 第一行
            HmPhySicalMainView *mainV = [[HmPhySicalMainView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 90)];
            mainV.model = self.groupMutableArr.firstObject;
            return mainV;
        }
    }
    // 没人
    HmPhysicalGroupView *groupV = [[HmPhysicalGroupView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 44)];
    groupV.model = self.groupMutableArr[section];
    return groupV;
}

- (void)mTableView:(HmMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRow ----%ld  didSelectSection ----%ld",(long)indexPath.row,(long)indexPath.section);
    HmDetailsCodeCell *cell = [self.tableVB dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier forIndexPath:indexPath];
    NSLog(@"%@",cell);
    NSLog(@"%@",cell.myLaber.text);
    NSString *key = ((WHgetproduct *)self.groupMutableArr[indexPath.section]).id;
    if (((NSDictionary *)[self.contentMutableDict objectForKey:key]).count != 3) {
        // 有给付方式
        if (indexPath.row == 0) {
            self.contentName = @"投保年龄";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"投保年龄"] Key:@"投保年龄"];
        }else if (indexPath.row == 1) {
            self.contentName = @"缴费方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"缴费方式"] Key:@"缴费方式"];
        }else if (indexPath.row == 2) {
            self.contentName = @"保障期间";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"保障期间"] Key:@"保障期间"];
        }else if (indexPath.row == 3) {
            self.contentName = @"给付方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"给付方式"] Key:@"给付方式"];
        }
    }else {
        if (indexPath.row == 0) {
            self.contentName = @"投保年龄";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"投保年龄"] Key:@"投保年龄"];
        }else if (indexPath.row == 1) {
            self.contentName = @"缴费方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"缴费方式"] Key:@"缴费方式"];
        }else if (indexPath.row == 2) {
            self.contentName = @"保障期间";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"保障期间"] Key:@"保障期间"];
        }
    }
    self.myIndexPath = indexPath;
    
    [self.tableVB reloadData];
//    if ([cell.myLaber.text isEqualToString:@"投保年龄"]) {
//        [self showPickerViewAndToolBar];
//    }else if ([cell.myLaber.text isEqualToString:@"缴费方式"]) {
//        [self showPickerViewAndToolBar];
//    }else if ([cell.myLaber.text isEqualToString:@"保障期间"]) {
//        [self showPickerViewAndToolBar];
//    }else if ([cell.myLaber.text isEqualToString:@"给付方式"]) {
//        [self showPickerViewAndToolBar];
//    }else {
//        
//    }
//    [self.pickerV reloadAllComponents];
}

#pragma mark -- Header Open Or Close
- (void)mTableView:(HmMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section {
    NSLog(@"Oper Header ----%ld",(long)section);
    self.openSection = section;
}

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section {
    NSLog(@"Close Header ----%ld",(long)section);
}

#pragma mark -- Row Open Or Close
- (void)mTableView:(HmMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Open Row ----%ld",(long)indexPath.row);
}

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Close Row ----%ld",(long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- GETTER
-(NSMutableArray *)groupMutableArr {
    if (_groupMutableArr == nil) {
        _groupMutableArr = [NSMutableArray array];
    }
    return _groupMutableArr;
}

- (NSMutableDictionary *)contentMutableDict {
    if (_contentMutableDict == nil) {
        _contentMutableDict = [NSMutableDictionary dictionary];
    }
    return _contentMutableDict;
}

- (NSMutableDictionary *)fuzhiDict {
    if (_fuzhiDict == nil) {
        _fuzhiDict = [NSMutableDictionary dictionary];
    }
    return _fuzhiDict;
}

//#pragma mark -- Picker View Delegate
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    //    [pickerDict setObject:payoutArr forKey:@"给付方式"];
//    //    [pickerDict setObject:pay_periodArr forKey:@"缴费方式"];
//    //    [pickerDict setObject:_arr1 forKey:@"保障期间"];
//    //    [pickerDict setObject:_arr2 forKey:@"投保年龄"];
//    if ([self.contentName isEqualToString:@"投保年龄"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"投保年龄"]).count;
//    }else if ([self.contentName isEqualToString:@"缴费方式"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"缴费方式"]).count;
//    }else if ([self.contentName isEqualToString:@"保障期间"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"保障期间"]).count;
//    }else if ([self.contentName isEqualToString:@"给付方式"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"给付方式"]).count;
//    }else {
//        return 0;
//    }
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if ([self.contentName isEqualToString:@"投保年龄"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"投保年龄"])[row];
//    }else if ([self.contentName isEqualToString:@"缴费方式"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"缴费方式"])[row];
//    }else if ([self.contentName isEqualToString:@"保障期间"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"保障期间"])[row];
//    }else if ([self.contentName isEqualToString:@"给付方式"]) {
//        return ((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"给付方式"])[row];
//    }else {
//        return @"";
//    }
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    HmDetailsCodeCell *cell = [self.tableVB dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier forIndexPath:_myIndexPath];
//    NSLog(@"111%@%@",_contentName,cell.selectLaber.text);
//    if ([self.contentName isEqualToString:@"投保年龄"]) {
//        NSMutableDictionary *dic = [_fuzhiDict objectForKey:[NSString stringWithFormat:@"%ld",_myIndexPath.section]];
//        [dic setValue:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"投保年龄"])[row] forKey:@"投保年龄"];
//        NSLog(@"%@",((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"投保年龄"])[row]);
//    }else if ([self.contentName isEqualToString:@"缴费方式"]) {
//        NSMutableDictionary *dic = [_fuzhiDict objectForKey:[NSString stringWithFormat:@"%ld",_myIndexPath.section]];
//        [dic setValue:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"缴费方式"])[row] forKey:@"缴费方式"];
//        NSLog(@"%@",((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"缴费方式"])[row]);
//    }else if ([self.contentName isEqualToString:@"保障期间"]) {
//        NSMutableDictionary *dic = [_fuzhiDict objectForKey:[NSString stringWithFormat:@"%ld",_myIndexPath.section]];
//        [dic setValue:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"保障期间"])[row] forKey:@"保障期间"];
//        
//        NSLog(@"%@",((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"保障期间"])[row]);
//    }else if ([self.contentName isEqualToString:@"给付方式"]) {
//        NSMutableDictionary *dic = [_fuzhiDict objectForKey:[NSString stringWithFormat:@"%ld",_myIndexPath.section]];
//        [dic setValue:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"给付方式"])[row] forKey:@"给付方式"];
//        
//        NSLog(@"%@",((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"给付方式"])[row]);
//    }else {
//        
//    }
////    [self.tableVB reloadRowsAtIndexPaths:@[_myIndexPath] withRowAnimation:(UITableViewRowAnimationNone)];
//    
//    [self fuzhiForCellDataAge:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"投保年龄"]).firstObject Type:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"缴费方式"]).firstObject Baozhang:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"保障期间"]).firstObject Give:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id]) objectForKey:@"给付方式"]).firstObject IndexPath:_myIndexPath];
//    
//    [self.tableVB reloadData];
//    
//    NSLog(@"%@",cell.myLaber.text);
//}

#pragma mark -- HMConfirmView Setting
- (void)showAlertViewWithArr:(NSArray *)arr Key:(NSString *)key {
    _confir = [[HMConfirmView alloc] initWithFrame:[self.navigationController.view superview].bounds];
    _confir.itemArr = arr;
    _confir.delegate = self;
    _confir.key = key;
    _confir.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    [self.view addSubview:_confir];
}

#pragma mark -- HMConfirmView Delegate
- (void)confirmActionWithIndexOfArr:(NSInteger)index SelectName:(NSString *)name Key:(NSString *)key {
//    [[_fuzhiDict objectForKey:[NSString stringWithFormat:@"%ld",_myIndexPath.section]] setObject:name forKey:key];
    NSMutableDictionary *dict = [_fuzhiDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id];
    [dict setObject:name forKey:key];
    [self requestForBaofeiData:[dict objectForKey:@"保额"]];
    [self.tableVB reloadData];
    [_confir removeFromSuperview];
}



- (void)cancelActionWithNothing {
    [_confir removeFromSuperview];
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
