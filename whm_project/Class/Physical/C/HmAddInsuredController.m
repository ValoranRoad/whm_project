//
//  HmAddInsuredController.m
//  whm_project
//
//  Created by zhaoHm on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmAddInsuredController.h"
#import "WHsexViewController.h"
//
#import "ASBirthSelectSheet.h"
#import "WHrelationTableViewController.h"


@interface HmAddInsuredController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *sexLaber;
@property (weak, nonatomic) IBOutlet UILabel *birthLaber;

@property (weak, nonatomic) IBOutlet UILabel *relationLaber;

@property (weak, nonatomic) IBOutlet UITextField *yearComeText;

@property (weak, nonatomic) IBOutlet UITextField *yearOutText;
@property (weak, nonatomic) IBOutlet UITextField *debtText;
@property (weak, nonatomic) IBOutlet UIImageView *phoMyimage;

@property(nonatomic,strong) NSString * relatID;

@end

@implementation HmAddInsuredController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"添加被保人";
    [self DateSetUp];
    
    
}

//UI事件
-(void)DateSetUp
{
    //性别选择
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.sexLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired=1;
    
    [self.sexLaber addGestureRecognizer:tapGesture];
    
    //出生日期选择
    
    UITapGestureRecognizer *tapGesture1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.birthLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture1.numberOfTouchesRequired=1;
    
    [self.birthLaber addGestureRecognizer:tapGesture1];
    
    //被保人关系
    UITapGestureRecognizer *tapGesture2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable2:)];
    self.relationLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture2.numberOfTouchesRequired=1;
    
    [self.relationLaber addGestureRecognizer:tapGesture2];

    
    
}

//被保人关系
-(void)onClickUILable2:(UITapGestureRecognizer *)sender{

    WHrelationTableViewController * relation = [[WHrelationTableViewController alloc]init];
    relation.mblock2 = ^(NSString * s1,NSString * s2)
    {
        self.relationLaber.text = s1;
        self.relatID = s2 ;
        
        
    };
    
    
    [self.navigationController pushViewController:relation animated:NO];
    
}

//出生日期选择
-(void)onClickUILable1:(UITapGestureRecognizer *)sender{
    
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = self.birthLaber.text;
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        self.birthLaber.text = dateStr;
    };
    [self.view addSubview:datesheet];

    
}


//性别选择
-(void)onClickUILable:(UITapGestureRecognizer *)sender{

    
    WHsexViewController * whsex = [[WHsexViewController alloc]init];
    
    whsex.mblock1 = ^(NSString * s1)
    {
        self.sexLaber.text = s1;
        
    };
    
    [self.navigationController pushViewController:whsex animated:NO];
    //相应代码
   
    
}


//点击确定事件
- (IBAction)trueBut:(id)sender {
     NSLog(@"kkk");
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
