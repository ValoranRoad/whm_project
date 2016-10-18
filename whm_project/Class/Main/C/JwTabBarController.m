//
//  JwTabBarController.m
//  Jw_Frame
//
//  Created by Jw on 16/6/17.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "JwTabBarController.h"
#import "JwNavigationController.h"
#import "UIView+Extension.h"
#import "MacroUtility.h"

#import "JwHomeController.h"
#import "JwPhysicalController.h"
#import "JwLookForController.h"
#import "JwFindController.h"
#import "JwUserInfoController.h"


@interface JwTabBarController ()<UITabBarControllerDelegate>

@end

@implementation JwTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    JwHomeController *home = [[JwHomeController alloc] init];
    JwPhysicalController *physical = [[JwPhysicalController alloc] init];
    JwLookForController *lookfor = [[JwLookForController alloc] init];
    JwFindController *find = [[JwFindController alloc] init];
    JwUserInfoController *user = [[JwUserInfoController alloc] init];
    
    JwNavigationController *homeVC = [[JwNavigationController alloc] initWithRootViewController:home];
    JwNavigationController *physicalVC = [[JwNavigationController alloc] initWithRootViewController:physical];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    JwNavigationController *findVC = [[JwNavigationController alloc] initWithRootViewController:find];
    JwNavigationController *userVC = [[JwNavigationController alloc] initWithRootViewController:user];
    
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    physicalVC.tabBarItem.image = [[UIImage imageNamed:@"physical"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.image = [[UIImage imageNamed:@"lookfor"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    lookforVC.tabBarItem.tag = 101;
    
    
    findVC.tabBarItem.image = [[UIImage imageNamed:@"find"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    userVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_h"];
    physicalVC.tabBarItem.selectedImage = [UIImage imageNamed:@"physical_h"];
    lookforVC.tabBarItem.selectedImage = [UIImage imageNamed:@"lookfor_h"];
    findVC.tabBarItem.selectedImage = [UIImage imageNamed:@"find_h"];
    userVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
    
    home.title = homeVC.title = @"首页";
    physical.title = physicalVC.title = @"体检";
    lookfor.title = lookforVC.title = @"找险";
    find.title = findVC.title = @"发现";
    user.title = userVC.title = @"我的";
    
    self.viewControllers = @[homeVC, physicalVC, lookforVC, findVC, userVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (item.tag == 101) {
        
        [self setupShareView];
    }
}

- (void)setupShareView{
    
    //中间按钮pop控制器
    DLog(@"中间点击事件");
    JwLookForController *lookfor = [[JwLookForController alloc] init];
    JwNavigationController *lookforVC = [[JwNavigationController alloc] initWithRootViewController:lookfor];
    lookfor.title = lookforVC.title = @"找险";
    [self presentViewController:lookforVC animated:YES completion:nil];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBarController.viewControllers objectAtIndex:2]) {
        return NO;
    }else{
        return YES;
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