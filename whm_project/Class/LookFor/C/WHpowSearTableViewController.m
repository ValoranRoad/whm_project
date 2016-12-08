//
//  WHpowSearTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/7.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpowSearTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "JSDropDownMenu.h"
#import "WHpowTwoTableViewCell.h"
#import "WHgetappcate.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"
#import "WHgetproperiod.h"
#import "WHgetcharacters.h"
#import "JwCompanys.h"
#import "WHhistoryTableViewCell.h"
#import "WHgetproducedetalViewController.h"



@interface WHpowSearTableViewController ()<UISearchBarDelegate, JSDropDownMenuDataSource, JSDropDownMenuDelegate,UITableViewDataSource,UITableViewDelegate>
{
    JSDropDownMenu *menu;
    NSMutableArray *_data4;
}

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIButton * searBut;
//菜单数据
@property (nonatomic, strong) NSArray *menus;
//所有数据
@property (nonatomic, strong) NSMutableArray *allArr;
//分类数据
@property (nonatomic, strong) NSMutableArray *wholes;
@property (nonatomic, strong) NSMutableArray *secures;
@property (nonatomic, strong) NSMutableArray *categorys;

//选中指定
@property (nonatomic, assign) NSInteger currentWhole;
@property (nonatomic, assign) NSInteger currentSecure;
@property (nonatomic, assign) NSInteger currentCategory;
@property (nonatomic, assign) NSInteger currentScreen;

//筛选数组
@property (nonatomic, strong) NSMutableArray *currentSelects;

@property (nonatomic, strong) JSIndexPath *path0;
@property (nonatomic, strong) JSIndexPath *path1;
@property (nonatomic, strong) JSIndexPath *path2;
@property (nonatomic, strong) JSIndexPath *path3;
@property (nonatomic, strong) JSIndexPath *path4;

@property(nonatomic,strong)WHhistoryTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;


@end

@implementation WHpowSearTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self quartData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    self.currentSelects = [NSMutableArray array];
    self.path0 = [JSIndexPath indexPathWithCol:-1 leftOrRight:-1 leftRow:-1 row:-1];
    self.path1 = [JSIndexPath indexPathWithCol:-1 leftOrRight:-1 leftRow:-1 row:-1];
    self.path2 = [JSIndexPath indexPathWithCol:-1 leftOrRight:-1 leftRow:-1 row:-1];
    self.path3 = [JSIndexPath indexPathWithCol:-1 leftOrRight:-1 leftRow:-1 row:-1];
    self.path4 = [JSIndexPath indexPathWithCol:-1 leftOrRight:-1 leftRow:-1 row:-1];
}

-(void)quartData{
    
    self.allArr = [NSMutableArray array];
    self.wholes = [NSMutableArray array];
       
    WHgetappcate *a = [[WHgetappcate alloc] init];
    a.id = -1;
    a.name = @"全部";
    a.p_id = -1;
    [self.wholes addObject:a];
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getappcateWithsuccess:^(NSArray *lists) {
        [hud hide:YES];
        
        [self.allArr addObjectsFromArray:lists];
        for (WHgetappcate *appcate in self.allArr) {
            if (appcate.p_id == 0) {
                [self.wholes addObject:appcate];
            }
        }
        NSLog(@"%@", self.wholes);
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
}

-(void)setupUI{
    //thableview设置
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHhistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    searchBar.backgroundColor = color;
    //searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"请输入关键词";
    [titleView addSubview:searchBar];
//    self.searBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.searBut.frame = CGRectMake(kScreenWitdh * 0.71, 0, kScreenWitdh*0.2, 35);
//    [self.searBut setTitle:@"搜索" forState:(UIControlStateNormal)];
//    [self.searBut setTintColor:[UIColor whiteColor]];
//    [titleView addSubview:_searBut];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    NSArray *sex = @[@"男", @"女"];
    NSMutableArray *ages = [NSMutableArray array];
    for (int i=0; i<=80; i++) {
        [ages addObject:[NSString stringWithFormat:@"%.2d", i]];
    }
    
    //出行计划
    
    NSMutableArray * arr1 = [NSMutableArray array];
    NSMutableArray * arr2 = [NSMutableArray array];
    NSMutableArray * arr3 = [NSMutableArray array];
     id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getproperiodWithsuccess:^(NSArray *lists) {
        [hud hide:YES];
        for (WHgetproperiod * model in lists) {
            [arr1  addObject:model.name];
           // NSLog(@"%@",self.proArry);
            
        }
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
               [JGProgressHelper  showError:@""];
        
    }];

    //特色保障
    [self.dataService getcharactersWithsuccess:^(NSArray *lists) {
        [hud hide:YES];
        for (WHgetcharacters * model in lists) {
            [arr2 addObject:model.name];
        }
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    //保险品牌(也就是公司)
    [self.dataService get_CompanysWithType:@"1,2" success:^(NSArray *lists) {
        [hud hide:YES];
        for (JwCompanys * model in lists) {
            [arr3 addObject:model.name];
        }
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];

    
    
    //
    
   
    _data4 = [NSMutableArray arrayWithObjects:@{@"title":@"性别", @"data":sex}, @{@"title":@"年龄", @"data":ages}, @{@"title":@"出行计划", @"data":arr1}, @{@"title":@"特色保障", @"data":arr2}, @{@"title":@"保险品牌", @"data":arr3}, nil];

    self.menus = @[@"全部", @"险种", @"类别", @"筛选"];
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    menu.jwspecMneuIndex = self.menus.count - 1;
    Weak(self);
    menu.screenBActionBlock =^(){
        NSLog(@"点击筛选");
        

       id hud = [JGProgressHelper showProgressInView:wself.view];
        [wself.dataService get_productWithCompany_id:@""
                                            keyword:@""
                                                sex:@""
                               characters_insurance:@""
                                             period:@""
                                            cate_id:@""
                                         pay_period:@""
                                               rate:@""
                                            insured:@""
                                           birthday:@""
                                      yearly_income:@""
                                               debt:@""
                                            rela_id:@""
                                                  p:@""
                                           pagesize:@""
                                            success:^(NSArray *lists) {
                                                [hud hide:YES];
                                                
                                                wself.dataArry = [NSMutableArray arrayWithArray:lists];
                                                [wself.tableV reloadData];
                                                
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            
        }];
        

        
        
        
        
        
    };
    [self.view addSubview:menu];
    
    
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 4;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArry.count;
}



/**
 * 是否需要显示为UICollectionView 默认为否
 */
-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}
/**
 * 表视图显示时，是否需要两个表显示
 */
-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    if (column == 3) {
        return YES;
    }
    return NO;
}
/**
 * 表视图显示时，左边表显示比例
 */
-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    if (column == 3) {
        return 0.4;
    }
    return 1;
}
/**
 * 返回当前菜单左边表选中行
 */
-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column == 0) {
        
        return self.currentWhole;
    }else if (column == 1){
        
        return self.currentSecure;
    }else if (column == 2){
        
        return self.currentCategory;
    }
    else if (column == 3)
    {
        return self.currentScreen;
    }
    else{
        
        return 0;
    }

}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        
        return self.wholes.count;
    }else if (column == 1){
        
        return self.secures.count;
    }else if (column == 2){
        
        return self.categorys.count;
    }else if (column == 3){
        
        if (leftOrRight==0) {
            
            return _data4.count;
        } else{
            
            NSDictionary *menuDic = [_data4 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }

    }
    
        return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    return self.menus[column];
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    WHgetappcate *appcate;
    if (indexPath.column == 0) {
        
        appcate = self.wholes[indexPath.row];
    }else if (indexPath.column == 1){
        
        appcate = self.secures[indexPath.row];
    }else if (indexPath.column == 2){
        
        appcate = self.categorys[indexPath.row];
        
          }else{
        
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data4 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data4 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    }
  
    return appcate.name;
}

- (void)sendSelects{
     menu.jwSelects = self.currentSelects;
}

- (void)menu:(JSDropDownMenu *)menu didSelectMenuAtIndex:(NSInteger)index{
    if (index == 3) {
        [self menusetupBackView:NO];
    }else{
        [self menusetupBackView:YES];
    }
}
-(void)menusetupBackView:(BOOL)isHid{
    //menu.backGroundView.alpha = 1;
    menu.screenB.hidden = isHid;
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    NSLog(@"%ld, %ld, %ld, %ld", (long)indexPath.column, (long)indexPath.leftOrRight, (long)indexPath.leftRow, (long)indexPath.row);
    
    if (indexPath.leftOrRight == 1) {
        if (indexPath.leftRow == 0) {
            _path0 = indexPath;
        }else if (indexPath.leftRow == 1){
            _path1 = indexPath;
        }else if (indexPath.leftRow == 2){
            _path2 = indexPath;
        }else if (indexPath.leftRow == 3){
            _path3 = indexPath;
        }else if (indexPath.leftRow == 4){
            _path4 = indexPath;
        }
        NSArray *selects = @[_path0, _path1, _path2, _path3, _path4];
        self.currentSelects = [NSMutableArray arrayWithArray:selects];
    }
    [self sendSelects];
    
    if (indexPath.column == 0) {
        
        self.currentWhole = indexPath.row;
        self.secures = [NSMutableArray array];
        self.currentSecure = 0;
        WHgetappcate *cate = self.wholes[indexPath.row];
        if (cate.p_id != -1) {
            
            WHgetappcate *a = [[WHgetappcate alloc] init];
            a.id = -1;
            a.name = @"险种";
            a.p_id = -1;
            [self.secures addObject:a];
            
            for (WHgetappcate *appcate in self.allArr) {
                if (appcate.p_id == cate.id) {
                    [self.secures addObject:appcate];
                }
            }
        }
    }else if (indexPath.column == 1){
        
        self.currentSecure = indexPath.row;
        self.categorys = [NSMutableArray array];
        self.currentCategory = 0;
        WHgetappcate *cate = self.secures[indexPath.row];
        if (cate.p_id != -1) {
            
            WHgetappcate *a = [[WHgetappcate alloc] init];
            a.id = -1;
            a.name = @"类别";
            a.p_id = -1;
            [self.categorys addObject:a];
            
            for (WHgetappcate *appcate in self.allArr) {
                if (appcate.p_id == cate.id) {
                    [self.categorys addObject:appcate];
                }
            }
        }
        
    }else if (indexPath.column == 2){
        self.currentCategory = indexPath.row;
        
    }
    else if (indexPath.column == 3){
        if (indexPath.leftOrRight == 0) {
            self.currentScreen = indexPath.leftRow;
        }
    }
    else{
        
    }
}
//数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHhistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.model = self.dataArry[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//数据选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHgetproduct * model = self.dataArry[indexPath.row];
//    NSLog(@"%@%@%@",model.id,model.name,model.logo);
   WHgetproducedetalViewController * produce = [[WHgetproducedetalViewController alloc]init];
    produce .pro_id = model.id;
    [self.navigationController pushViewController:produce animated:YES];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@"" keyword:searchBar.text  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:@"1" pagesize:@"10" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
