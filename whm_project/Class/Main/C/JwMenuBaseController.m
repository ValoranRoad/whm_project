//
//  JwMenuBaseController.m
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "JwMenuBaseController.h"
#import "UIBarButtonItem+Extension.h"

@interface JwMenuBaseController ()

@end

@implementation JwMenuBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(menuBaseAction:) image:@"nav_menu" highImage:@"nav_menu"];
    
}

- (void)menuBaseAction:(UIBarButtonItem *)barButton{
    //菜单按钮点击事件的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuBaseAction" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewWillAppearAction" object:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewDidDisappearAction" object:nil];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark -- Getter
-(JwDataService *)managerService
{
    _managerService = [[JwDataService alloc] init];
    return _managerService;
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
