//
//  JwPhysicalController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwPhysicalController.h"
#import "HmSelectProductController.h"

@interface JwPhysicalController ()

@end

@implementation JwPhysicalController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    HmSelectProductController *cv = [[HmSelectProductController alloc] init];
    [self.navigationController pushViewController:cv animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
