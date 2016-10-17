//
//  RootTarBarController.m
//  LeYingApp
//
//  Created by sks on 15/12/10.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "RootTarBarController.h"
#import "MainViewController.h"
#import "UsersTableViewController.h"
#import "ArtistTableViewController.h"
#import "JoinViewController.h"


@interface RootTarBarController ()

@end

@implementation RootTarBarController

- (void)viewDidLoad
{
    self.tabBar.tintColor=[UIColor whiteColor];
    [super viewDidLoad];
   

    
    MainViewController *mainController = [[MainViewController alloc]init];
    UINavigationController *mainVC = [[UINavigationController alloc]initWithRootViewController:mainController];
 
   
//    mainVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"乐影" image:[UIImage imageNamed:@"bot1.png"] selectedImage:[UIImage imageNamed:@"both1.png"]];
//    
    
    UIImage *img = [UIImage imageNamed:@"both1.png"];
    img =  [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [mainVC.tabBarItem setFinishedSelectedImage:img
             withFinishedUnselectedImage:[UIImage imageNamed:@"bot1.png"]];
    mainVC.tabBarItem.title = @"乐影";
   
    
    //设置tabbar字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:72/255.0f green:232/255.0f blue:223/255.0f alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];


   // mainVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"影片众筹" image:[UIImage imageNamed:@"zc@3x.png"] selectedImage:[UIImage imageNamed:@"zc_highlight@3x.png"]];
    
    
    //设置tabbar的背景图片
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, CGRectGetWidth(self.view.frame), 49)];
    backView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"sydibu.jpg"] ];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    
    
    
    
    
    
    
    UsersTableViewController *userController = [[UsersTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *userVC = [[UINavigationController alloc]initWithRootViewController:userController];
    UIImage *img3 = [UIImage imageNamed:@"both3.png"];
    img =  [img3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [userVC.tabBarItem setFinishedSelectedImage:img3
                    withFinishedUnselectedImage:[UIImage imageNamed:@"bot3.png"]];
    userVC.tabBarItem.title = @"用户中心";
    
   

    
    ArtistTableViewController *artistController = [[ArtistTableViewController alloc]init];
    UINavigationController *artistVC = [[UINavigationController alloc]initWithRootViewController:artistController];
    artistVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"艺人社区" image:[UIImage imageNamed:@"bot2.png"] selectedImage:[UIImage imageNamed:@"both2.png"]];

    UIImage *img2 = [UIImage imageNamed:@"both2.png"];
    img =  [img2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [artistVC.tabBarItem setFinishedSelectedImage:img2
                    withFinishedUnselectedImage:[UIImage imageNamed:@"bot2.png"]];
    artistVC.tabBarItem.title = @"艺人社区";
    
    JoinViewController *joinVC = [[JoinViewController alloc]init];
    UINavigationController *jVC = [[UINavigationController alloc]initWithRootViewController:joinVC];
    jVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"用户中心" image:[UIImage imageNamed:@"1111.png"] tag:104];

    //tabbar颜色设置
    //self.tabBar.backgroundColor = [UIColor colorWithRed:123/255.0f green:137/255.0f blue:138/255.0f alpha:1.0];
    
//    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
//    
//    NSString *avi = [NSString stringWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
//    
//    if (avi == nil)
//    {
//        self.viewControllers = @[mainVC,artistVC,jVC];
//    }
//    else
//    {
//         self.viewControllers = @[mainVC,artistVC,userVC];
//    }
//
    
//    UITabBar *tabBar = mainVC.tabBarController.tabBar;
//    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
//        // 对item设置相应地图片
//    item0.selectedImage = [[UIImage imageNamed:@"yingpianbai.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
//    item0.image = [[UIImage imageNamed:@"yingpianlv.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    item1.selectedImage = [[UIImage imageNamed:@"yirenlv.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
//    item1.image = [[UIImage imageNamed:@"yirenbai.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    item2.selectedImage = [[UIImage imageNamed:@"yonghulv.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
//    item2.image = [[UIImage imageNamed:@"yonghubai.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    
    
    
    
    self.viewControllers = @[mainVC,artistVC,userVC];
    
    
    
    
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
