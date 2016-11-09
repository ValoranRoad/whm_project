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


@interface WHpowSearTableViewController ()<UISearchBarDelegate, JSDropDownMenuDataSource, JSDropDownMenuDelegate>
{
    JSDropDownMenu *menu;
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
@end

@implementation WHpowSearTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self quartData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    searchBar.backgroundColor = color;
    // searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"请输入关键词";
    [titleView addSubview:searchBar];
    self.searBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.searBut.frame = CGRectMake(kScreenWitdh * 0.71, 0, kScreenWitdh*0.2, 35);
    [self.searBut setTitle:@"搜索" forState:(UIControlStateNormal)];
    [self.searBut setTintColor:[UIColor whiteColor]];
    [titleView addSubview:_searBut];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    self.menus = @[@"全部", @"险种", @"类别", @"筛选"];
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 4;
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

    return NO;
}
/**
 * 表视图显示时，左边表显示比例
 */
-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
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
    }else{
        
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
    }else{
        
        return 0;
    }
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
        
    }
    return appcate.name;
}

- (void)menu:(JSDropDownMenu *)menu didSelectMenuAtIndex:(NSInteger)index{
    NSLog(@"%ld", (long)index);
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
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
        
        
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
