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

@interface JwLoginController ()

@property (weak, nonatomic) IBOutlet UIView *mobV;
@property (weak, nonatomic) IBOutlet UIView *pwdV;

@property (weak, nonatomic) IBOutlet UIButton *newsB;
@property (weak, nonatomic) IBOutlet UIButton *baoB;


@end

@implementation JwLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    [self setupView];
}

- (void)setupView{
    
    self.mobV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.pwdV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.newsB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.baoB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
}

- (IBAction)onLogin:(UIButton *)sender {
    
    JwRegistController *registVC = [[JwRegistController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
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
