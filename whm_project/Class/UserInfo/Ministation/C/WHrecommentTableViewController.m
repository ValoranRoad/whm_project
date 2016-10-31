//
//  WHrecommentTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrecommentTableViewController.h"
#import "WHrecommentTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"

@interface WHrecommentTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WHrecommentTableViewCell * cell;

@property (nonatomic, strong) UITableView *tableV;

@property(nonatomic,strong)NSMutableArray * dataArry;

@end

@implementation WHrecommentTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //请求数据
    [self requestData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 布局
    [self setupUI];

   
}

// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getrecWithAgent_uid:@"" uid:(@"") success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
    } failure:^(NSError * error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
}

-(void)setupUI
{
    self.title = @"推荐险种";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    
    [self.tableV registerClass:[WHrecommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    return self.dataArry.count;
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHrecommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.myImage.image = [UIImage imageNamed:@"test_head"];
//    cell.titLaber.text = @"泰康人寿组合附加保险公司";
//    cell.yearLaber.text = @"投保年龄:0-66周岁";
//    cell.statuLaber.text = @"产品类型:两全保险";
//    cell.timeLaber.text = @"2016-09-01 09:10:20";
    cell.model = self.dataArry[indexPath.row];
    
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
