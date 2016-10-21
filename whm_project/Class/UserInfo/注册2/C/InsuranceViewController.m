//
//  InsuranceViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 2016/10/19.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "InsuranceViewController.h"
#import "insuranceCollectionViewCell.h"
#import "completeTableViewCell.h"
#import "CMIndexBar.h"




#define kScreenW [[UIScreen mainScreen] bounds].size.width
@interface InsuranceViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,CMIndexBarDelegate>
{
    CMIndexBar *indexBar;
}

@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UILabel *hotLab;
@property (nonatomic, strong) UITableView *tableView;







@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;



// 组头
@property (nonatomic, strong) NSArray *groupsTitle;

// 每组内容
@property (nonatomic, strong) NSArray *contentsRow;
@end

@implementation InsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setUI];
    
    
    _groupsTitle = [NSArray array];
    _contentsRow = [NSArray array];

    [self shuju];
    [self createList];
}

#pragma mark - 创建索引
- (void)createList
{
    
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-25, 30, 25.0, self.view.frame.size.height-64 - 30)];
//    indexBar.backgroundColor = [UIColor redColor];
    indexBar.textColor = [UIColor colorWithRed:61/255.0 green:163/255.0  blue:255/255.0  alpha:1.0];
    indexBar.textFont = [UIFont systemFontOfSize:12];
    [indexBar setIndexes:_groupsTitle];
    //   indexBar.backgroundColor = [UIColor cyanColor];
    //    [indexBar setTextColor:[UIColor redColor]];
    indexBar.delegate = self;
    [self.view addSubview:indexBar];
    
}
#pragma mark - 索引代理方法
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title{
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
}


#pragma mark - 加载数据
-(void)shuju
{
    self.groupsTitle = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    self.contentsRow = @[@"日本",@"韩国",@"美国",@"南非",@"英国",@"加拿大"];
  
    
}
-(void)setUI
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenW - 2)/3*2+1+30)];
    self.headView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_headView];
    
    
    self.hotLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    self.hotLab.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1.0];
    self.hotLab.font = [UIFont systemFontOfSize:12];
    self.hotLab.text = @"    热门公司";
    [self.headView addSubview:_hotLab];
    
    
    [self.headView addSubview:self.collectionView];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kScreenW, CGRectGetHeight(self.view.frame) - CGRectGetHeight(_headView.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"completeCell"];
 
         
    
}




#pragma mark - 返回sections
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _groupsTitle.count;
    
}

#pragma mark - 返回rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
    
}
#pragma mark - tableview事件
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    completeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"completeCell" forIndexPath:indexPath];
    
     cell.headImage.image = [UIImage imageNamed:@"leixing"];
    cell.titleLab.text = @"中国神周五好";
   
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}





#pragma tableview mark - 点击cell响应事件

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CityTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.cityLab.textColor = kDarkGrayColor;
//    cell.englishCityLab.textColor = kDarkGrayColor;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
}
#pragma mark - 返回tableview 表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}

#pragma mark - 返回tableview表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //OrderCityModer *order = self.countryArr[section];
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    myView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0  blue:241/255.0  alpha:1.0];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 30)];
    myLab.backgroundColor = [UIColor clearColor];
    myLab.text = _groupsTitle[section];
    myLab.font = [UIFont systemFontOfSize:16];
    myLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0  blue:0/255.0  alpha:1.0];
    
    [myView addSubview:myLab];
    
    
    
    return myView;
}
#pragma mark - 返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        //  flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_hotLab.frame) , kScreenW, (kScreenW - 2)/3*2+1) collectionViewLayout:flowLayout];
        //修改线条颜色
        _collectionView.backgroundColor = [UIColor grayColor];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((kScreenW - 2)/3, (kScreenW - 2)/3);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumLineSpacing = 1;
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumInteritemSpacing = 1;
        
      
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 , 0, 0);//上左下右
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[insuranceCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        //[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
//        _collectionView.backgroundColor = [UIColor redColor];
        //自适应大小
        //_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
    }
    return _collectionView;
}
#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;

}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    insuranceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell sizeToFit];
    
    cell.completeImage.image = [UIImage imageNamed:@"jigou"];
    cell.completeLab.text = @"泰康人寿";
    
    
//    //cell.layer.borderColor = [UIColor colorWithRed:118/255.0 green:118/255.0  blue:118/255.0  alpha:1.0].CGColor;
//    
//    //cell.layer.borderWidth=0.3;
//    cityOtherModer *model = _myCarr[indexPath.row];
//    cell.cheseLab.text = model.name;
//    
//    //如果collect是选中状态则设置为不选中状态
//    for (id obj in cell.subviews)
//    {
//        if ([obj isKindOfClass:[UIImageView class]])
//        {
//            
//            [obj removeFromSuperview];
//            [_temporaryArr removeAllObjects];
//        }
//    }
    
    return cell;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
    
    // cityOtherModer *model = _myCarr[indexPath.row];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *seleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 24)];
    seleView.image = [UIImage imageNamed:@"xzfwcx-2"];
    
//    for (id obj in cell.subviews) {
//        if ([obj isKindOfClass:[UIImageView class]])
//        {
//            
//            [obj removeFromSuperview];
//            
//            
//            [_temporaryArr removeObject:_myCarr[indexPath.row]];
//            return;
//            
//        }
//    }
//    
//    [cell addSubview:seleView];
//    [_temporaryArr addObject:_myCarr[indexPath.row]];
    
    
    
    
    
}



+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
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
