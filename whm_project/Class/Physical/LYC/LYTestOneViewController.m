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
#import "WHscore.h"
#import "WHcov.h"
#import "WHrela.h"
#import <UIImageView+WebCache.h>


@interface LYTestOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dateArry;
@property(nonatomic,strong)NSString * score;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * Strate;

@property(nonatomic,strong)NSString * StrCov;

@property(nonatomic,strong)NSString * strName;

@property(nonatomic,strong)NSString * headImg;

@property(nonatomic,strong)NSString * Strage;


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
    NSDictionary * infoDic = @{@"pro_id":@"8088",@"main_id":@"0",@"is_main_must":self.is_main_must, @"insured_amount":self.rate,@"pay_period":@"10年交",@"period":self.period};
     NSError * error = nil;
    
   // NSArray * array = [NSArray array];
    NSArray * array  = @[infoDic];
    
   NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString * paramStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
     self.dateArry = [NSMutableArray array];
    [self.dataService getsavepolictWithUid:@""
                                   rela_id:self.rela_id
                                      pros:paramStr
                                   success:^(NSArray *lists){
                                       
                                       NSLog(@"%@", lists);
                                      
                                       WHgetreport * report = [lists firstObject];
                                      
                                       //self.dateArry = [NSMutableArray arrayWithArray:pro];
                                       
                                       [self.dateArry addObjectsFromArray:report.pros];
                                      // NSLog(@"==%ld",self.dateArry.count);
                                       //score获取
//                                    NSLog(@"===%@",report.score.rate);                                                             NSLog(@"===%@",report.score.score);
//                                     NSLog(@"%@",report.score.level);
                                       self.score = report.score.score;
                                       self.level = report.score.level;
                                       self.Strate = report.score.rate;
                                       //获取cov数据
                                       self.StrCov = report.cov.des;
                                       NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
                                       [ud setValue:[NSString stringWithFormat:@"%@",self.StrCov] forKey:@"one"];
                                       NSLog(@"==%@",self.StrCov);
                                       //姓名的获取
                                       for (WHrela * rela in report.rela) {
                                           NSLog(@"%@",rela.name);
                                           self.strName = rela.name;
                                           self.Strage = rela.birthday;
                                           self.headImg = rela.avatar;
                                       }
                                       
                                       
                                       
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
    return self.dateArry.count+1;
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
        cell.moneyLaber.text = self.Strate;
        cell.nameTitLaber.text = self.strName;
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.headImg]];
       
        cell.ageLaber.text = self.Strage;
        
        return cell;
    }else
    {
        LYTestTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TestTwoCellIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dateArry[indexPath.section -1];
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
