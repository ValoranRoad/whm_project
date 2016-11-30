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
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WHgetpolicys.h"
#import "WHpesfporViewController.h"

@interface WHslipListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView * tableV;
@property (nonatomic ,strong) NSMutableArray * dataArry;

@property(nonatomic,strong)UIButton * addBut;

@property(nonatomic,strong)UIView * myView;

@property(nonatomic,strong)NSString * name;

@property(nonatomic,strong)NSString * ids;

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
    
    id hud = nil;
    hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getpolicysWithUid:@"" rela_id:self.rela_id success:^(NSArray *lists) {
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
#pragma mark -- 布局
-(void)setupUI
{
 
//    NSString * s1 = @"的保单";
//    self.title = [self.name stringByAppendingString:s1];
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHslipListTableViewCell class] forCellReuseIdentifier:@"cell"];

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
   WHslipListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WHgetpolicys * model = self.dataArry[indexPath.row];
    [cell.selectBut setBackgroundImage:[UIImage imageNamed:@"Jw_voal"] forState:(UIControlStateNormal)];
    
    cell.insured.text = model.insured;
    cell.rate.text = model.rate;
    cell.scoreLaber.text = model.score;
    self.name = model.rela_name;
    NSString * s1 = @"的保单";
    self.title = [self.name stringByAppendingString:s1];
    cell.titLaber.text = model.pro_name;
    cell.img1.image = [UIImage imageNamed:@"del"];
    cell.img2.image = [UIImage imageNamed:@"wanshan"];
    cell.img3.image = [UIImage imageNamed:@"chakan"];
    [cell.delBut setTitle:@"删除" forState:(UIControlStateNormal)];
    [cell.pefBut setTitle:@"完善保单" forState:(UIControlStateNormal)];
    [cell.lookBut setTitle:@"查看报告" forState:(UIControlStateNormal)];
    cell.lineView1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    cell.lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    cell.line3.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    cell.line4.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    [cell.delBut addTarget:self action:@selector(delButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.delBut.tag = 100 + indexPath.row;
    
    [cell.pefBut addTarget:self action:@selector(pefButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.pefBut.tag = 100 + indexPath.row;
    
    [cell.lookBut addTarget:self action:@selector(lookButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.lookBut.tag = 100 + indexPath.row;
    
    return cell;
}
//查看报告事件
-(void)lookButAction:(UIButton *)sender
{
    NSLog(@"查看");
}

//完善事件
-(void)pefButAction:(UIButton *)sender
{
    WHgetpolicys * pol = self.dataArry[sender.tag - 100];
    
    DLog(@"wanshan" );
    WHpesfporViewController * pesf = [[WHpesfporViewController alloc]init];
    pesf.reID = pol.id;
    pesf.strName= pol.rela_name;
    pesf.comName = pol.pro_name;
    [self.navigationController pushViewController:pesf animated:YES];
}

//选中cell中的数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
//删除事件
-(void)delButAction:(UIButton *)sender
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要删除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    WHgetpolicys * pol = self.dataArry[sender.tag - 100];
    self.ids = pol.id;
    
    
    [view show];

}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delpolicyWithPolicy_id:self.ids uid:@"" success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"删除成功"];
             [self.tableV reloadData];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@""];
            
        }];
        
        
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

//底部高度

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
    
    [self.addBut setTitle:@"合并体检" forState:(UIControlStateNormal)];
    [self.addBut setTintColor:[UIColor whiteColor]];
    [self.myView addSubview:_addBut];
    
    return self.myView;
    
    
    
}
//合并体检事件
-(void)nextButAction:(UIButton *)sender
{
    
    DLog(@"sss");
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
