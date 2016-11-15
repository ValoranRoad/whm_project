//
//  LYTestThreeViewController.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestThreeViewController.h"
#import "CustomProgress.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHgetreport.h"
#import "WHcov.h"

@interface LYTestThreeViewController ()<UIWebViewDelegate>
{
    CustomProgress * custompro;
    NSTimer * timer;
    int present;
    CustomProgress * custompro1;
    NSTimer * timer1;
    int present1;
    
    CustomProgress * custompro2;
    NSTimer * timer2;
    int present2;
    CustomProgress * custompro3;
    NSTimer * timer3;
    int present3;
    CustomProgress * custompro4;
    NSTimer * timer4;
    int present4;
   
    CustomProgress * custompro5;
    NSTimer * timer5;
    int present5;
}
/**
 *  🐶ss    👇
 */
@property(nonatomic,strong)CustomProgress * custompro;
@property(nonatomic,strong)CustomProgress * custompro1;
@property(nonatomic,strong)UIWebView * scw;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)NSString * s1 ;
@end

@implementation LYTestThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setup];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self requartDate];
}
//数据请求
-(void)requartDate
{
     NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    self.s1 = [ud valueForKey:@"one"];
    
    NSLog(@"==%@",self.s1);
    [self loadWithURLString:self.s1];

}
-(void)setup
{
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    
    _custompro = [[CustomProgress alloc] initWithFrame:CGRectMake(10, 10, kScreenWitdh *0.4, 50)];
    
    _custompro.maxValue = 20;
    //设置背景色
    _custompro.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro.leftimg.backgroundColor =[UIColor colorWithRed:202/255.0 green:237/255.0 blue:234/255.0 alpha:1];
    
    _custompro.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro];
    [self timer];
    //试图2
    _custompro1 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, 10, kScreenWitdh *0.4, 50)];
    
    _custompro1.maxValue = 10;
    //设置背景色
    _custompro1.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro1.leftimg.backgroundColor =[UIColor redColor];
    //[UIColor colorWithRed:249/255.0 green:242/255.0 blue:206/255.0 alpha:1];;
   _custompro1.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro1];
    [self timer1];
    //试图3
    custompro2 = [[CustomProgress alloc] initWithFrame:CGRectMake(10, 80, kScreenWitdh *0.4, 50)];
     custompro2.maxValue = 40;
    //设置背景色
    custompro2.bgimg.backgroundColor =[UIColor whiteColor];
    custompro2.leftimg.backgroundColor = [UIColor colorWithRed:202/255.0 green:237/255.0 blue:234/255.0 alpha:1];;
    custompro2.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:custompro2];
//    [self timer2];
    //试图4
    custompro3 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, 80, kScreenWitdh *0.4, 50)];
    
    custompro3.maxValue = 75;
    //设置背景色
    custompro3.bgimg.backgroundColor =[UIColor whiteColor];
    custompro3.leftimg.backgroundColor =[UIColor colorWithRed:249/255.0 green:242/255.0 blue:206/255.0 alpha:1];;
    custompro3.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:custompro3];
//    [self timer3];
    //试图5
     custompro4 = [[CustomProgress alloc] initWithFrame:CGRectMake(10, 150, kScreenWitdh *0.4, 50)];
    custompro4.maxValue = 25;
    //设置背景色
    custompro4.bgimg.backgroundColor =[UIColor whiteColor];
    custompro4.leftimg.backgroundColor =[UIColor colorWithRed:249/255.0 green:242/255.0 blue:206/255.0 alpha:1];;
    custompro4.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:custompro4];
//    [self timer4];
    //试图6
    custompro5 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, 150, kScreenWitdh *0.4, 50)];
    custompro5.maxValue = 7;
    custompro5.bgimg.backgroundColor =[UIColor whiteColor];
    custompro5.leftimg.backgroundColor =[UIColor colorWithRed:249/255.0 green:242/255.0 blue:206/255.0 alpha:1];;
    custompro5.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:custompro5];
//    [self timer5];

    //界面设计
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(10, CGRectGetMaxY(custompro5.frame)+5, kScreenWitdh * 0.5, 30);
    self.titLaber.font = [UIFont systemFontOfSize:13.0];
    self.titLaber.textColor = [UIColor grayColor];
    [self.view addSubview:_titLaber];
    
    self.titLaber.text = @"保障是否全面";
    
     self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titLaber.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.8)];
    [self.view  addSubview:_scw];



}
//

-(void)loadWithURLString:(NSString *)urlStr
{
    NSString  * content = [self.s1 stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",kScreenWitdh-16,kScreenWitdh-16,kScreenWitdh-16];
    //
    
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    //self.scw = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"00%@",contentTwo);
    
    [_scw loadHTMLString:html baseURL:nil];
}


-(void)timer
{
    
    if (present<=20) {
        
        [_custompro setPresent:6 title:@"保障是否全面" labelText:@"12分"];
        
    }
    
}
-(void)timer1
{
    
    if (present1<=10) {
        
        [_custompro1 setPresent:8 title:@"保费是否合理" labelText:@"8分"];

    }
    
}

-(void)timer2
{
    
    if (present2<=40) {
        
        [custompro2 setPresent2 :30];
        
    }
    
}
-(void)timer3
{
    
    if (present3<=75) {
        
        [custompro3 setPresent3 :70];
        
    }
    
}
-(void)timer4
{
    
    if (present4<= 25) {
        
        [custompro4 setPresent4 :20];
        
    }
    
}
-(void)timer5
{
    
    if (present5<= 7) {
        
        [custompro5 setPresent5:3 ];
        
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
