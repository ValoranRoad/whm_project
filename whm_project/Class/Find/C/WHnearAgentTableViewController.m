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
#import "WHnearMapViewController.h"
#import "WHmaplistTableViewController.h"
#import "WHLookforViewController.h"
#import "JwCompanys.h"
#import "completeTableViewCell.h"

#import "MJRefresh.h"

@interface WHnearAgentTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
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
@property(nonatomic,strong)NSMutableArray * sexArry;
@property(nonatomic,strong)NSMutableArray * addressArry;
@property(nonatomic,strong)NSMutableArray * distArry;
@property(nonatomic,strong)NSMutableArray * telArry;
@property(nonatomic,strong)NSMutableArray * mtitArry;
@property(nonatomic,strong)NSMutableArray * ageArry;

@property(nonatomic,strong)NSMutableArray * agentIdArry;
@property(nonatomic,strong)NSString * agentID;


@property(nonatomic,strong)NSString * s ;
@property(nonatomic,strong)UITableView * companyTableView;//公司筛选
@property(nonatomic,strong)NSMutableArray * companyArr;
@property(nonatomic,strong)UIView * companyBackView; //公司试图
@property(nonatomic,strong)NSString * companyID;

@property(nonatomic,strong)UIView * titleView;
@property(nonatomic,assign)NSInteger numindex;

@end

@implementation WHnearAgentTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.dataArry = [NSMutableArray array];
    self.imgArry = [NSMutableArray array];
    self.mobileArry = [NSMutableArray array];
    self.sexArry = [NSMutableArray array];
    self.comArry = [NSMutableArray array];
    self.addressArry = [NSMutableArray array];
    self.distArry = [NSMutableArray array];
    self.telArry = [NSMutableArray array];
    //
    self.mtitArry = [NSMutableArray array];
    self.ageArry = [NSMutableArray array];
    self.agentIdArry = [NSMutableArray array];
    
   // [self quartDate];
    //
  [self setupRefresh];
    
    [self data];
    
}
//刷新
-(void)setupRefresh
{
    [self.tableV addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"thable"];
    [self.tableV headerBeginRefreshing];
    [self.tableV addFooterWithTarget:self action:@selector(footerRefreshing )];

    
}
//下拉刷新
-(void)headerRereshing
{
    self.numindex = 1 ;
    //self.numindex ++;
    [self quartDate];
}
//上拉加载
-(void)footerRefreshing
{
    
    
    self.numindex ++ ;
    if (self.dataArry.count <= 10) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
    [self quartDate];
    }
}

-(void)data
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_CompanysWithType:@"1,2" success:^(NSArray *lists) {
        [hud hide:YES];
//        for (JwCompanys * model in lists) {
//            [self.companyArr addObject:model.name];
//        }
          self.companyArr = [NSMutableArray arrayWithArray:lists];
        [self.companyTableView reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
    }];
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
    WHmaplistTableViewController * mapList = [[WHmaplistTableViewController alloc]init];
    [self.navigationController pushViewController:mapList animated:YES];
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
                                     type:@"agent"
                                 distance:@""
                                      map:@""
                                        p:[NSString stringWithFormat:@"%ld",self.numindex]
                                 pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 15]
                                  success:^(NSArray *lists) {
                                         [hud hide:YES];
                                       //  self.dataArry = [NSMutableArray arrayWithArray:lists];
                                       //  NSLog(@"%@",self.dataArry);
                                         for (WHgetnearagent * near in lists) {
                                            self.nearID = near.id;
                                            self.StrDist = near.dist;
                                             //代理人ID
                                             [self.agentIdArry addObject:near.id];
                                             //小数点处理
                                             float  f = [near.dist floatValue];
                                             int a = (int)f;
                                            // NSLog(@"====%d",a);
                                             if (a >= 1000) {
                                                 int  b = a /1000;
                                                // NSLog(@"LLL%d",b);
                                                 NSString * s1 = [NSString stringWithFormat:@"%d",b];
                                                 self.s = [s1 stringByAppendingString:@"KM"];
                                             }
                                             else
                                             {
                                                 NSString * s2  = [NSString stringWithFormat:@"%d",a];
                                                 self.s = [s2 stringByAppendingString:@"M"];
                                             }
                                             [self.distArry addObject:self.s];//距离
                                             
                                             
                                             
                                            // NSLog(@"oo%@",self.StrDist);
                                            // NSLog(@"ppp%@",near.data.name);
                                             [self.dataArry addObject:near.data.name];
            
                                             [self.imgArry addObject:near.data.avatar];
                                             [self.sexArry addObject:near.data.sex];
                                             if (near.data.com_name == nil) {
                                                 near.data.com_name = @"公司不详";
                                             }
                                             [self.comArry addObject:near.data.com_name];
                                             [self.mobileArry addObject:near.data.mobile];
                                             if (near.data.job_address == nil) {
                                                 near.data.job_address = @"地址不详";
                                             }
                                             [self.addressArry addObject:near.data.job_address];
                                             [self.telArry addObject:near.data.mobile];
                                             
                                             if (near.data.work_time == nil) {
                                                 near.data.work_time = @"";
                                             }
                                             if (near.data.profession == nil) {
                                                 near.data.profession = @"";
                                             }
                                             if (near.data.service_area == nil) {
                                                 near.data.service_area = @"";
                                             }
                                             NSString * strLab = [near.data.com_name stringByAppendingString:near.data.profession];
                                             NSString * strWork = [strLab stringByAppendingString:near.data.work_time];
                                             NSString * strArea = [strWork stringByAppendingString:near.data.service_area];
                                             [self.mtitArry addObject:strArea];
                                             if (near.data.age.length < 1) {
                                                 near.data.age = @"0";
                                             }
                                             [self.ageArry addObject:near.data.age];
                                             
                                             
                                             
                                         }
                                         
                                      [self.tableV headerEndRefreshing];
                                      [self.tableV footerEndRefreshing];
                                      
                                         [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"没有数据"];
        
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
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * address = [ud stringForKey:@"address"];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, kScreenWitdh, kScreenHeight - 64-35) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];

    [self.tableV registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];
    //
    self.myAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myAddressBtn.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame)/2-0.5, 30);
    [self.myAddressBtn setTitle:[NSString stringWithFormat:@"%@",address] forState:UIControlStateNormal];
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
    _cityChooseBackView.hidden = NO;
    
    self.arrowProImage.image = [UIImage imageNamed:@"arrow.png"];
}

#pragma mark 类别点击事件
-(void)myCategoryBtnAction
{
    
   _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [_titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    searchBar.backgroundColor = color;
    //searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"请输入关键词";
    [_titleView addSubview:searchBar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = _titleView;
    NSLog(@"点击了类别筛选");
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrow.png"];
    self.companyBackView  = [[UIView alloc]init];
    self.companyBackView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 94);
    self.companyBackView.backgroundColor = [UIColor whiteColor];
    //self.companyBackView.hidden = YES;
    [self.view addSubview:_companyBackView];
    self.companyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_companyBackView.frame), CGRectGetHeight(self.view.frame) - 94) style:UITableViewStylePlain];
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    self.companyTableView.tableFooterView = [UIView new];
    self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.companyBackView addSubview:_companyTableView];
   
    [self.companyTableView registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"CompanyCell"];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@"" keyword:searchBar.text  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:@"1" pagesize:@"10" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.companyArr = [NSMutableArray arrayWithArray:lists];
        [self.companyTableView reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"没有数据"];
        
    }];
    
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

    else if (tableView == _companyTableView)
    {
        return _companyArr.count;
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
    else if (tableView == _companyTableView)
    {
        completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCell" forIndexPath:indexPath];
        JwCompanys * model = self.companyArr[indexPath.row];
        
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell.titleLab.text = model.name;
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
        
        
            cell.telBut.tag = 100 + indexPath.row;
            [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
           cell.nameLaber.text = self.dataArry[indexPath.row];
        
        if ([self.imgArry[indexPath.row ]isEqualToString:@"0"]) {
            cell.myImage.image = [UIImage imageNamed:@"Jw_user"];
        }else
        {
            [cell.myImage sd_setImageWithURL:[NSURL URLWithString:self.imgArry[indexPath.row]]];
        }
        
        if ([self.sexArry[indexPath.row] isEqualToString: @"2"]) {
            cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
        }else
        {
            cell.sexImg.image = [UIImage imageNamed:@"test_male"];
        }
        cell.mapImg.image = [UIImage imageNamed:@"maple"];
        cell.telImg.image = [UIImage imageNamed:@"tel"];
        cell.addressLaber.text = self.addressArry[indexPath.row];
        cell.telLaber.text = self.telArry[indexPath.row];
        cell.companyLaber.text = self.comArry [indexPath.row];
        cell.mapLaber.text = self.distArry[indexPath.row];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
        cell.myImage.userInteractionEnabled = YES;
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [cell.myImage addGestureRecognizer:tapGesture];
       // cell.myImage.tag = 100 + indexPath.row;
        self.agentID = self.agentIdArry[indexPath.row];
        
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

//图片点击事件
-(void)onClickUILable:(UITapGestureRecognizer *)sender{
   // NSLog(@"kk");
    WHLookforViewController * look = [[WHLookforViewController alloc]init];
    look.StrAgentId = self.agentID;
    look.selectDiffent = @"1";
    [self.navigationController pushViewController:look animated:YES];
    
    
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
    else if (tableView == _tableV)
    {
        WHnearMapViewController * map = [[WHnearMapViewController alloc]init];
        map.p_myImg = self.imgArry[indexPath.row];
        map.p_myName = self.dataArry[indexPath.row];
        map.p_mySex = self.sexArry[indexPath.row];
        map.p_myPro = self.mtitArry[indexPath.row];
        map.p_myMobile = self.mobileArry[indexPath.row];
        map.p_myAge = self.ageArry[indexPath.row];
        
        [self.navigationController pushViewController:map animated:YES];
    }
    else if (tableView == _companyTableView)
    {
        self.titleView.hidden = YES;
        self.companyBackView.hidden = YES;
        JwCompanys * model = self.companyArr [indexPath.row];
        self.companyID = model.id;
        NSLog(@"kkk");
      //  self.companyTableView.hidden = YES;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.dataService getprovinceWithProvince:@""
                                             city:@""
                                           county:@""
                                           com_id:self.companyID
                                             type:@"agent"
                                         distance:@"10.00"
                                              map:@"1"
                                          success:^(NSArray *lists) {
                                              [hud hide:YES];
            for (WHgetnearagent * near in lists) {
                self.nearID = near.id;
                self.StrDist = near.dist;
                //代理人ID
                [self.agentIdArry addObject:near.id];
                //小数点处理
                float  f = [near.dist floatValue];
                int a = (int)f;
                // NSLog(@"====%d",a);
                if (a >= 1000) {
                    int  b = a /1000;
                    // NSLog(@"LLL%d",b);
                    NSString * s1 = [NSString stringWithFormat:@"%d",b];
                    self.s = [s1 stringByAppendingString:@"KM"];
                }
                else
                {
                    NSString * s2  = [NSString stringWithFormat:@"%d",a];
                    self.s = [s2 stringByAppendingString:@"M"];
                }
                [self.distArry addObject:self.s];//距离
                
                
                
                // NSLog(@"oo%@",self.StrDist);
                // NSLog(@"ppp%@",near.data.name);
                [self.dataArry addObject:near.data.name];
                
                [self.imgArry addObject:near.data.avatar];
                [self.sexArry addObject:near.data.sex];
                if (near.data.com_name == nil) {
                    near.data.com_name = @"公司不详";
                }
                [self.comArry addObject:near.data.com_name];
                [self.mobileArry addObject:near.data.mobile];
                if (near.data.job_address == nil) {
                    near.data.job_address = @"地址不详";
                }
                [self.addressArry addObject:near.data.job_address];
                [self.telArry addObject:near.data.mobile];
                
                if (near.data.work_time == nil) {
                    near.data.work_time = @"";
                }
                if (near.data.profession == nil) {
                    near.data.profession = @"";
                }
                if (near.data.service_area == nil) {
                    near.data.service_area = @"";
                }
                NSString * strLab = [near.data.com_name stringByAppendingString:near.data.profession];
                NSString * strWork = [strLab stringByAppendingString:near.data.work_time];
                NSString * strArea = [strWork stringByAppendingString:near.data.service_area];
                [self.mtitArry addObject:strArea];
                [self.ageArry addObject:near.data.age];
               
            }
            
            
            [self.tableV reloadData];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"没有获取到数据"];
        }];
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
    if (tableView == _companyTableView) {
        return 60;
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
