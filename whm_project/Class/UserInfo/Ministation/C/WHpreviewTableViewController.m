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
#import "JGProgressHelper.h"
#import "WHmicro.h"

@interface WHpreviewTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
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
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)NSMutableArray * daraArry;

//基本信息


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
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight* 0.32, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    self.tableV.tableHeaderView = self.headView ;
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight *0.3);
    [self.view addSubview:_headView];
    [self.tableV registerClass:[WHprevTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //
    
    self.headImage = [[UIImageView alloc]init];
    self.headImage.frame = CGRectMake(10, 10, kScreenWitdh * 0.2, kScreenWitdh *0.2);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kScreenWitdh *0.1;
    self.headImage.image = [UIImage imageNamed:@"test_head"];
    [self.headView addSubview:_headImage];
   // self.headView.backgroundColor = [UIColor redColor];
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
    self.messBut.frame = CGRectMake(CGRectGetMaxX(self.companyLaber.frame)+20, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.messBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    self.messBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_messBut];
    [self.messBut addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(CGRectGetMaxX(self.messBut.frame)+5, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    self.telBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_telBut];
    [self.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
   //
    self.lineView1 = [[UIView alloc]init];
    self.lineView1.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame)+5, kScreenWitdh, 1);
    self.lineView1.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:_lineView1];
    //
    
    self.baojianImage = [[UIImageView alloc]init];
    self.baojianImage.frame = CGRectMake(CGRectGetMinX(self.headImage.frame), CGRectGetMaxY(self.lineView1.frame)+5, 20, 20);
    self.baojianImage.image = [UIImage imageNamed:@"baojian.png"];
    [self.headView addSubview:_baojianImage];
    //
    self.baojianLaber = [[UILabel alloc]init];
    self.baojianLaber.frame = CGRectMake(CGRectGetMaxX(self.baojianImage.frame)+2, CGRectGetMinY(self.baojianImage.frame), CGRectGetWidth(self.baojianImage.frame)*2.5, CGRectGetHeight(self.baojianImage.frame));
    self.baojianLaber.text = @"保监认证";
    //self.baojianLaber.textColor = [UIColor whiteColor];
    self.baojianLaber.font = [UIFont systemFontOfSize:11.0];
    [self.headView addSubview:_baojianLaber];
    //
    self.renzhengImage = [[UIImageView alloc]init];
    self.renzhengImage.frame = CGRectMake(CGRectGetMaxX(self.companyLaber.frame), CGRectGetMinY(self.baojianLaber.frame), CGRectGetWidth(self.baojianImage.frame), CGRectGetHeight(self.baojianImage.frame));
    self.renzhengImage.image = [UIImage imageNamed:@"renzheng.png"];
    [self.headView addSubview:_renzhengImage];
    //
    self.renzhengLaber = [[UILabel alloc]init];
    self.renzhengLaber.frame = CGRectMake(CGRectGetMaxX(self.renzhengImage.frame)+2, CGRectGetMinY(self.renzhengImage.frame), CGRectGetWidth(self.baojianLaber.frame)*1.2, CGRectGetHeight(self.baojianLaber.frame));
    //self.renzhengLaber.textColor = [UIColor whiteColor];
    self.renzhengLaber.text = @"快保家认证";
    self.renzhengLaber.font = [UIFont systemFontOfSize:11.0];
    [self.headView addSubview:_renzhengLaber];
    self.lineView2 = [[UIView alloc]init];
    self.lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.baojianLaber.frame)+5, kScreenWitdh, 1);
    self.lineView2.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:_lineView2];
    
    //产品类型咨询等设计
    self.numchanpin = [[UILabel alloc]init];
    self.numchanpin.frame = CGRectMake(CGRectGetMinX(self.baojianLaber.frame), CGRectGetMaxY(self.lineView2.frame)+5, kScreenWitdh*0.2, 30);
    self.numchanpin.text = @"152";
    self.numchanpin.textColor = [UIColor greenColor];
    [self.headView addSubview:_numchanpin];
    self.chanpinLaber = [[UILabel alloc]init];
    self.chanpinLaber.frame = CGRectMake(CGRectGetMinX(self.numchanpin.frame), CGRectGetMaxY(self.numchanpin.frame)+3, 60, 20);
    self.chanpinLaber.font = [UIFont systemFontOfSize:11.0];
    self.chanpinLaber.text = @"产品";
    self.chanpinLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_chanpinLaber];
    //
    self.numzixunLaber = [[UILabel alloc]init];
    self.numzixunLaber.frame = CGRectMake(CGRectGetMaxX(self.numchanpin.frame)+5, CGRectGetMinY(self.numchanpin.frame),CGRectGetWidth(self.numchanpin.frame), CGRectGetHeight(self.numchanpin.frame));
    self.numzixunLaber.textColor = [UIColor blueColor];
    self.numzixunLaber.text = @"60";
    [self.headView addSubview:_numzixunLaber];
    //
    self.zixunLaber = [[UILabel alloc]init];
    self.zixunLaber.frame = CGRectMake(CGRectGetMinX(self.numzixunLaber.frame), CGRectGetMinY(self.chanpinLaber.frame), CGRectGetWidth(self.chanpinLaber.frame), CGRectGetHeight(self.chanpinLaber.frame));
    self.zixunLaber.textColor = [UIColor grayColor];
    self.zixunLaber.font = [UIFont systemFontOfSize:11.0];
    self.zixunLaber.text = @"咨询";
    [self.headView addSubview:_zixunLaber];
    
    //
    self.numbaodanLaber = [[UILabel alloc]init];
    self.numbaodanLaber.frame = CGRectMake(CGRectGetMaxX(self.numzixunLaber.frame)+5, CGRectGetMinY(self.numzixunLaber.frame), CGRectGetWidth(self.numzixunLaber.frame), CGRectGetHeight(self.numzixunLaber.frame));
    self.numbaodanLaber.textColor = [UIColor blueColor];
    self.numbaodanLaber.text = @"250";
    [self.headView addSubview:_numbaodanLaber];
    
    //
    self.baodanLaber =[[UILabel alloc]init];
    self.baodanLaber.frame = CGRectMake(CGRectGetMinX(self.numbaodanLaber.frame), CGRectGetMinY(self.zixunLaber.frame), CGRectGetWidth(self.zixunLaber.frame), CGRectGetHeight(self.zixunLaber.frame));
    self.baodanLaber.textColor = [UIColor grayColor];
    self.baodanLaber.font = [UIFont systemFontOfSize:11.0];
    self.baodanLaber.text = @"保单体检";
    [self.headView addSubview:_baodanLaber];
    
    //
    self.numkehuLaber = [[UILabel alloc]init];
    self.numkehuLaber.frame = CGRectMake(CGRectGetMaxX(self.numbaodanLaber.frame)+5, CGRectGetMinY(self.numbaodanLaber.frame), CGRectGetWidth(self.numbaodanLaber.frame), CGRectGetHeight(self.numbaodanLaber.frame));
    self.numkehuLaber.textColor = [UIColor blueColor];
    self.numkehuLaber.text = @"300";
    [self.headView addSubview:_numkehuLaber];
    
    //
    self.kehuLaber = [[UILabel alloc]init];
    self.kehuLaber.frame = CGRectMake(CGRectGetMinX(self.numkehuLaber.frame), CGRectGetMinY(self.baodanLaber.frame), CGRectGetWidth(self.baodanLaber.frame), CGRectGetHeight(self.baodanLaber.frame));
    self.kehuLaber.textColor = [UIColor grayColor];
    self.kehuLaber.font = [UIFont systemFontOfSize:11.0];
    self.kehuLaber.text = @"服务客户";
    [self.headView addSubview:_kehuLaber];
    
    

}


// 请求数据
-(void)requestData
{
    id  hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getMicroWithAgent_uid:@"" uid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.daraArry = [NSMutableArray array];
        for (WHmicro * model in lists) {
            NSLog(@"ooooo%@",model.agent_info);
        }
        
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper  showError:@""];
        
    }];
    
}

//信息事件
-(void)messageAction:(UIButton *)sender
{
    
}

//
//电话事件
-(void)telAction:(UIButton *)sender
{
    
}
//
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
     NSString * s1 = @"基本信息";
        return s1;
    }
    if (section == 1) {
        NSString * s1 = @"个人介绍";
        return s1;
    }
    if (section == 2) {
        NSString * s1 = @"个人荣誉";
        return s1;
    }
    if (section == 3) {
        NSString * s1 = @"推荐险种";
        return s1;
    }
    if (section == 4) {
        NSString * s1 = @"我要留言";
        return s1;
    }
    if (section == 5) {
        NSString * s1 = @"保险咨询";
        return s1;
    }
    if (section == 6) {
        NSString * s1 = @"保险方案";
        return s1;
    }

    
    else
    {
        return nil;
    }
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

    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section == 0) {
        return 7;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
        
    else
    {
    return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = @"执行区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"所属区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
             cell.detailTextLabel.text = @"全国";
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.textLabel.text = @"所属公司";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.textLabel.text = @"所在机构";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }
        if (indexPath.section == 0 && indexPath.row == 4) {
            cell.textLabel.text = @"机构地址";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }
        
        if (indexPath.section == 0 && indexPath.row == 5) {
            cell.textLabel.text = @"资格证书号码";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }

        if (indexPath.section == 0 && indexPath.row == 6) {
            cell.textLabel.text = @"执业证编号";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            cell.detailTextLabel.text = @"全国";
        }

    }
    
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
