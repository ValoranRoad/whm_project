//
//  WHsetupTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHsetupTableViewController.h"
#import "UIColor+Hex.h"
#import "WHaccountDetaTableViewController.h"
#import "WHsavesetupTableViewController.h"
#import "JGProgressHelper.h"
#import "JwLoginController.h"
#import "JwUserCenter.h"
#import "MacroUtility.h"
#import "WHaboutsetViewController.h"

#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define WHhight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface WHsetupTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableV;

@property(nonnull,strong)UILabel * myLaber;




@end

@implementation WHsetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationItem.title = @"设置";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    
    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self.view addSubview:_tableV];


}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     
     
     */
    
    
    return 24;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return WHhight*0.081;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0 || section == 2) {
        return 1;
    }
    else
    {
        return 2;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
   if (indexPath.row == 0 && indexPath.section == 0) {
       
       
       cell.textLabel.text = @"账户详情";
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       cell.textLabel.font = [UIFont systemFontOfSize:15.0];

       
       }
    
        if (indexPath.section == 1 && indexPath.row == 0) {
            
            
            cell.textLabel.text = @"安全设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];

            
        }
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            cell.textLabel.text = @"系统设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];

        }
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            self.myLaber = [[UILabel alloc]init];
            self.myLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.4, CGRectGetMinY(cell.textLabel.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, 44);
            self.myLaber.text = @"退出账号";
            self.myLaber.textColor = [UIColor colorWithHex:0xFF4545];
            [cell.contentView addSubview:_myLaber];
            
        }
        
        
    }
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        WHaccountDetaTableViewController * account = [[WHaccountDetaTableViewController alloc]init];
        [self.navigationController pushViewController:account animated:NO];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        WHsavesetupTableViewController * saveSet = [[WHsavesetupTableViewController alloc]init];
        [self.navigationController pushViewController:saveSet     animated: NO];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
   
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要退出吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    if (indexPath.row == 1  && indexPath.row == 1) {
        WHaboutsetViewController * about = [[WHaboutsetViewController alloc]init];
        [self.navigationController pushViewController:about animated:YES];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {

        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService logoutWithSuccess:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"退出成功"];
            //发送登录失败的的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kJwIsLogin object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:nil];
        }];
        
        
    }
}


@end
