//
//  WHupdatePwdViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/20.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHupdatePwdViewController.h"

#import "WHrestPwdViewController.h"
#import "ForgetPwdViewController.h"

@interface WHupdatePwdViewController ()
@property(nonatomic,strong)UIImageView * myImage;
@property(nonatomic,strong)UITextField * OldpwdText;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UIButton * myBut;
@property(nonatomic,strong)UIButton * forgetPwdBut;


@end

@implementation WHupdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"密码验证";
    
    [self setUi];
    
}
-(void)setUi
{
    self.OldpwdText = [[UITextField alloc]init];
    self.OldpwdText.frame = CGRectMake(10, CGRectGetHeight([UIScreen mainScreen].bounds)*0.055, CGRectGetWidth([UIScreen mainScreen].bounds)*0.6, 36);
    self.OldpwdText.placeholder = @"请输入你的原密码";
    self.OldpwdText.borderStyle = UITextBorderStyleNone;
    self.OldpwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.myImage = [[UIImageView alloc]init];
    self.myImage.frame = CGRectMake(0, 0, 30, 30);
    self.myImage.image = [UIImage imageNamed:@"Jw_lock"];
    self.OldpwdText.leftView = self.myImage;
    self.OldpwdText.leftViewMode = UITextFieldViewModeAlways;
    //
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.OldpwdText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    
    [self.view addSubview:_lineView];
    [self.view addSubview:_OldpwdText];
    
    //
    self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut.frame = CGRectMake(20, CGRectGetMaxY(self.lineView.frame)+30, CGRectGetWidth([UIScreen mainScreen].bounds)-40, CGRectGetHeight(self.OldpwdText.frame)*1.2);
    [self.myBut setTitle:@"下一步" forState:(UIControlStateNormal)];
    self.myBut.backgroundColor = [UIColor colorWithRed:0.234 green:0.332 blue:0.996 alpha:1];
    self.myBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.myBut.layer.shadowOpacity = 0.8;
    self.myBut.layer.shadowColor = [UIColor blueColor].CGColor;
    
    [self.myBut setTintColor:[UIColor whiteColor]];
    self.myBut.layer.cornerRadius = 15.0;
    [self.view addSubview:_myBut];
 //
    self.forgetPwdBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.forgetPwdBut.frame = CGRectMake(CGRectGetWidth(self.myBut.frame)*0.35, CGRectGetMaxY(self.myBut.frame)+10, CGRectGetWidth(self.myBut.frame)*0.4, CGRectGetHeight(self.myBut.frame)*0.8);
    
    [self.forgetPwdBut  setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    self.forgetPwdBut.font = [UIFont systemFontOfSize:15.0];
    self.forgetPwdBut.tintColor = [UIColor grayColor];
    [self.view addSubview:_forgetPwdBut];
    
    [self.forgetPwdBut addTarget:self action:@selector(forgetPwdButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.myBut addTarget: self action:@selector(myButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//忘记密码
-(void)forgetPwdButAction:(UIButton *)sender
{
    ForgetPwdViewController * forgetpwd = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forgetpwd animated:NO];
}

//重置密码
-(void)myButAction:(UIButton *)sender
{
    WHrestPwdViewController * restPwd = [[WHrestPwdViewController alloc]init];
    [self.navigationController pushViewController:restPwd animated:NO];
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
