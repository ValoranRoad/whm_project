//
//  JwHomeController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwHomeController.h"
#import "JwUserService.h"
#import "JwAreass.h"

@interface JwHomeController ()

@end

@implementation JwHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    //测试
//    [self.userService get_all_areaWithsuccess:^(NSArray *areas) {
//        
//        for (JwAreass *area in areas) {
//            NSLog(@"%@", area.area_name);
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    
}

- (void)setupData{
    
    
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
