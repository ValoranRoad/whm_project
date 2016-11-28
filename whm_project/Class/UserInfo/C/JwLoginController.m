//
//  JwLoginController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwLoginController.h"
#import "UIColor+Hex.h"
#import "JwRegistController.h"
#import "JGProgressHelper.h"
#import "JwUser.h"
#import "ForgetPwdViewController.h"

#import "WHpersonCenterViewController.h"


#import "RegisterTwoViewController.h"
@interface JwLoginController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *mobV;
@property (weak, nonatomic) IBOutlet UIView *pwdV;

@property (weak, nonatomic) IBOutlet UIButton *newsB;
@property (weak, nonatomic) IBOutlet UIButton *baoB;

@property (weak, nonatomic) IBOutlet UITextField *mobTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *clearB;
@property (weak, nonatomic) IBOutlet UIButton *eyeB;

@property (weak, nonatomic) IBOutlet UIButton *loginBut;

@end

@implementation JwLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //去除返回按钮附近的字体
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.title = @"登录";
    [self setupView];
    
//    if (self.mobTF.text.length == 0) {
//        self.loginBut.userInteractionEnabled = NO;
//    }
//    else
//    {
//        self.loginBut.userInteractionEnabled = YES;
//    }
    self.mobTF.text = @"13213011251";
    self.pwdTF.text = @"wyg511688";

}

- (void)setupView{
    
    self.mobV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.pwdV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.newsB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.baoB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    
    self.clearB.hidden = YES;
    self.eyeB.hidden = YES;
    
    [self.mobTF addTarget:self action:@selector(mobTFChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.pwdTF addTarget:self action:@selector(pwdTFChange:) forControlEvents:(UIControlEventEditingChanged)];
    self.pwdTF.delegate = self;
}

- (void)mobTFChange:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.clearB.hidden = NO;
    }else{
        self.clearB.hidden = YES;
    }
}

- (void)pwdTFChange:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.eyeB.hidden = NO;
    }else{
        self.eyeB.hidden = YES;
    }
}

//保险顾问注册
- (IBAction)PropertBut:(id)sender {
    
    NSLog(@"hhh");
    
    JwRegistController *registVC = [[JwRegistController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
//    RegisterTwoViewController *regVC = [[RegisterTwoViewController alloc]init];
//    [self.navigationController pushViewController:regVC animated:YES];
}

//忘记密码
- (IBAction)ForgetPwdAction:(id)sender {
    ForgetPwdViewController * forgetPwd = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forgetPwd animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self pwdTFChange:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{
    self.pwdTF.secureTextEntry = YES;
    self.eyeB.hidden = YES;
}

- (IBAction)onClear:(UIButton *)sender {
    self.mobTF.text = @"";
    self.clearB.hidden = YES;
}

- (IBAction)onEye:(UIButton *)sender {
    if (self.pwdTF.secureTextEntry == YES) {
        self.pwdTF.secureTextEntry = NO;
    }else{
        self.pwdTF.secureTextEntry = YES;
    }
}
//新用户注册
- (IBAction)onNews:(UIButton *)sender {
    JwRegistController *registVC = [[JwRegistController alloc] init];
     NSString * s1 = @"new";
    
    registVC.strNew = s1;
    [self.navigationController pushViewController:registVC animated:YES];
}
//登录
- (IBAction)onLogin:(UIButton *)sender {
    
    if (self.mobTF.text.length != 0 && self.pwdTF.text.length != 0) {
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService loginWithMobile:self.mobTF.text password:self.pwdTF.text success:^(JwUser *user) {
            [hud hide:YES];
            [JGProgressHelper  showSuccess:@"登录成功"];
            WHpersonCenterViewController * myself = [[WHpersonCenterViewController alloc]init];
            
            [self.navigationController pushViewController:myself animated:NO];
            
            NSLog(@"%@", user.name);
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"你输入的账号或密码有误请核查"];
        }];
        
    }else{
        [JGProgressHelper showError:@"请输入账号或密码!"];
    }
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
