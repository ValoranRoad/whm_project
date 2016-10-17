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
#import "JwViewController.h"
#import "MacroUtility.h"

@interface JwTabBarController ()<UITabBarControllerDelegate>

@end

@implementation JwTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    JwViewController *home = [[JwViewController alloc] init];
    JwViewController *reminder = [[JwViewController alloc] init];
    JwViewController *share = [[JwViewController alloc] init];
    JwViewController *notifiction = [[JwViewController alloc] init];
    JwViewController *account = [[JwViewController alloc] init];
    
    JwNavigationController *homeVC = [[JwNavigationController alloc] initWithRootViewController:home];
    JwNavigationController *reminderVC = [[JwNavigationController alloc] initWithRootViewController:reminder];
    JwNavigationController *shareVC = [[JwNavigationController alloc] initWithRootViewController:share];
    JwNavigationController *notifictionVC = [[JwNavigationController alloc] initWithRootViewController:notifiction];
    JwNavigationController *accountVC = [[JwNavigationController alloc] initWithRootViewController:account];
    
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    reminderVC.tabBarItem.image = [[UIImage imageNamed:@"physical"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    shareVC.tabBarItem.image = [[UIImage imageNamed:@"lookfor"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    shareVC.tabBarItem.tag = 101;
    
    
    notifictionVC.tabBarItem.image = [[UIImage imageNamed:@"find"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    accountVC.tabBarItem.image = [[UIImage imageNamed:@"user"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_h"];
    reminderVC.tabBarItem.selectedImage = [UIImage imageNamed:@"physical_h"];
    shareVC.tabBarItem.selectedImage = [UIImage imageNamed:@"lookfor_h"];
    notifictionVC.tabBarItem.selectedImage = [UIImage imageNamed:@"find_h"];
    accountVC.tabBarItem.selectedImage = [UIImage imageNamed:@"user_h"];
    
    home.title = homeVC.title = @"首页";
    reminder.title = reminderVC.title = @"体检";
    share.title = shareVC.title = @"找险";
    notifiction.title = notifictionVC.title = @"发现";
    account.title = accountVC.title = @"我的";
    
    //self.tabBar.tintColor = [UIColor whiteColor];
    //self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.viewControllers = @[homeVC, reminderVC, shareVC, notifictionVC, accountVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if (item.tag == 101) {
        
        [self setupShareView];
    }
}

- (void)setupShareView{
    
    //中间按钮pop控制器
    DLog(@"中间点击事件");
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
