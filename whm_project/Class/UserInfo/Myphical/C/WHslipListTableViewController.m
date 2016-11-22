//
//  WHslipListTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHslipListTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHslipListTableViewCell.h"

@interface WHslipListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableV;
@property (nonatomic ,strong) NSMutableArray * dataArry;

@end

@implementation WHslipListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 请求数据
    [self requestData];
    
}
// 请求数据
-(void)requestData
{
 
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 布局
-(void)setupUI
{
 
    self.title = @"xxx的保单";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHslipListTableViewCell class] forCellReuseIdentifier:@"cell"];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   WHslipListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.selectBut setBackgroundImage:[UIImage imageNamed:@"Jw_voal"] forState:(UIControlStateNormal)];
    
    cell.insured.text = @"¥1001";
    cell.rate.text = @"¥2515";
    cell.scoreLaber.text = @"47分";
    cell.titLaber.text = @"个人人身意外伤害保险";
    cell.img1.image = [UIImage imageNamed:@"del"];
    cell.img2.image = [UIImage imageNamed:@"wanshan"];
    cell.img3.image = [UIImage imageNamed:@"chakan"];
    [cell.delBut setTitle:@"删除" forState:(UIControlStateNormal)];
    [cell.pefBut setTitle:@"完善保单" forState:(UIControlStateNormal)];
    [cell.lookBut setTitle:@"查看报告" forState:(UIControlStateNormal)];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
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
