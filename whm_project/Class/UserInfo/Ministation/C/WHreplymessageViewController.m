//
//  WHreplymessageViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHreplymessageViewController.h"

#import "WHreplymessage.h"
#import "JGProgressHelper.h"
#import "WHgetmessageDetall.h"


@interface WHreplymessageViewController ()

@property(nonatomic,strong)WHreplymessage * rep;

@property(nonatomic,strong)NSMutableArray * dataArry;
@end

@implementation WHreplymessageViewController

-(void)loadView
{
    self.rep = [[WHreplymessage alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =_rep;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //请求数据
    [self requestData];
}
// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getmessagedetailWithId:self.IDS uid:@"" success:^(NSArray *getdetals) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:getdetals];
        NSLog(@"%@",self.dataArry);
        for (WHgetmessageDetall * model in self.dataArry) {
            NSLog(@"%@",model);
        }
       
        
       // NSLog(@"%@",s1);
      
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        
    }];
//    [self.dataService getmessagedetailWithId:self.IDS uid:@"" success:^(NSArray *getdetals) {
//        
//        NSLog(@"%@",getdetals);
//
//    } failure:^(NSError *error) {
//        
//        
//    }];
    
    
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
