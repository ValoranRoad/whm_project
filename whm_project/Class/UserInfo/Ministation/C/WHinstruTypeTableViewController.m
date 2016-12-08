//
//  WHinstruTypeTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/7.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHinstruTypeTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHprosearchTableViewCell.h"
#import "WHgetproduct.h"
#import "UIColor+Hex.h"

@interface WHinstruTypeTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)WHprosearchTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * keyWord;
@property(nonatomic,strong)NSString * instID;

@property(nonatomic,strong)UIButton * addBut;
@property(nonatomic,strong)UIView * myView;
//底部高度

@end

@implementation WHinstruTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局
    [self setupUI];

  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
  
}
//数据请求
-(void)quartData
{
    NSLog(@"ppp%@",self.companyid);
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:self.companyid
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

-(void)setupUI
{
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHprosearchTableViewCell class] forCellReuseIdentifier:@"cell"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     */
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //
    self.myView = [[UIView alloc]init];
    self.myView.backgroundColor = [UIColor whiteColor];
    self.addBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addBut.frame = CGRectMake(kScreenWitdh* 0.15, CGRectGetMinY(self.myView.frame), CGRectGetWidth(self.view.frame)*0.7, CGRectGetHeight(self.myView.frame)+44);
    self.addBut.backgroundColor = [UIColor colorWithHex:0x4367FF];
    self.addBut.layer.masksToBounds = YES;
    self.addBut.layer.cornerRadius = 22;
    [self.addBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.addBut setTitle:@"确认添加" forState:(UIControlStateNormal)];
    [self.addBut setTintColor:[UIColor whiteColor]];
    [self.myView addSubview:_addBut];
    
    return self.myView;
    
    
}

-(void)nextButAction:(UIBarButtonItem *)sender
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService seaverecWithPids:self.instID uid:@"" success:^{
        [hud hide:YES];
        [JGProgressHelper showSuccess:@"添加成功"];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"添加失败"];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHprosearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.model = self.arry[indexPath.row];
    
    cell.model = self.dataArry[indexPath.row];
    
    
    return cell;

}

//选中事件返回
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHgetproduct * model = self.dataArry[indexPath.row];
    self.instID = model.id;
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
