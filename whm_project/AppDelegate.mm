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
//
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import <CoreLocation/CoreLocation.h>


BMKMapManager *_mapManager;

@interface AppDelegate () <BMKLocationServiceDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate
static void uncaughtExceptionHandler(NSException *exception) {
    
    
}
- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

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
    if ([CLLocationManager locationServicesEnabled])
    {
        //  如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            NSLog(@"请求用户授权");
            [self.locationManager requestWhenInUseAuthorization];
        }
    }else
    {
        NSLog(@"还没有打开手机定位功能");
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
    
   
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [WZGuideViewController show];
    }

    [self shareUmeng];
    
       return YES;
}


//分享
-(void)shareUmeng
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"576bac6d67e58e0b6b000a36"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxff52ab613da7ab0c" appSecret:@"fcf5880a37638b5cf21f344d92220042" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105469472" appKey:@"t7lum7Vsb1K9bOvq" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
//                                              secret:@"04b48b094faeb16683c32669824ebdad"
//                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
 
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
