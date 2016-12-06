//
//  WHmyfollowListViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyfollowListViewController.h"
#import "MacroUtility.h"
#import "WHmyfollowListTableViewCell.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WHgetfollowList.h"
#import <UIImageView+WebCache.h>

@interface WHmyfollowListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHmyfollowListTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * tel ;
@property(nonatomic,strong)NSString * followId;
@end

@implementation WHmyfollowListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getfollowWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self setupUI];
}

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"我的关注";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHmyfollowListTableViewCell class] forCellReuseIdentifier:@"cell"];

    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHmyfollowListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WHgetfollowList * model = self.dataArry[indexPath.row];
    [cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.nameLaber.text = model.name;
    if ([model.sex isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];
    }else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
    }
    cell.ageLaber.text = model.age;
    if (model.work_time == nil) {
        model.work_time = @"";
    }
    if (model.profession == nil) {
        model.profession = @"";
    }
    if (model.service_area == nil) {
        model.service_area = @"";
    }
    if (model.company == nil) {
        model.company = @"";
    }
    NSString * strLab = [model.company stringByAppendingString:model.profession];
    NSString * strWork = [strLab stringByAppendingString:model.work_time];
    NSString * strArea = [strWork stringByAppendingString:model.service_area];
    cell.myLaber.text = strArea;
    [cell.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    cell.mesBut.tag = 100 + indexPath.row;
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    cell.telBut.tag = 100 + indexPath.row;
    [cell.telBut addTarget:self action:@selector(telButAction:) forControlEvents:(UIControlEventTouchUpInside )];
    [cell.mesBut addTarget:self action:@selector(mesButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
    
}
//短信事件
-(void)mesButAction:(UIButton *)sender
{
    NSLog(@"mes");
}

//电话事件
-(void)telButAction:(UIButton *)sender
{
    WHgetfollowList * model = self.dataArry[sender.tag - 100];
    self.tel = model.mobile;
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
//编辑删除事件
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//制定编辑的样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//删除事件
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        WHgetfollowList * model = self.dataArry[indexPath.row];
        self.followId = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delfollowWithID:self.followId
                                      uid:@""
                                  success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"取消关注成功"];
            [self.tableV reloadData];
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注失败"];
            
        }];
        
        [self.dataArry removeObjectAtIndex:indexPath.row];
        
        NSArray * temp = [NSArray arrayWithObject:indexPath];
        //更新ui
        
        [ tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
        [tableView setEditing:NO animated:YES];

        
    }];
    
    NSArray * arr = @[layTopRowAction1];
    return arr;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
