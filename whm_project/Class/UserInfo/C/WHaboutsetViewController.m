//
//  WHaboutsetViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaboutsetViewController.h"

@interface WHaboutsetViewController ()
@property(nonatomic,strong)UIView * myview;
@property(nonatomic,strong)UILabel * mylable;
@property(nonatomic,strong)UIImageView * myimage;
@end

@implementation WHaboutsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"开发版本";
    
    [self set_p];
}
-(void)set_p
{
    self.myview = [[UIImageView alloc]init];
    self.myview.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    [self.view  addSubview:_myview];
     [self.view addSubview: self.myview];
    
    self.myimage = [[UIImageView alloc]init];
    self.myimage.image = [UIImage imageNamed:@"logo"];
    self.myimage.frame = CGRectMake(125* 0.85, 50, 150, 150);
    [self.myview addSubview:_myimage];
    self.myimage.layer.cornerRadius = CGRectGetWidth(self.myimage.frame)/2;
    self.myimage.layer.masksToBounds = YES;
    
    
    
    
    
    
    self.mylable = [[UILabel alloc]init];
    self.mylable.frame = CGRectMake(CGRectGetMinX(self.myimage.frame)+40, CGRectGetMaxY(self.myimage.frame)-30, CGRectGetWidth(self.myimage.frame), CGRectGetHeight(self.myimage.frame));
    [self.myview addSubview:_mylable];
    self.mylable.font = [UIFont systemFontOfSize:20.0];
    self.mylable.text = @"v2.0.0";
    
    
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
