//
//  WHsetupTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHsetupTableViewController.h"
#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define WHhight CGRectGetHeight([UIScreen mainScreen].bounds)
#import "UIColor+Hex.h"
#import "WHaccountDetaTableViewController.h"
#import "WHsavesetupTableViewController.h"
#import "JGProgressHelper.h"


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
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
   
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
      //  alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [alert show];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"22");
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService logoutWithSuccess:^{
            [hud hide:YES];
            [JGProgressHelper  showSuccess:@"退出成功"];
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:nil];
        }];
        
        
    }
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
