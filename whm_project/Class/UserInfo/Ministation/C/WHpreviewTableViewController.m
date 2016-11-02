//
//  WHpreviewTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/1.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpreviewTableViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHprevTableViewCell.h"


@interface WHpreviewTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
//@property(nonatomic,strong)UILabel * profesLaber;
//@property(nonatomic,strong)UILabel * worktimeLaber;
//@property(nonatomic,strong)UILabel * cityLaber;
@property(nonatomic,strong)UIButton * messBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIView * lineView1;
@property(nonatomic,strong)UIImageView * baojianImage;
@property(nonatomic,strong)UILabel * baojianLaber;
@property(nonatomic,strong)UIImageView * renzhengImage;
@property(nonatomic,strong)UILabel * renzhengLaber;
@property(nonatomic,strong)UILabel * numchanpin;
@property(nonatomic,strong)UILabel * chanpinLaber;
@property(nonatomic,strong)UILabel * numzixunLaber;
@property(nonatomic,strong)UILabel * zixunLaber;
@property(nonatomic,strong)UILabel * numbaodanLaber;
@property(nonatomic,strong)UILabel * baodanLaber;
@property(nonatomic,strong)UILabel * numkehuLaber;
@property(nonatomic,strong)UILabel * kehuLaber;
@property(nonatomic,strong)UIView * headView;


@end

@implementation WHpreviewTableViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //请求数据
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setupUI];

}

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"微站";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    self.tableV.tableHeaderView = self.headView ;
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight *0.5);
    [self.view addSubview:_headView];
    [self.tableV registerClass:[WHprevTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //
    
    self.headImage = [[UIImageView alloc]init];
    self.headImage.frame = CGRectMake(10, 10, kScreenWitdh * 0.2, kScreenWitdh *0.2);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kScreenWitdh *0.1;
    self.headImage.image = [UIImage imageNamed:@"test_head"];
    [self.headView addSubview:_headImage];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame)+5, CGRectGetMinY(self.headImage.frame), kScreenWitdh* 0.15, kScreenWitdh * 0.1);
    self.nameLaber.text = @"周星星";
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self.headView addSubview:_nameLaber];
    
    //
    self.sexImage = [[UIImageView alloc]init];
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+3, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
    self.sexImage.image = [UIImage imageNamed:@"test_male"];
    [self.headView addSubview:_sexImage];
    
    //
    self.yearLaber = [[UILabel alloc]init];
    self.yearLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImage.frame)+3, CGRectGetMinY(self.sexImage.frame), kScreenWitdh * 0.1, 20);
    self.yearLaber.textColor = [UIColor grayColor];
    self.yearLaber.font = [UIFont systemFontOfSize:13.0];
    self.yearLaber.text = @"36岁";
    [self.headView addSubview:_yearLaber];
    //
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame),CGRectGetMaxY(self.nameLaber.frame)+5,  kScreenWitdh * 0.4, 20);
    self.companyLaber.text = @"新华人寿 经理 从业5年 全国";
    self.companyLaber.font = [UIFont systemFontOfSize:11.0];
    self.companyLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_companyLaber];
    //
    self.messBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    //self.messBut.frame = CGRectMake(CGRectGetMaxX(<#CGRect rect#>), <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    
    

}

// 请求数据
-(void)requestData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     
     
     */
    
    
    return 24;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.081;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   WHprevTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"";
    
    return cell;
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
