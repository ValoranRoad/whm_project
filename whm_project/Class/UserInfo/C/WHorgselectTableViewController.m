//
//  WHorgselectTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHorgselectTableViewController.h"
#import "WHorgSelectTableViewCell.h"
#import "MacroUtility.h"
#import "WHorganization.h"
#import "JGProgressHelper.h"
@interface WHorgselectTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHorgSelectTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;

@end

@implementation WHorgselectTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requDate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
    [self.tableV registerClass:[WHorgSelectTableViewCell class] forCellReuseIdentifier:@"cell"];


}

-(void)requDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getorgProvinceWithProvince:@""
                                            city:@""
                                          county:@""
                                          com_id:self.com_id
                                        distance:@""
                                             map:@"1" success:^(NSArray *lists) {
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHorgSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WHorganization  * model = self.dataArry[indexPath.row];
    cell.myTitLaber.text = model.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHorganization  * model = self.dataArry[indexPath.row];
    if (model.id != nil && model.name != nil ) {
        self.mblock2 (model.id ,model.name,model.address);
    }
    [self.navigationController popViewControllerAnimated:YES];
    

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
