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
@interface WHnearAgentTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHnearAgentTableViewController * cell;
@property(nonatomic,strong)NSString * tel;
@end

@implementation WHnearAgentTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self quartDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
//数据请求
-(void)quartDate
{
}

//设计界面
-(void)setupUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];

    [self.tableV registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    [cell.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    cell.mesBut.tag = 100 + indexPath.row;
    
    cell.telBut.tag = 100 + indexPath.row;
    [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.mesBut addTarget:self action:@selector(mesButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}

//信息事件
-(void)mesButAction:(UIButton *)sender
{
    NSLog(@"message");
}

//电话事件
-(void)telAction:(UIButton *)sender
{
//    WHagent * model = self.peopArry[sender.tag - 100];
//    self.tel = model.mobile;
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
    return 100;
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
