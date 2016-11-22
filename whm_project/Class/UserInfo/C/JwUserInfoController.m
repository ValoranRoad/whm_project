//
//  JwUserInfoController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwUserInfoController.h"
#import "JwNavigationController.h"
#import "JwLoginController.h"
#import "JwUserCenter.h"
#import "WHpersonCenterViewController.h"
@interface JwUserInfoController ()

@end

@implementation JwUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([JwUserCenter sharedCenter].uid != nil) {
        WHpersonCenterViewController * person = [[WHpersonCenterViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
        
    }
    else
    {
    JwLoginController *loginVC = [[JwLoginController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    JwLoginController *loginVC = [[JwLoginController alloc] init];
//    [self.navigationController pushViewController:loginVC animated:YES];
    
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
