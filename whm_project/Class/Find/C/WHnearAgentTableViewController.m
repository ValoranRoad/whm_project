//
//  WHnearAgentTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnearAgentTableViewController.h"
#import "MacroUtility.h"
#import "WHnearAgentTableViewCell.h"
#import "CityTableViewCell.h"
#import "JwAreass.h"
#import "JGProgressHelper.h"
#import "WHgetnearagent.h"
#import "WHnearagentdata.h"
#import <UIImageView+WebCache.h>

@interface WHnearAgentTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHnearAgentTableViewController * cell;
@property(nonatomic,strong)NSString * tel;
//导航栏数据
@property (nonatomic,strong)UIView *cityChooseBackView;//弹出框
@property (nonatomic,strong)UIButton *myAddressBtn;
@property (nonatomic,strong)UIButton *myCategoryBtn;


@property (nonatomic,strong)UILabel *titleLab;//上部标题
@property (nonatomic,strong)UITableView *provinceTableView;//省
@property (nonatomic,strong)UITableView *cityTableView;//市
@property (nonatomic,strong)UITableView *areaTableView;//区

@property (nonatomic,strong)NSArray *provenceArr;//存放省的数组
@property (nonatomic,strong)NSArray *cityArr;//存放市的数组
@property(nonatomic,strong)NSArray * areaArr;

@property (nonatomic,strong)UIImageView *arrowProImage;

@property (nonatomic,strong)UIImageView *arrowCartogyImage;

//数据源
@property(nonatomic,strong)NSMutableArray * dataArry;

@property(nonatomic,strong)NSString * nearID;
@property(nonatomic,strong)NSString * StrDist;
@property(nonatomic,strong)NSMutableArray * imgArry;
@property(nonatomic,strong)NSMutableArray * mobileArry;
@property(nonatomic,strong)NSMutableArray * comArry;
@property(nonatomic,strong)NSMutableArray * ageArry;
@property(nonatomic,strong)NSMutableArray * sexArry;
@property(nonatomic,strong)NSMutableArray * profeArry;
@property(nonatomic,strong)NSMutableArray * workArry;
@property(nonatomic,strong)NSMutableArray * servArry;

@end

@implementation WHnearAgentTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.dataArry = [NSMutableArray array];
    self.ageArry = [NSMutableArray array];
    self.profeArry = [NSMutableArray array];
    self.imgArry = [NSMutableArray array];
    self.mobileArry = [NSMutableArray array];
    self.sexArry = [NSMutableArray array];
    self.comArry = [NSMutableArray array];
    self.workArry = [NSMutableArray array];
    self.servArry = [NSMutableArray array];
    [self quartDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _provenceArr = [NSArray array];
    _cityArr = [NSArray array];
    _areaArr = [NSArray array];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    self.areaDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.title = @"附近代理人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ditudao"] style:(UIBarButtonItemStylePlain) target:self action:@selector(aa:)];
  
    [self setupUI];
  
}
//右边点击事件
-(void)aa:(UIBarButtonItem *)sender
{
    NSLog(@"lll");
}

//数据请求
-(void)quartDate
{
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getnearagentWithLng:stringOne
                                      lat:stringTwo
                                city_name:@""
                                 province:@""
                                     city:@""
                                   county:@""
                                     type:@"agent" success:^(NSArray *lists) {
                                         [hud hide:YES];
                                       //  self.dataArry = [NSMutableArray arrayWithArray:lists];
                                       //  NSLog(@"%@",self.dataArry);
                                         for (WHgetnearagent * near in lists) {
                                            self.nearID = near.id;
                                            self.StrDist = near.dist;
                                             NSLog(@"oo%@",self.StrDist);
                                             NSLog(@"ppp%@",near.data.name);
                                             [self.dataArry addObject:near.data.name];
                                             [self.ageArry addObject:near.data.age];
                                             [self.imgArry addObject:near.data.avatar];
                                             if (near.data.profession == nil) {
                                                 near.data.profession = @"暂无";
                                             }
                                             [self.profeArry addObject:near.data.profession];
                                             [self.sexArry addObject:near.data.sex];
                                             if (near.data.com_name == nil) {
                                                 near.data.com_name = @"暂无";
                                             }
                                             [self.comArry addObject:near.data.com_name];
                                             [self.mobileArry addObject:near.data.mobile];
                                             [self.workArry addObject:near.data.work_time];
                                             [self.servArry addObject:near.data.service_area];
                                             
                                         }
                                         
        
                                         [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
    
}

- (void)setAreaDict:(NSDictionary *)areaDict
{
    _areaDict = areaDict;
    [self selectedProvinceIndex:0 cityIndex:0];
    
}
- (void)selectedProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex
{
    //取出省
    NSArray *components = [_areaDict allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [NSMutableArray array];
    for (int i = 0; i < sortedArray.count; i ++) {
        NSString *index = sortedArray[i];
        NSArray *tmp = [[_areaDict objectForKey:index] allKeys];
        [provinceTmp addObject:tmp[0]];
    }
    
    _provenceArr = [NSArray arrayWithArray:provinceTmp];
    
    //取出市
    NSString *index = sortedArray[provinceIndex];
    NSString *selected = _provenceArr[provinceIndex];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[[_areaDict objectForKey:index] objectForKey:selected]];
    NSArray *cityComponents = [dic allKeys];
    NSArray *citySortedArray = [cityComponents sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    NSMutableArray *cityTmp = [NSMutableArray array];
    for (int i = 0; i < citySortedArray.count; i ++) {
        NSString *index = citySortedArray[i];
        NSArray *tmp = [[dic objectForKey:index] allKeys];
        [cityTmp addObject:tmp[0]];
    }
    
    _cityArr = [NSArray arrayWithArray:cityTmp];
    
    //    //取出区
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:citySortedArray[cityIndex]]];
    NSArray *array = [[NSArray alloc] initWithArray:[cityDic allKeys]];
    
    NSString *selectedCity = array[0];
    self.areaArr = [[NSArray alloc] initWithArray:cityDic[selectedCity]];
}



//设计界面
-(void)setupUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, kScreenWitdh, kScreenHeight - 64-35) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];

    [self.tableV registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];
    //
    self.myAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myAddressBtn.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame)/2-0.5, 30);
    [self.myAddressBtn setTitle:@"省市区" forState:UIControlStateNormal];
    [self.myAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myAddressBtn addTarget:self action:@selector(myaddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.myAddressBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myAddressBtn];
    
    self.arrowProImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.myAddressBtn.frame) - 30, CGRectGetHeight(self.myAddressBtn.frame)/2 - 10, 20, 20)];
    //self.arrowProImage.backgroundColor = [UIColor redColor];
    self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
    [self.myAddressBtn addSubview:_arrowProImage];
    
    
    
    
    self.myCategoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myCategoryBtn.frame = CGRectMake(CGRectGetMaxX(self.myAddressBtn.frame) + 1, 0,CGRectGetWidth(self.view.frame)/2-0.5, 30);
    [self.myCategoryBtn setTitle:@"类别" forState:UIControlStateNormal];
    [self.myCategoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myCategoryBtn addTarget:self action:@selector(myCategoryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.myCategoryBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myCategoryBtn];
    
    
    self.arrowCartogyImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.myAddressBtn.frame) - 30, CGRectGetHeight(self.myAddressBtn.frame)/2 - 10, 20, 20)];
    //self.arrowProImage.backgroundColor = [UIColor redColor];
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrowT.png"];
    [self.myCategoryBtn addSubview:_arrowCartogyImage];
    
    
    
    
    _cityChooseBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 94)];
    _cityChooseBackView.backgroundColor = [UIColor yellowColor];
    _cityChooseBackView.hidden = YES;
    [self.view addSubview:_cityChooseBackView];
    
    
    //省
    self.provinceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame) - 94) style:UITableViewStylePlain];
    self.provinceTableView.delegate = self;
    self.provinceTableView.dataSource = self;
    self.provinceTableView.tableFooterView = [UIView new];
    self.provinceTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_provinceTableView];
    [self.provinceTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ProlistCell"];
    
    
    //市
    self.cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceTableView.frame), 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame) - 94) style:UITableViewStylePlain];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.tableFooterView = [UIView new];
    self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_cityTableView];
    self.cityTableView.hidden = YES;
    
    [self.cityTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"CitylistCell"];
    
    
    //区
    self.areaTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityTableView.frame), 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame) - 94) style:UITableViewStylePlain];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.tableFooterView = [UIView new];
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_areaTableView];
    self.areaTableView.hidden = YES;
    
    [self.areaTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ArealistCell"];
    

}
#pragma mark 省市点击事件
-(void)myaddressBtnAction
{
    //UIView *backView = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    _cityChooseBackView.hidden = NO;
    
    self.arrowProImage.image = [UIImage imageNamed:@"arrow.png"];
}

#pragma mark 类别点击事件
-(void)myCategoryBtnAction
{
    NSLog(@"点击了类别筛选");
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrow.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (tableView == _provinceTableView)
    {
        return _provenceArr.count;
    }
    else if(tableView == _cityTableView)
    {
        return _cityArr.count;
    }
    else  if (tableView == _tableV) {
        return self.dataArry.count;
    }

    else
    {
        return _areaArr.count;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _provinceTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProlistCell" forIndexPath:indexPath];
        cell.titLab.text = self.provenceArr[indexPath.row];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    else if(tableView == _cityTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitylistCell" forIndexPath:indexPath];
        cell.titLab.text = self.cityArr[indexPath.row];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    else if (tableView == _tableV)
    {
        WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
             [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
            [cell.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
            cell.mesBut.tag = 100 + indexPath.row;
        
            cell.telBut.tag = 100 + indexPath.row;
            [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [cell.mesBut addTarget:self action:@selector(mesButAction:) forControlEvents:(UIControlEventTouchUpInside)];
           cell.nameLaber.text = self.dataArry[indexPath.row];
           [cell.myImage sd_setImageWithURL:[NSURL URLWithString:self.imgArry[indexPath.row]]];
        if ([self.sexArry[indexPath.row] isEqualToString: @"2"]) {
            cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
        }else
        {
            cell.sexImg.image = [UIImage imageNamed:@"test_male"];
        }
        cell.ageLaber.text = self.ageArry[indexPath.row];
        cell.professLaber.text = self.profeArry[indexPath.row];
        cell.companyLaber.text = self.comArry[indexPath.row];
        cell.workLaber.text = self.workArry[indexPath.row];
        cell.areaLaber.text = self.servArry[indexPath.row];
        
        
            return cell;

    }
    else
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArealistCell" forIndexPath:indexPath];
        cell.titLab.text = self.areaArr[indexPath.row];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    

}
#pragma mark 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger myIntag;
    if (tableView == _provinceTableView)
    {
        self.cityTableView.hidden = NO;
        //这里面根据不同的省的id   改变_cityArr数组的数据，并刷新cityTableView
        //JwAreass * area = self.provenceArr[indexPath.row];
        
        [self selectedProvinceIndex:indexPath.row cityIndex:0];
        myIntag = indexPath.row;

        
        
        [self.cityTableView reloadData];
    }
    else if(tableView ==_cityTableView)
    {
        NSInteger provinceIndex =  _provinceTableView.indexPathForSelectedRow.row;
        [self selectedProvinceIndex:provinceIndex cityIndex:indexPath.row];
        [self.areaTableView reloadData];

        
        self.areaTableView.hidden = NO;
        //这里要根据你取出市的id，重新请求数据，然后弹出区的tableview。
        
    }
    else
    {
        
        self.cityChooseBackView.hidden = YES;
        [self.myAddressBtn setTitle:self.areaArr[indexPath.row] forState:UIControlStateNormal];
        
        //改变小箭头
        self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
        //这里要根据你取出区的id，重新请求数据，然后刷新下方的tableview
        
        
    }
}






//信息事件
-(void)mesButAction:(UIButton *)sender
{
    NSLog(@"message");
}

//电话事件
-(void)telAction:(UIButton *)sender
{
   self.tel = self.mobileArry[sender.tag - 100];
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];
    
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableV) {
        return 100;
    }
    return 40;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
