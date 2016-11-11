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
#import "WHresultViewController.h"
#import "WHageTableViewController.h"


#define kHmPhysicalGroupCellIdentifier @"kHmPhysicalGroupCellIdentifier"
#define kHmPhysicalMainCellIdentifier @"kHmPhysicalMainCellIdentifier"
#define kHmPhysicalDetailsCellIdentifier @"kHmPhysicalDetailsCellIdentifier"
#define kHmPhysicalFujiaCellIdentifier @"kHmPhysicalFujiaCellIdentifier"

@interface JwPhysicalController ()<UITableViewDelegate,UITableViewDataSource>

// 大TableView
@property (nonatomic, strong) UITableView *tableVB;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) WHget_user_realtion *firstUser;
@property(nonatomic,strong)UIButton * addBut;


@end

@implementation JwPhysicalController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 刷新第一行数据
    [self.tableVB reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    self.tabBarController.tabBar.hidden=YES;
    NSLog(@"%@",self.name);
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 布局
    [self setupUI];
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];

    
}
-(void)left:(UIBarButtonItem *)sender
{
    self.tabBarController.tabBar.hidden=NO;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark -- 布局
-(void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.tableVB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64 - 44) style:UITableViewStylePlain];
    _tableVB.delegate = self;
    _tableVB.dataSource = self;
    _tableVB.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    _tableVB.separatorStyle = UITableViewCellSeparatorStyleNone;
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
  
    
}

//开始体检事件
-(void)btnStart:(UIButton *)sender
{
    NSLog(@"开始体检");
    WHresultViewController * result = [[WHresultViewController alloc]init];
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark --添加事件
-(void)addButAtion:(UIButton *)sender
{
    //选择公司
    HmSelectCompanyController * company = [[HmSelectCompanyController alloc]init];
    [self.navigationController pushViewController:company animated:YES];

}

#pragma mark -- Private
-(void)addNewSafeAction:(UIBarButtonItem *)sender
{
    HmSelectInsuredController *VC = [[HmSelectInsuredController alloc] init];
    [VC returnInsured:^(WHget_user_realtion *user) {
        self.firstUser = user;
    }];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark -- Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3 + 1 - 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        if (section == self.selectedSection && self.selectedSection != 0) {
            // 点击的是同一个section且非第一次
            if (self.isOpen) {
                // 展开
                return 8;
            }
            else
            {
                // 收缩
                return 1;
            }
        }
        else
        {
            // 点击的不是同一个section
            return 1;
        }
    }
//    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // HmPhysicalMainPageCell
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmPhysicalMainPageCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:kHmPhysicalMainCellIdentifier];
            nibsRegistered = YES;
        }
        HmPhysicalMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:kHmPhysicalMainCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.firstUser) {
           cell.model = self.firstUser;
            //cell.lblName.text = self.name;
           
        }
        return cell;

    }
    else
    {
        if (indexPath.section == self.selectedSection && self.selectedSection != 0) {
            if (self.isOpen) {
                // 展开cell
                if (indexPath.row == 0) {
                    // 组头
                                      
                }
                else
                {
                    if (indexPath.row >= 1 && indexPath.row <= 4) {
                        // 投保年龄cell
                        BOOL nibsRegistered = NO;
                        if (!nibsRegistered) {
                            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmDetailsCell class]) bundle:nil];
                            [tableView registerNib:nib forCellReuseIdentifier:kHmPhysicalDetailsCellIdentifier];
                            nibsRegistered = YES;
                            
                        }
                        HmDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier];
                        if (indexPath.row == 1) {
                            cell.myLaber.text = @"投保年龄";
                            cell.headImg.image = [UIImage imageNamed:@"p_safeYear"];
                        }
                        if (indexPath.row == 2) {
                            cell.myLaber.text = @"缴费方式";
                            cell.headImg.image = [UIImage imageNamed:@"p_payType"];
                        }
                        if (indexPath.row == 3) {
                            cell.myLaber.text = @"保险期间";
                            cell.headImg.image = [UIImage imageNamed:@"p_dateDuration"];
                        }
                        
                        if (indexPath.row == 4) {
                            cell.myLaber.text = @"保额(元)";
                            cell.headImg.image = [UIImage imageNamed:@"test_money"];
                        }
                        


                        
                        
                        return cell;
                    }
                    else
                    {
                        // 附
                        BOOL nibsRegistered = NO;
                        if (!nibsRegistered) {
                            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmFujiaCell class]) bundle:nil];
                            [tableView registerNib:nib forCellReuseIdentifier:kHmPhysicalFujiaCellIdentifier];
                            nibsRegistered = YES;
                        }
                        HmFujiaCell *cell = [tableView dequeueReusableCellWithIdentifier:kHmPhysicalFujiaCellIdentifier];
                        
                        return cell;
                    }
                }
            }
            else
            {
                // 收缩cell
            }
        }
        // HmPhysicalGroupCell
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmPhysicalGroupCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:kHmPhysicalGroupCellIdentifier];
            nibsRegistered = YES;
        }
        HmPhysicalGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:kHmPhysicalGroupCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.btnDelete.tag = indexPath.section;
        if (![self.name isEqualToString:@""]) {
            cell.lblName.text = self.name;
        }
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // HmPhysicalMainPageCell
        return 90;
    }
    else
    {
        // HmPhysicalGroupCell
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen && indexPath.section != self.selectedSection) {
        // 有一项已经展开
        HmPhysicalGroupCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.selectedSection]];
        
        DLog(@"关闭Cell(上次展开的cell)组数:%ld,行数:%d", self.selectedSection,0);
        cell.imgListDown.image = [UIImage imageNamed:@"p_listDown"];
    }
    HmPhysicalGroupCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSLog(@"kkk");
        WHageTableViewController * age = [[WHageTableViewController alloc]init];
        [self.navigationController pushViewController:age animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSLog(@"22");
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        NSLog(@"33");
    }
    if (indexPath.section == 1 && indexPath.row == 4) {
        NSLog(@"44");
    }

    
    
    if (indexPath.section != 0 && indexPath.row == 0) {
        if ([cell.imgListDown.image isEqual:[UIImage imageNamed:@"p_listDown"]]) {
            // 向下  改为向上
            DLog(@"点击要展开的cell的组数:%ld, 行数:%ld", indexPath.section,indexPath.row);
            cell.imgListDown.image = [UIImage imageNamed:@"p_listUp"];
            self.isOpen = YES;
            
        }
        else
        {
            // 向上  改为向下
            DLog(@"点击要收缩的cell的组数:%ld, 行数:%ld", indexPath.section,indexPath.row);
            cell.imgListDown.image = [UIImage imageNamed:@"p_listDown"];
            self.isOpen = NO;
        }
        self.selectedSection = indexPath.section;
        [tableView reloadData];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
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
