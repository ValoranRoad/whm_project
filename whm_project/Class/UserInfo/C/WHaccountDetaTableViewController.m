//
//  WHaccountDetaTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/20.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaccountDetaTableViewController.h"
#import "UIColor+Hex.h"
#define WHhight CGRectGetHeight([UIScreen mainScreen].bounds)
//414x736
#import "WHinsuranceNameViewController.h"

//出生日期选择
#import "ASBirthSelectSheet.h"

#import "WHaddressDetalViewController.h"

#import "WHaccountTableViewCell.h"

#import "WHsexViewController.h"
#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface WHaccountDetaTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton * addBut;

@property(nonatomic,strong)UIView * myView;

@property(nonatomic,strong)UIImageView * phoImage;

@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * sexLaber;


@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) WHaccountTableViewCell *cell;






@end

@implementation WHaccountDetaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户详情";
   self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];

    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableV];
    
   

}



//
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     
     
     */
    
    
    return 24;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return WHhight *0.135;
    }
    else{
        return WHhight*0.081;
    }
}

//
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //
    if (section == 2) {
        
    self.myView = [[UIView alloc]init];
    self.myView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
    self.addBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addBut.frame = CGRectMake(30, CGRectGetMinY(self.myView.frame)+40, CGRectGetWidth(self.view.frame)-60, CGRectGetHeight(self.myView.frame)+50);
    self.addBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    
    [self.addBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.addBut.layer.cornerRadius = 20;
    [self.addBut setTitle:@"保存信息" forState:(UIControlStateNormal)];
    [self.addBut setTintColor:[UIColor whiteColor]];
    
    self.addBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.addBut.layer.shadowOpacity = 0.8;
    self.addBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
    [self.myView addSubview:_addBut];
    }
    
    return self.myView;
    
    
    
}
//提交保存
-(void)nextButAction:(UIBarButtonItem *)sender
{
    
    NSLog(@"tijiao");
    
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

//    return 0;
    if (section == 0) {
        return 4;
    }if (section ==1) {
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
            cell.textLabel.text = @"头像";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
            self.phoImage = [[UIImageView alloc]init];
            self.phoImage.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetMaxY(cell.textLabel.frame)+20, CGRectGetWidth([UIScreen mainScreen].bounds)*0.144, CGRectGetWidth([UIScreen mainScreen].bounds)*0.144);
            self.phoImage.image = [UIImage imageNamed:@"test_head"];
            self.phoImage.layer.masksToBounds = YES;
            self.phoImage.layer.cornerRadius = CGRectGetWidth([UIScreen mainScreen].bounds)*0.144/2;
            
            [cell.contentView addSubview:_phoImage];
            
            
   
        }
        
        if (indexPath.row == 1 && indexPath.section == 0) {
            cell.textLabel.text = @"姓名";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

        if (indexPath.row == 2 && indexPath.section == 0) {
            cell.textLabel.text = @"性别";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
           // cell.detailTextLabel.textColor = [UIColor grayColor];
           // cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            //
            self.sexLaber = [[UILabel alloc]init];
            self.sexLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.65, CGRectGetMaxY(cell.textLabel.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.09, CGRectGetWidth([UIScreen mainScreen].bounds)*0.09);
          //  self.sexLaber.text = @"男";
            [cell.contentView addSubview:_sexLaber];
            //
            
            self.sexImage = [[UIImageView alloc]init];
            self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.sexLaber.frame)+10, CGRectGetMinY(self.sexLaber.frame), CGRectGetWidth(self.sexLaber.frame), CGRectGetHeight(self.sexLaber.frame));
         //   self.sexImage.image = [UIImage imageNamed:@"test_male"];
            [cell.contentView addSubview:_sexImage];
            
        }

        
        if (indexPath.row == 3 && indexPath.section == 0) {
            cell.textLabel.text = @"出生年月";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

        
        if (indexPath.row == 0 && indexPath.section == 1) {
            cell.textLabel.text = @"我的认证信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

        if (indexPath.row == 0 && indexPath.section == 2) {
            cell.textLabel.text = @"所在地区";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

        if (indexPath.row == 1 && indexPath.section == 2) {
            cell.textLabel.text = @"详细地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

    }
    return cell;
}

//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        WHinsuranceNameViewController * insurance = [[WHinsuranceNameViewController alloc]init];
        insurance.mblock1 = ^(NSString * s1)
        {
            cell.detailTextLabel.text = s1 ;
            
           
        };
        
        [self.navigationController pushViewController:insurance animated:NO];
        
    }
    
    //
    if (indexPath.section == 0 && indexPath.row == 3) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

//        
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
        datesheet.selectDate = cell.detailTextLabel.text;
        datesheet.GetSelectDate = ^(NSString *dateStr) {
            cell.detailTextLabel.text = dateStr;
        };
        [self.view addSubview:datesheet];
        
    }
   
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        //
        WHaddressDetalViewController *address = [[WHaddressDetalViewController alloc] init];
    
       address.mblock1 = ^(NSString * s1)
        {
            cell.detailTextLabel.text = s1 ;
        };
        
        [self.navigationController pushViewController:address animated:NO];
        

    
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
       // UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        WHsexViewController *sex = [[WHsexViewController alloc] init];
        
        sex.mblock1 = ^(NSString * s1)
        {
            self.sexLaber.text = s1 ;
            
            if ([s1 isEqualToString:@"男"]) {
                self.sexImage.image = [UIImage imageNamed:@"test_male"];
            }
            else
            {
                self.sexImage.image = [UIImage imageNamed:@"test_famale"];
            }
        };
        
        [self.navigationController pushViewController:sex animated:NO];
        
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
