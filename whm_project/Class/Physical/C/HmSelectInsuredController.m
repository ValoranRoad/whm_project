//
//  HmSelectInsuredController.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmSelectInsuredController.h"
#import "MacroUtility.h"
#import "HmSelectInsuredCell.h"
#import "HmSelectInsuredCollectionCell.h"
#import "UIColor+Hex.h"
#import "CMIndexBar.h"
#import "HmAddInsuredController.h"
#import "MacroUtility.h"
#import "JGProgressHelper.h"


#define kCellIdentifierOfInsured @"kCellIdentifierOfInsuredCell"
#define kCellIdentifierOfCollection @"kCellIdentifierOfCollectionCell"
#define HmInsuredX 10
#define HmInsuredY 20
#define HmInsuredW (kScreenWitdh - 3) / 3
#define HmInsuredH HmInsuredW

@interface HmSelectInsuredController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CMIndexBarDelegate>
{
    CMIndexBar *indexBar;
}

@property (nonatomic, strong) void(^selectUser)(WHget_user_realtion *user);

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UICollectionView *collectionV;

// 组
@property (nonatomic, strong) NSArray *arrayOfGroup;

//数据
@property(nonatomic,strong)NSMutableArray * dataArry;

@end

@implementation HmSelectInsuredController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 请求数据
    [self requestData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayOfGroup = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    // 布局
    [self setupUI];
    
    // 索引
    [self createIndexList];

    
}

// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_user_realtionWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        // 成功
        NSLog(@"hahah");
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        // 失败
        [JGProgressHelper showError:@"失败"];
    }];
}

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"选择被保人";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
   /*
    _tableV.tableHeaderView = ({
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 20 + HmInsuredH * 2 + 1.5)];
        headView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(HmInsuredX, 0, kScreenWitdh - HmInsuredX * 2, 20)];
        lblTitle.text = @"最近添加";
        lblTitle.textColor = [UIColor colorWithHex:0x666666];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.font = [UIFont systemFontOfSize:13];
        [headView addSubview:lblTitle];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置布局方向 垂直
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 1.5;
        layout.minimumLineSpacing = 1.5;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(HmInsuredW, HmInsuredH);
        // 通过一个布局策略layout来创建一个collectionView
        self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, kScreenWitdh, HmInsuredH * 2 + 1.5) collectionViewLayout:layout];
        // 设置代理
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
        [headView addSubview:_collectionV];
        headView;
    });
    */
    [self.view addSubview:_tableV];
    
    // 添加 (右上角)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewAction:)];
    
    
}

#pragma mark -- Private
-(void)addNewAction:(UIBarButtonItem *)sender
{
    HmAddInsuredController *VC = [[HmAddInsuredController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)createIndexList
{
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(kScreenWitdh - 12, 0, 12, self.tableV.frame.size.height)];
    indexBar.textColor = [UIColor colorWithHex:0x666666];
    indexBar.textFont = [UIFont systemFontOfSize:11];
    indexBar.delegate = self;
    [indexBar setIndexes:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    [self.view addSubview:indexBar];
}

#pragma mark -- CMIndexBar Delegate
-(void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    if (index > self.arrayOfGroup.count - 1) {
        return;
    }
    [_tableV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -- TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmSelectInsuredCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:kCellIdentifierOfInsured];
        nibsRegistered = YES;
    }
    HmSelectInsuredCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierOfInsured];

    cell.model = self.dataArry[indexPath.row];
    //cell.imgHead sd_setImageWithURL:[NSURL URLWithString:]

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//选中数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"你点击了第%ld组的第%ld行", indexPath.section,indexPath.row);
    if (self.selectUser) {
        self.selectUser(self.dataArry[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 30)];
    headView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, kScreenWitdh - 6 * 2, 20)];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor colorWithHex:0x666666];
    lbl.text = @"";
    [headView addSubview:lbl];
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -- CollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmSelectInsuredCollectionCell class]) bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:kCellIdentifierOfCollection];
        nibsRegistered = YES;
    }
    HmSelectInsuredCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifierOfCollection forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}

#pragma mark -- block
-(void)returnInsured:(void (^)(WHget_user_realtion *))block
{
    self.selectUser = block;
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
