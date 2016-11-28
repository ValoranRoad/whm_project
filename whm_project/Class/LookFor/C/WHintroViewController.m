//
//  WHintroViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHintroViewController.h"

@interface WHintroViewController ()

@end

@implementation WHintroViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
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
