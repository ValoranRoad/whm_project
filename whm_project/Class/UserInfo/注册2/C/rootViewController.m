//
//  rootViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "rootViewController.h"
#import "RegisterTwoViewController.h"
@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeSystem];
    myButton.frame = CGRectMake(100, 100, 100,100);
    myButton.backgroundColor = [UIColor redColor];
    [myButton setTitle:@"注册" forState:UIControlStateNormal];
    
    [myButton addTarget:self action:@selector(myBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myButton];
    
    
    
}

-(void)myBtnAction
{
    RegisterTwoViewController *regVC = [[RegisterTwoViewController alloc]init];
    
    [self.navigationController pushViewController:regVC animated:YES];
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
