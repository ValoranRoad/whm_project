//
//  WHproductSearchTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/9.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHproductSearchTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHprosearchTableViewCell.h"
#import "WHgetproduct.h"
#import "JwPhysicalController.h"
@interface WHproductSearchTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)WHprosearchTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * keyWord;
@property(nonatomic,strong)NSString * ids;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * is_main;

@end

@implementation WHproductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 布局
    [self setupUI];
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
    
}
-(void)left:(UIBarButtonItem *)sender
{
//    JwPhysicalController * phy = [[JwPhysicalController alloc]init];
//    phy.name = self.name;
//    phy.ids = self.ids;
//    phy.is_main = self.is_main;
//    
//    [self.navigationController pushViewController:phy animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//数据请求
-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:self.company_id
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
                                              p:@"1"
                                       pagesize:@"10" success:^(NSArray *lists) {
                                           
                                           [hud hide:YES];
                                           self.dataArry = [NSMutableArray arrayWithArray:lists];
                                           
                                           [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
}

#pragma mark -- 布局
-(void)setupUI
{

    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHprosearchTableViewCell class] forCellReuseIdentifier:@"cell"];
    

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
    
    
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    

    
}

//选中事件返回
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JwPhysicalController * phy = [[JwPhysicalController alloc]init];
    WHgetproduct * model = self.dataArry[indexPath.row];
    self.name = model.name;
    self.ids = model.id;
    self.is_main = model.is_main;
    phy.modelType = model;
    phy.groupMutableArr = self.groupsArr;
    phy.isSelectPersonName = self.isSelectP;
    phy.contentMutableDict = self.contentDic;
    phy.fuzhiDict = self.fuzhiDic;
    [self.navigationController pushViewController:phy animated:YES];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  
     NSLog(@"%@",searchBar.text);
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
////搜索结果显示实现
//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//
//    _htSearchView  = [[UIView alloc]init];
//    _htSearchView .frame = CGRectMake(0, 100, 320, 400);
//    _htSearchView.backgroundColor = [UIColor colorWithRed:37/255 green:34/255  blue:34/255 alpha:0.8];
//    
//    [self.view addSubview:_htSearchView];
//    
//    [searchBar resignFirstResponder];
//    
//    [self.htSearchView addSubview:self.arry[0]];
//    
//    return YES;
//}

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
    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHprosearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.model = self.arry[indexPath.row];
  
    cell.model = self.dataArry[indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
