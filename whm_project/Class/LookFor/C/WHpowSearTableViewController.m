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


@interface WHpowSearTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    NSMutableArray *_data4;
    
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    NSInteger _currentData4Index;
    
    NSInteger _currentData1SelectedIndex;
    JSDropDownMenu *menu;

}

@property (nonatomic, strong) UITableView *tableV;

@property(nonatomic,strong)UIButton * searBut;

@property(nonatomic,strong)NSMutableArray * dataArry;

@property(nonatomic,strong)UILabel * AllstyLaber;

@property(nonatomic,strong)UILabel * oneLaber;

@property(nonatomic,strong)WHpowTwoTableViewCell * cell1;



@property(nonatomic,strong)NSMutableArray * homeArry;

@property(nonatomic,strong)NSString * sID;

@end

@implementation WHpowSearTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self quartData];
    

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    // 布局
    [self setupUI];
    
//    UICollectionViewFlowLayout *flowlayOut = [[UICollectionViewFlowLayout alloc]init];
//    flowlayOut.itemSize = CGSizeMake(80, 80);
//    
//    flowlayOut.minimumInteritemSpacing = 10;
//    
//    flowlayOut.minimumLineSpacing = 10 ;
//    flowlayOut.scrollDirection = UICollectionViewScrollDirectionVertical ;
//    
//    flowlayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    
//    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 200) collectionViewLayout:flowlayOut];
//    [self.view addSubview:collectView];
//    //背景设置为白色
//    collectView.backgroundColor = [UIColor whiteColor];
//    
//    collectView.delegate = self;
//    collectView.dataSource = self;
//    [collectView registerClass:[WHmypowTwoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//

}



#pragma mark--数据请求
-(void)quartData
{
    self.homeArry = [NSMutableArray array];

    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getappcateWithsuccess:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        for (WHgetappcate * model in self.dataArry) {
            // NSLog(@"%@",model.id);
            if ([model.p_id  isEqualToString:@"1"]) {
                
                NSLog(@"%@",model.name);
                [self.homeArry addObject:model.name];
                
                NSLog(@"%ld",self.homeArry.count);
                
            }
        }
       
        
        
        NSLog(@"%@",self.dataArry);
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
}

#pragma mark -- 布局
-(void)setupUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    //
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
//
    // 指定默认选中
    _currentData1Index = 1;
    _currentData1SelectedIndex = 1;
    //

    
    _data1 = [NSMutableArray arrayWithObjects:@"全部",@"个人和家庭",@"企业和团体", nil];
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"3~4人餐", nil];
    
    _data4 = [NSMutableArray arrayWithObjects:@"你好",@"我好",@"大家好", nil];
    
    //
   menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:25];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];

    
    //
    
    


    
}

- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 4;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
       
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 1;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
            return _data1.count;
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    else if (column==3){
        
        return _data4.count;
    }
    
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 1: return _data2[_currentData2Index];
            break;
        case 2: return _data3[_currentData3Index];
            break;
        case 3: return _data4[_currentData4Index];
            break;
  
        case 0: return _data1[_currentData1Index];
            break;
            

            
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        
        return _data1[indexPath.row];
        
          } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
    
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0 && indexPath.row == 1) {
        
        self.sID = @"1";
        NSLog(@"888");
        _currentData1Index = indexPath.row;
        
    }else if (indexPath.column == 0 && indexPath.row == 2)
    {
        self.sID = @"2";
         _currentData1Index = indexPath.row;
    }
    
    else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
