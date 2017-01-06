//
//  WHcredEntViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcredEntViewController.h"
#import "WHcredEntView.h"
#import "JGProgressHelper.h"
#import "WHcompanyTableViewController.h"
#import "WHorgselectTableViewController.h"

@interface WHcredEntViewController ()
@property(nonatomic,strong) WHcredEntView * CE;
@property(nonatomic,strong)NSString * comid;
@property(nonatomic,strong)NSString * orgId;

@end

@implementation WHcredEntViewController

-(void)loadView
{
    self.CE = [[WHcredEntView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _CE;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.CE.cleckImg1.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1 ;
    [self.CE.cleckImg1 addGestureRecognizer:tapGesture];
    //self.CE.peopText.enabled = false;
    self.title = @"认证信息";
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.CE.cleckImg.userInteractionEnabled = YES;
    tapGesture1.numberOfTapsRequired = 1;
    tapGesture1.numberOfTouchesRequired = 1 ;
    [self.CE.cleckImg addGestureRecognizer:tapGesture1];
    
    [self.CE.nextBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

    
    
}
-(void)nextButAction:(UIButton *)sender
{
    if (self.CE.ProNumText.text != nil) {
        if (self.CE.comNameText.text != nil) {
            if (self.orgId != nil) {
            
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService save_verifyWithUid:@""
                                 company:self.comid
                                    name:self.CE.ProNumText.text
                              cardnumber:self.CE.comNameText.text
                      organizationnumber:self.orgId
                                   point:self.CE.likeText.text
                                 address:self.CE.beneText.text
                                     job:self.CE.dateText.text
                                 success:^{
                                     [hud hide:YES];
                                     [JGProgressHelper showSuccess:@"保存成功"];
                                     
                                 } failure:^(NSError *error) {
                                     [hud hide:YES];
                                     [JGProgressHelper showError:@"失败"];
                                     
                                 }];
            }
            else
            {
                [JGProgressHelper showError:@"请选择分支机构"];
            }

    }else
    {
        [JGProgressHelper showError:@"请输入你的身份证号"];
    }
    }
    
    else
    {
        [JGProgressHelper showError:@"请输入你的真实姓名"];
    }
}

-(void)onClickUILable1:(UITapGestureRecognizer *)sender
{
    if (self.comid  != nil) {
    
    WHorgselectTableViewController * orgin = [[WHorgselectTableViewController alloc]init];
    orgin.com_id = self.comid;
    orgin. mblock2 = ^(NSString * s1 ,NSString * s2 ,NSString * s3 )
    {
        self.CE.nameText.text = s2 ;
        self.CE.beneText.text = s3 ;
        self.orgId = s1 ;
        
    };

    [self.navigationController pushViewController:orgin  animated:YES];
    }
    else
    {
        [JGProgressHelper showError:@"请先选择保险公司"];
    }
}
-(void)onClickUILable:(UITapGestureRecognizer *)sender
{
    WHcompanyTableViewController * company = [[WHcompanyTableViewController alloc]init];
    company. mblock1 = ^(NSString * s1 ,NSString * s2)
    {
        self.CE.peopText.text = s2 ;
        self.comid = s1 ;
        
    };
    
    [self.navigationController pushViewController:company animated:YES];
    
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
