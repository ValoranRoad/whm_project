//
//  LYTestOneViewController.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestOneViewController.h"
#import "LYTestOneTableViewCell.h"
#import "LYTestTwoTableViewCell.h"
#import "WHpros.h"
#import "WHgetreport.h"

@interface LYTestOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dateArry;

@end
static NSString * const TestCellIdentifer = @"TestCell";
static NSString * const TestTwoCellIdentifer = @"TestTwoCell";
@implementation LYTestOneViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self requartDate];
    
}

//数据请求
-(void)requartDate
{
    NSLog(@"%@",self.rela_id);
    NSDictionary * infoDic = @{@"pro_id":self.pro_id,@"main_id":@"0",@"is_main_must":self.is_main_must, @"insured_amount":@"100000",@"pay_period":@"10年交",@"period":@"至70岁"};
     NSError * error = nil;
    
    
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:infoDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * paramStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self.dataService getsavepolictWithUid:@""
                                   rela_id:self.rela_id
                                      pros:paramStr
                                   success:^(NSArray *lists)
    {
//        self.dateArry = [NSMutableArray arrayWithArray:lists];
//                                   //    NSLog(@"%@",self.dateArry);
//                                       for (WHpros * pro in self.dateArry) {
//                                           
//                                           NSLog(@"%@",pro);
//                                       }
        
    self.dateArry = [NSMutableArray array];
        WHgetreport * report = [lists firstObject];
        WHpros * pros = [report.pros firstObject];
        [self.dateArry addObject: pros];
        NSLog(@"%@",self.dateArry);
//
        
                                       
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setTableView];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)p_setTableView
{
    self.tableView.rowHeight = 140;
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTestOneTableViewCell" bundle:nil] forCellReuseIdentifier:TestCellIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTestTwoTableViewCell" bundle:nil] forCellReuseIdentifier:TestTwoCellIdentifer];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LYTestOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TestCellIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        LYTestTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TestTwoCellIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
