//
//  JwLookForController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwLookForController.h"
#import "UIColor+Hex.h"

@interface JwLookForController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scolw;
@property(nonatomic,strong)UIImageView * image;
@property(nonatomic,strong)UITextField * searText;
@property(nonatomic,strong)UIImageView * searImg;
@property(nonatomic,strong)UIButton * shaiBut;
@property(nonatomic,strong)UIButton * baseBut;
@property(nonatomic,strong)UIView * myview;
//
@property(nonatomic,strong)UILabel * myLaber1;
@property(nonatomic,strong)UITextField * myText1;
@property(nonatomic,strong)UITextField * myText2;
@property(nonatomic,strong)UITextField * myText3;
@property(nonatomic,strong)UITextField * myText4;
@property(nonatomic,strong)UIButton * serchBut;





@end

@implementation JwLookForController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    [self setUI];
    
}

-(void)setUI
{
    self.scolw.delegate = self;
     self.scolw = [[UIScrollView alloc]init];
    self.scolw.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.scolw.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2.0, CGRectGetHeight([UIScreen mainScreen].bounds));
    [self.view addSubview:_scolw];
   // self.scolw.backgroundColor = [UIColor redColor];
    self.image= [[UIImageView alloc]init];
    self.image.frame = CGRectMake(0,0 , CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.24);
    self.image.image = [UIImage imageNamed:@"xianzhong.png"];
    [self.scolw addSubview:_image];
    //
    self.searText = [[UITextField alloc]init];
    self.searText.frame = CGRectMake(20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.07, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 46);
    self.searText.placeholder = @"请输入关键词";
    self.searText.borderStyle = UITextBorderStyleLine;
    self.searText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searImg = [[UIImageView alloc]init];
    self.searImg.frame = CGRectMake(0, 0, 30, 30);
    self.searImg.image = [UIImage imageNamed:@"sousu"];
    self.searText.leftView = self.searImg;
    self.searText.leftViewMode = UITextFieldViewModeAlways;
    self.searText.backgroundColor = [UIColor whiteColor];
    [self.scolw addSubview:_searText];
    //
    self.shaiBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shaiBut.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.2, CGRectGetHeight([UIScreen mainScreen].bounds)*0.24 - 60, 80, 60);
    [self.shaiBut setTitle:@"筛选条件" forState:(UIControlStateNormal)];
    [self.shaiBut setTintColor:[UIColor whiteColor]];
    [self.scolw addSubview:_shaiBut];
    
    //
    self.baseBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.baseBut.frame = CGRectMake(CGRectGetMaxX(self.shaiBut.frame)+30, CGRectGetMinY(self.shaiBut.frame), CGRectGetWidth(self.shaiBut.frame), CGRectGetHeight(self.shaiBut.frame));
    [self.baseBut setTitle:@"基本信息" forState:(UIControlStateNormal)];
    [self.baseBut setTintColor:[UIColor whiteColor]];
    [self.scolw addSubview:_baseBut];
    
    self.myview = [[UIView alloc]init];
    self.myview.frame = CGRectMake(20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.26, CGRectGetWidth([UIScreen mainScreen].bounds)-40, CGRectGetHeight([UIScreen mainScreen].bounds)*0.40);
    [self.view addSubview:_myview];
    self.myview.backgroundColor = [UIColor whiteColor];
    //
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(30, CGRectGetHeight([UIScreen mainScreen].bounds)*0.27, 60, 20);
    lab.text = @"筛选条件";
    lab.font = [UIFont systemFontOfSize:13.0];
    lab.textColor =[UIColor grayColor];
    [self.view addSubview:lab];
    //
    UIImageView * myImage1 = [[UIImageView alloc]init];
    myImage1.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lab.frame)+20, 20, 20);
    myImage1.image = [UIImage imageNamed:@"shoujin"];
    [self.view addSubview:myImage1];
    //
    UILabel * Laber1 = [[UILabel alloc]init];
    Laber1.frame = CGRectMake(CGRectGetMaxX(myImage1.frame)+10, CGRectGetMinY(myImage1.frame)-5, 60, 30);
    Laber1.textColor = [UIColor grayColor];
    Laber1.font = [UIFont systemFontOfSize:13.0];
    Laber1.text = @"首年保费";
    [self.view addSubview:Laber1];
    //
    self.myText1 = [[UITextField alloc]init];
    self.myText1.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber1.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber1.frame));
    
    self.myText1.borderStyle = UITextBorderStyleNone;
    self.myText1.textColor = [UIColor grayColor];
    self.myText1.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img1 = [[UIImageView alloc]init];
    img1.frame = CGRectMake(0, 0, 20, 20);
    self.myText1.rightView = img1;
    self.myText1.rightViewMode = UITextFieldViewModeAlways;
    self.myText1.keyboardType = UIKeyboardTypeNumberPad;
    img1.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.view addSubview:_myText1];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(20, CGRectGetMaxY(_myText1.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView1];
    
    //
  
    UIImageView * myImage2 = [[UIImageView alloc]init];
    myImage2.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView1.frame)+10, 20, 20);
    myImage2.image = [UIImage imageNamed:@"baojin"];
    [self.view addSubview:myImage2];
    //
    UILabel * Laber2 = [[UILabel alloc]init];
    Laber2.frame = CGRectMake(CGRectGetMaxX(myImage2.frame)+10, CGRectGetMinY(myImage2.frame)-5, 60, 30);
    Laber2.textColor = [UIColor grayColor];
    Laber2.font = [UIFont systemFontOfSize:13.0];
    Laber2.text = @"保险金额";
    [self.view addSubview:Laber2];

    self.myText2 = [[UITextField alloc]init];
    self.myText2.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber2.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber2.frame));
    
    self.myText2.borderStyle = UITextBorderStyleNone;
    self.myText2.textColor = [UIColor grayColor];
    self.myText2.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img2 = [[UIImageView alloc]init];
    img2.frame = CGRectMake(0, 0, 20, 20);
    self.myText2.rightView = img2;
    self.myText2.rightViewMode = UITextFieldViewModeAlways;
    self.myText2.keyboardType = UIKeyboardTypeNumberPad;
    img2.image = [UIImage imageNamed:@"p_arrowleft"];
    
    [self.view addSubview:_myText2];
   
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.frame = CGRectMake(20, CGRectGetMaxY(_myText2.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView2];

    //
    UIImageView * myImage3 = [[UIImageView alloc]init];
    myImage3.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView2.frame)+10, 20, 20);
    myImage3.image = [UIImage imageNamed:@"qijian"];
    [self.view addSubview:myImage3];
//    //
    UILabel * Laber3 = [[UILabel alloc]init];
    Laber3.frame = CGRectMake(CGRectGetMaxX(myImage3.frame)+10, CGRectGetMinY(myImage3.frame)-5, 60, 30);
    Laber3.textColor = [UIColor grayColor];
    Laber3.font = [UIFont systemFontOfSize:13.0];
    Laber3.text = @"保险期间";
    [self.view addSubview:Laber3];
    
    self.myText3 = [[UITextField alloc]init];
    self.myText3.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber3.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber3.frame));
//
    self.myText3.borderStyle = UITextBorderStyleNone;
    self.myText3.textColor = [UIColor grayColor];
    self.myText3.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img3 = [[UIImageView alloc]init];
    img3.frame = CGRectMake(0, 0, 20, 20);
    self.myText3.rightView = img3;
    self.myText3.rightViewMode = UITextFieldViewModeAlways;
    self.myText3.keyboardType = UIKeyboardTypeNumberPad;
    img3.image = [UIImage imageNamed:@"p_arrowleft"];
//
    [self.view addSubview:_myText3];
    
    UIView * lineView3 = [[UIView alloc]init];
    lineView3.frame = CGRectMake(20, CGRectGetMaxY(_myText3.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView3];
//
//
    UIImageView * myImage4 = [[UIImageView alloc]init];
    myImage4.frame = CGRectMake(CGRectGetMinX(lab.frame), CGRectGetMaxY(lineView3.frame)+10, 20, 20);
    myImage4.image = [UIImage imageNamed:@"jiaofei"];
    [self.view addSubview:myImage4];
    //    //
    UILabel * Laber4 = [[UILabel alloc]init];
    Laber4.frame = CGRectMake(CGRectGetMaxX(myImage4.frame)+10, CGRectGetMinY(myImage4.frame)-5, 60, 30);
    Laber4.textColor = [UIColor grayColor];
    Laber4.font = [UIFont systemFontOfSize:13.0];
    Laber4.text = @"缴费期间";
    [self.view addSubview:Laber4];
    
    self.myText4 = [[UITextField alloc]init];
    self.myText4.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.45, CGRectGetMinY(Laber4.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.5, CGRectGetHeight(Laber4.frame));
    //
    self.myText4.borderStyle = UITextBorderStyleNone;
    self.myText4.textColor = [UIColor grayColor];
    self.myText4.font = [UIFont systemFontOfSize:13.0];
    UIImageView * img4 = [[UIImageView alloc]init];
    img4.frame = CGRectMake(0, 0, 20, 20);
    self.myText4.rightView = img4;
    self.myText4.rightViewMode = UITextFieldViewModeAlways;
    self.myText4.keyboardType = UIKeyboardTypeNumberPad;
    img4.image = [UIImage imageNamed:@"p_arrowleft"];
    //
    [self.view addSubview:_myText4];
    
    UIView * lineView4 = [[UIView alloc]init];
    lineView4.frame = CGRectMake(20, CGRectGetMaxY(_myText4.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-40, 1);
    lineView4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView4];
    
    //
    self.serchBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.serchBut.frame = CGRectMake(30, CGRectGetMaxY(lineView4.frame)+20, CGRectGetWidth([UIScreen mainScreen].bounds)-60, 50);
    self.serchBut.backgroundColor = [UIColor redColor];
    self.serchBut.layer.cornerRadius = 25;
    [self.serchBut setTitle:@"高级搜索" forState:(UIControlStateNormal)];
    [self.serchBut setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_serchBut];
    
    
    
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
