//
//  WHinsuranceNameViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHinsuranceNameViewController.h"

@interface WHinsuranceNameViewController ()
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UITextField * myText;

@end

@implementation WHinsuranceNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myText = [[UITextField alloc]init];
    self.myText.frame = CGRectMake(0, 60, CGRectGetWidth([UIScreen mainScreen].bounds)  , 50);
    self.myText.placeholder = @"请输入保险公司";
    self.navigationItem.title = @"保险公司";
    self.myText.borderStyle = UITextBorderStyleNone;
    
    self.myText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.myText setBorderStyle:UITextBorderStyleRoundedRect];
   // self.myText.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_myText];
    //键盘隐藏事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
    
}
-(void)left:(UIBarButtonItem *)sender
{
    if (self.myText.text != nil) {
        self.mblock1 (self.myText.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//隐藏键盘事件
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
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
