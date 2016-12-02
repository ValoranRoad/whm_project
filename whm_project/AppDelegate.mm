//
//  AppDelegate.m
//  whm_project
//
//  Created by chenJw on 16/10/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "AppDelegate.h"
#import "JwTabBarController.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WZGuideViewController.h"

BMKMapManager *_mapManager;

@interface AppDelegate () <BMKLocationServiceDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initKeyboardManager];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[JwTabBarController alloc] init];
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    //CSZv39bjvYYwu3D2mO5xKwxc4fwDA01I
    BOOL ret = [_mapManager start:@"CSZv39bjvYYwu3D2mO5xKwxc4fwDA01I" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    } else {
        NSLog(@"鉴权成功！");
    }
    self.locationService = [[BMKLocationService alloc] init];
    //    self.locationService.delegate = self;
    [self.locationService startUserLocationService];

    //引导页
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
    }
    
   
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [WZGuideViewController show];
    }

       return YES;
}
/**
 *  键盘高度计算以及BarTool
 */
- (void)initKeyboardManager {
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
