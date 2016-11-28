//
//  WHlookForViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/1.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHlookForViewController.h"
#import "JGProgressHelper.h"



@interface WHlookForViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
@property(nonatomic,strong)UILabel * profesLaber;
@property(nonatomic,strong)UILabel * worktimeLaber;
@property(nonatomic,strong)UILabel * cityLaber;
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
@property(nonatomic,strong)UIScrollView * scolw;
//



@end

@implementation WHlookForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.view .backgroundColor = [UIColor redColor];
    
    // 布局
    [self setupUI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //请求数据
    [self requestData];
}
// 请求数据
-(void)requestData
{

//    [self.dataService get_user_infoWithUid:@"" success:^(NSArray *lists) {
//      //  self.mesArry = [NSMutableArray arrayWithArray:lists];
//        for (WHgetuseinfo * model in lists) {
//            
//            if (model.avatar.length == 0) {
//                self.headImage.image = [UIImage imageNamed:@"Hm_head.png"];
//            }
//            
//            [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
//            self.nameLaber.text = model.name;
//            self.yearLaber.text = model.age;
//            self.area = model.area_info;
//            self.address = model.address;
//            self.company = model.company;
//            
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    
}

#pragma mark -- 布局
-(void)setupUI
{
   self.title = @"微站";
    self.scolw.delegate = self;
    self.scolw = [[UIScrollView alloc]init];
    self.scolw.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    
    self.scolw.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*4);
    [self.view addSubview:_scolw];
    
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
