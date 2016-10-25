//
//  ChooseCompleteViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "ChooseCompleteViewController.h"
#import "ChooseTableViewCell.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
@interface ChooseCompleteViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)UILabel *titLab;


@property (nonatomic,strong)UIView *provinceView;
@property (nonatomic,strong)UIView *cityView;
@property (nonatomic,strong)UIView *areaView;

@property (nonatomic,strong)UIButton *provinceBtn;
@property (nonatomic,strong)UIButton *cityBtn;
@property (nonatomic,strong)UIButton *areaBtn;

@property (nonatomic,strong)UIImageView *provinceImage;
@property (nonatomic,strong)UIImageView *cityImage;
@property (nonatomic,strong)UIImageView *areaImage;

@property (nonatomic,strong) NSArray  *proTimeList;
@property (nonatomic,strong)NSArray *cityArr;
@property (nonatomic,strong)NSArray *areaArr;

@property (nonatomic,strong)UIPickerView *pickerView ;


@property (nonatomic,strong)UIPickerView *cityPickerView;

@property (nonatomic,strong)UIPickerView *areaPickerView;
@end

@implementation ChooseCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    

    
    
    _proTimeList = [[NSArray alloc]initWithObjects:@"河南省",@"河北省",@"浙江省",@"北京",@"天津",@"重庆",@"四川省",@"新疆省",@"黑龙江省",@"安徽省",nil];

    _cityArr = [[NSArray alloc]initWithObjects:@"郑州",@"厦门",@"哈尔滨",@"南阳",@"信阳",nil];
    _areaArr = [[NSArray alloc]initWithObjects:@"金水区",@"中原区",nil];
    [self creatTable];
    [self creatUI];
}


-(void)creatUI
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 100 -64, kScreenW, 100)];
    self.backView.backgroundColor  = [UIColor colorWithRed:67/255.0 green:98/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_backView];
    
    self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2 - 50, 25, 100, 1)];
    self.lineLab.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:_lineLab];
    
    self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2-20, 15, 40, 20)];
    self.titLab.backgroundColor = [UIColor colorWithRed:67/255.0 green:98/255.0 blue:224/255.0 alpha:1.0];
    self.titLab.text = @"筛选";
    self.titLab.textAlignment = NSTextAlignmentCenter;
    self.titLab.textColor = [UIColor whiteColor];
    self.titLab.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:_titLab];
    
    
    self.provinceView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, (kScreenW - 30)/3, 30)];
    self.provinceView.backgroundColor = [UIColor whiteColor];
    self.provinceView.layer.cornerRadius = 15;
    [self.backView addSubview:_provinceView];
    
    self.cityView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) + 5, 50, (kScreenW - 30)/3, 30)];
    self.cityView.backgroundColor = [UIColor whiteColor];
    self.cityView.layer.cornerRadius = 15;
    [self.backView addSubview:_cityView];
    
    
    self.areaView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityView.frame) + 5, 50, (kScreenW - 30)/3, 30)];
    self.areaView.backgroundColor = [UIColor whiteColor];
    self.areaView.layer.cornerRadius = 15;
    [self.backView addSubview:_areaView];
    
    
    self.provinceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.provinceBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.provinceBtn setTitle:@"河南省" forState:UIControlStateNormal];
    self.provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.provinceBtn addTarget:self action:@selector(provinceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.provinceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.provinceView addSubview:_provinceBtn];
    
    
    self.cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cityBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.cityBtn setTitle:@"中原区" forState:UIControlStateNormal];
    self.cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cityBtn addTarget:self action:@selector(cityBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.cityView addSubview:_cityBtn];
    
    
    self.areaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.areaBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.areaBtn setTitle:@"中原" forState:UIControlStateNormal];
    [self.areaBtn addTarget:self action:@selector(areaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.areaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.areaBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.areaView addSubview:_areaBtn];
    
    
    self.provinceImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_provinceBtn.frame) + 3, 8, 18)];
    self.provinceImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    //self.provinceImage.backgroundColor = [UIColor redColor];
    [self.provinceView addSubview:_provinceImage];
    
    
    self.cityImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_cityBtn.frame) + 3, 8, 18)];
    self.cityImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    
    [self.cityView addSubview:_cityImage];

    self.areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_areaBtn.frame) + 3, 8, 18)];
    self.areaImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    //self.provinceImage.backgroundColor = [UIColor redColor];
    [self.areaView addSubview:_areaImage];

    // 选择框
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_provinceView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150 - 64 , CGRectGetWidth(_provinceView.frame), 200)];
    _pickerView.backgroundColor = [UIColor grayColor];
    // 显示选中框
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.layer.cornerRadius = 5;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    _pickerView.hidden = YES;
    
    //选择框2
    _cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cityView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150- 64 , CGRectGetWidth(_cityView.frame), 200)];
    _cityPickerView.backgroundColor = [UIColor grayColor];
    // 显示选中框
    _cityPickerView.showsSelectionIndicator=YES;
    _cityPickerView.layer.cornerRadius = 5;
    _cityPickerView.dataSource = self;
    _cityPickerView.delegate = self;
    [self.view addSubview:_cityPickerView];
    _cityPickerView.hidden = YES;
    
    
    //选择框3
    _areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_areaView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150- 64 , CGRectGetWidth(_areaView.frame), 200)];
    _areaPickerView.backgroundColor = [UIColor grayColor];
    // 显示选中框
    _areaPickerView.showsSelectionIndicator=YES;
    _areaPickerView.layer.cornerRadius = 5;
    _areaPickerView.dataSource = self;
    _areaPickerView.delegate = self;
    [self.view addSubview:_areaPickerView];
    _areaPickerView.hidden = YES;
    
}

//选择框
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == _pickerView)
    {
        return [_proTimeList count];
    }
    else if (pickerView == _cityPickerView)
    {
        return [_cityArr count];
    }
    else
    {
        return [_areaArr count];
    }
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return CGRectGetWidth(_provinceView.frame);
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    
    if (pickerView == _pickerView)
    {
        NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
        
        [_provinceBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        _pickerView.hidden = YES;
    }
    else if (pickerView == _cityPickerView)
    {
        NSString  *_proTimeStr = [_cityArr objectAtIndex:row];
        
        [_cityBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        _cityPickerView.hidden = YES;
    }
    else
    {
        NSString  *_proTimeStr = [_areaArr objectAtIndex:row];
        
        [_areaBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        _areaPickerView.hidden = YES;
    }
    
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    
    if (pickerView == _pickerView)
    {
        return [_proTimeList objectAtIndex:row];
    }
    else if (pickerView == _cityPickerView)
    {
        return [_cityArr objectAtIndex:row];
    }
    else
    {
       return [_areaArr objectAtIndex:row];
    }
    
}





-(void)creatTable
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.view.frame) - 100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[ChooseTableViewCell class] forCellReuseIdentifier:@"chooseCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chooseCell"];
    
    cell.addressLab.text = @"郑州市中原区146号";
    
   return cell;
}
-(void)provinceBtnAction
{
    NSLog(@"点击了省");

    _pickerView.hidden = NO;
    
}

-(void)cityBtnAction
{
    NSLog(@"点击了市");
    _cityPickerView.hidden = NO;
}

-(void)areaBtnAction
{
    NSLog(@"点击了区");
    _areaPickerView.hidden = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
