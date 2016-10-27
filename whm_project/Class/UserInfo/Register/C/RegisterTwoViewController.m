//
//  RegisterTwoViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "registerTwoTableViewCell.h"
#import "ChooseCompleteViewController.h"
#import "InsuranceViewController.h"
#import "CompleteTypeViewController.h"



#define kScreenW [[UIScreen mainScreen] bounds].size.width
@interface RegisterTwoViewController ()<UITableViewDelegate,UITableViewDataSource,completeTypeDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSString *compName;
@property (nonatomic,strong)NSString *compId;

@end

@implementation RegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74/255.0 green:108/255.0 blue:246/255.0 alpha:0.5];
    
    [self setUI];
    
}
-(void)setUI
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenW , 40)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *promptLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, kScreenW - 30, 25)];
    promptLab.text = @"快保家不会再任何地方泄露用户的个人信息";
    promptLab.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:150/255.0 alpha:1.0];
    promptLab.font = [UIFont systemFontOfSize:10];
    promptLab.backgroundColor = [UIColor clearColor];
    [headView addSubview:promptLab];
    
    
    
    
    [self creatTable];
    self.tableView.tableHeaderView = headView;
    //self.tableView.backgroundColor
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.frame = CGRectMake(50, CGRectGetMaxY(_tableView.frame) + 40, kScreenW - 100, 50);
    registBtn.layer.cornerRadius = 25;
    [registBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.backgroundColor = [UIColor colorWithRed:74/255.0 green:108/255.0 blue:246/255.0 alpha:1.0];
    [registBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registBtn];

    
    
}
-(void)registerBtnAction
{
    
}

-(void)creatTable
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 240) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[registerTwoTableViewCell class] forCellReuseIdentifier:@"regCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    registerTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regCell"];
    
    if (indexPath.row == 0)
    {
        cell.myImage.image = [UIImage imageNamed:@"leixing"];
        cell.clickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cell.clickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        cell.arrowImge.image = [UIImage imageNamed:@"tjzh-2@3x"];
        [cell.clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.clickBtn.tag = 101;
        
        if (_compName == nil)
        {
            [cell.clickBtn setTitle:@"请选择公司类型" forState:UIControlStateNormal];
        }
        else
        {
             [cell.clickBtn setTitle:_compName forState:UIControlStateNormal];
        }
     
    }
    else if (indexPath.row == 1)
    {
        cell.myImage.image = [UIImage imageNamed:@"gongsi"];
        [cell.clickBtn setTitle:@"请选择保险公司名称" forState:UIControlStateNormal];
        cell.clickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cell.clickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        cell.arrowImge.image = [UIImage imageNamed:@"tjzh-2@3x"];
        [cell.clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

        cell.clickBtn.tag = 102;
    }
    else if(indexPath.row == 2)
    {
        cell.myImage.image = [UIImage imageNamed:@"jigou"];
        [cell.clickBtn setTitle:@"请选择所在机构" forState:UIControlStateNormal];
        cell.clickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cell.clickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        cell.arrowImge.image = [UIImage imageNamed:@"tjzh-2@3x"];
        [cell.clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.clickBtn.tag = 103;

    }
    
    else if(indexPath.row == 3)
    {
        cell.myImage.image = [UIImage imageNamed:@"dizhi"];
        [cell.clickBtn setTitle:@"公司地址自动带入" forState:UIControlStateNormal];
        cell.clickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        cell.clickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        cell.arrowImge.image = [UIImage imageNamed:@"tjzh-2@3x"];
        [cell.clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

        cell.clickBtn.tag = 104;
    }
    
    
    return cell;
}

-(void)clickAction:(UIButton *)sender
{
    if (sender.tag == 101)
    {
        NSLog(@"点击了公司类型");
        CompleteTypeViewController *compVC = [[CompleteTypeViewController alloc]init];
        compVC.delegate = self;
        [self.navigationController pushViewController:compVC animated:YES];
    }
    if (sender.tag == 102)
    {
        InsuranceViewController *insuranceVC = [[InsuranceViewController alloc]init];
        [self.navigationController pushViewController:insuranceVC animated:YES];
    }
    if (sender.tag == 103)
    {
        ChooseCompleteViewController *chooseVC = [[ChooseCompleteViewController alloc]init];
        [self.navigationController pushViewController:chooseVC animated:YES];
    }
}

-(void)completeName:(NSString *)cName completeId:(NSString *)cId
{
    self.compName = cName;
    self.compId = cId;
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
