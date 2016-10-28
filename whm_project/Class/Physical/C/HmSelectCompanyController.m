//
//  HmSelectCompanyController.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmSelectCompanyController.h"
#import "HmCompanyTableCell.h"
#import "HmCompanyCollectionCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "HmHotCompanyCell.h"
#import "CMIndexBar.h"
#import "JGProgressHelper.h"
#import "NSString+PinYin.h"



#define HmCompanyTabelCellIdentifier @"HmCompanyTabelCellIdentifier"
#define HmCompanyCollecteI @"HmCompanyCollecteIdentifier"


@interface HmSelectCompanyController ()<UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>
{
    CMIndexBar *indexBar;
}

@property (nonatomic, strong) UITableView *tableV;

// 组数组
@property (nonatomic, strong) NSArray *arrayOfGroups;
//数据
@property(nonatomic,strong)NSMutableArray * dataArry;

@property(nonatomic,strong)NSMutableArray * hotArry;


@end

@implementation HmSelectCompanyController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 请求数据
    [self requestData];
    
    [self hotData ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfGroups = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    // 布局
    [self setupUI];
    
    // 索引
    [self createIndexList];
}
// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    NSString * s1  = @"1";
    NSString * s2 = [s1 stringByAppendingString:@",2"];
    NSLog(@"%@",s2);
    
    [self.dataService get_CompanysWithType:s2 success:^(NSArray *lists) {
        [hud  hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"失败"];
        
    }];
    
}

//热门公司数据请求
-(void)hotData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [hud  hide:YES];
    [self.dataService get_hot_companyWithsuccess:^(NSArray *lists) {
       
        self.hotArry = [NSMutableArray arrayWithArray:lists];
        NSLog(@"==%@",self.hotArry);
        
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        
    }];
    
    
}
#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"选择公司";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
}

#pragma mark -- CMIndexBar Delegate
-(void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    if (self.arrayOfGroups.count < index) {
        return;
    }
    [_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
//    [_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    

}

#pragma mark -- Private
-(void)createIndexList
{
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(kScreenWitdh - 12, 0, 12, self.tableV.frame.size.height)];
    indexBar.textColor = [UIColor colorWithHex:0x666666];
    indexBar.textFont = [UIFont systemFontOfSize:11];
    indexBar.delegate = self;
    [indexBar setIndexes:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    [self.view addSubview:indexBar];
}

#pragma mark -- Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3 + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return self.dataArry.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 热门公司
        HmHotCompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:HmCompanyCollecteI];
        if (cell == nil) {
            cell = [[HmHotCompanyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:HmCompanyCollecteI];
            
        }
        //cell.model =self.hotArry[indexPath.row];
        return cell;
    }
    else
    {
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmCompanyTableCell class]) bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:HmCompanyTabelCellIdentifier];
            nibsRegistered = YES;
        }
        HmCompanyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:HmCompanyTabelCellIdentifier];
        cell.model = self.dataArry[indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 热门公司
        return (kScreenWitdh - 3) / 3 * 2 + 1.5;
    }
    else
    {
        return 60;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"A";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 30)];
    headView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, kScreenWitdh - 6 * 2, 20)];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor colorWithHex:0x666666];
    lbl.text = @"B";
    [headView addSubview:lbl];
    
    return headView;
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
