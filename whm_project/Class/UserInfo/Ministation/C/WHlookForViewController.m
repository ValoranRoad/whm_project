//
//  WHLookforViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHLookforViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHprevTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHmicro.h"
#import "WHgetuseinfo.h"
#import <UIImageView+WebCache.h>
#import "WHagentinfo.h"
#import "WHcount.h"
#import "WHgetintroduce.h"
#import "WHmessageListTableViewCell.h"
#import "WHcounselTableViewCell.h"
#import "WHnews.h"
#import "YCXMenu.h"
#import "WHwantMessageViewController.h"
//
#import "WHmin.h"
#import "WHgentinfo.h"
#import "UMSocial.h"
#define BASE_REST_URL @"https://www.kuaibao365.com/index/agent"
#import "WHnewsdetailViewController.h"
#import "JwUserCenter.h"

@interface WHLookforViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
@property(nonatomic,strong)UIButton * messBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIView * lineView1;
@property(nonatomic,strong)UIImageView * baojianImage;
@property(nonatomic,strong)UILabel * baojianLaber;
@property(nonatomic,strong)UIImageView * renzhengImage;
@property(nonatomic,strong)UILabel * renzhengLaber;
@property(nonatomic,strong)UILabel * numchanpin;
@property(nonatomic,strong)UILabel * chanpinLaber;
@property(nonatomic,strong)UILabel * numzixunLaber;
@property(nonatomic,strong)UILabel * zixunLaber;
@property(nonatomic,strong)UILabel * numbaodanLaber;
@property(nonatomic,strong)UILabel * baodanLaber;
@property(nonatomic,strong)UILabel * numkehuLaber;
@property(nonatomic,strong)UILabel * kehuLaber;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)NSMutableArray * daraArry;
//
@property(nonatomic,strong)NSMutableArray * mesArry;
@property(nonatomic,strong)UILabel * area;
@property(nonatomic,strong)UILabel * address;
@property(nonatomic,strong)UILabel * company;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * mobile;
@property(nonatomic,strong)NSString * age ;
@property(nonatomic,strong)NSString * avatar;
@property(nonatomic,strong)UILabel* exhibition_no;
@property(nonatomic,strong)UILabel * certificate_no;
@property(nonatomic,strong)NSString * service_area;
@property(nonatomic,strong)UILabel * oname;
@property(nonatomic,strong)WHprevTableViewCell * cell1;
@property(nonatomic,strong)UILabel * areaLaber;
@property(nonatomic,strong)UITextView *Mytextview;
@property(nonatomic,strong)WHmessageListTableViewCell * cell2;
@property(nonatomic,strong)NSMutableArray * messArry;
@property(nonatomic,strong)WHcounselTableViewCell * cell3;
//基本信息
@property(nonatomic,retain)UIScrollView*scolw;
@property(nonatomic,retain)UIPageControl*page;
@property(nonatomic,strong)NSMutableArray * ImgArry;
//
@property(nonatomic,strong)NSMutableArray * newsArry;
@property(nonatomic,strong)NSString * tel;

@property(nonatomic,strong)NSString * strIntru;
//
@property (nonatomic , strong) NSMutableArray *items;
@property(nonatomic ,strong)NSString * isfollow;
//
//阴影视图
@property (nonatomic, copy) NSString *url;
@property(nonatomic,assign)NSInteger  i ;
@property(nonatomic,strong)NSString * agentID;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)NSString * sexUrl;

@property(nonatomic,strong)NSString * selAgentID;

@end

@implementation WHLookforViewController
@synthesize items = _items;


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //请求数据
    [self requestData1];
    [self setData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"wh_more"] style:UIBarButtonItemStylePlain target:self action:@selector(ringAction:)];
    

}
-(void)ringAction:(UIBarButtonItem *)sender
{
    if (sender == self.navigationItem.rightBarButtonItem) {
        [YCXMenu setTintColor:[UIColor colorWithHex:0x4367FF]];
        [YCXMenu setSelectedColor:[UIColor redColor]];
        if ([YCXMenu isShow]){
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
                //NSLog(@"%@",item);
            }];
        }
    }

    
}

- (NSMutableArray *)items {
    if (!_items) {
        YCXMenuItem *CollectItem = [YCXMenuItem menuItem:@"关注" image:nil target:self action:@selector(collect:)];
        CollectItem.foreColor = [UIColor whiteColor];
        CollectItem.alignment = NSTextAlignmentRight;
        CollectItem.image = [UIImage imageNamed:@"wh_attend"];
        
        YCXMenuItem *ShareItem = [YCXMenuItem menuItem:@"分享" image:nil target:self action:@selector(share:)];
        ShareItem.foreColor = [UIColor whiteColor];
        ShareItem.alignment = NSTextAlignmentRight;
        ShareItem.image = [UIImage imageNamed:@"wh_share"];
        _items = [@[CollectItem, ShareItem
                    ] mutableCopy];

    }
    return _items;

}

- (void)setItems:(NSMutableArray *)items {
    _items = items;
}

//关注
-(void)collect:(UIButton *)sender
{
    
    self.i ++;
    if (self.i % 2 == 0) {
        
    id hud = [JGProgressHelper showProgressInView:self.view];
    if ([self.isfollow isEqualToString:@"1"]) {
        [hud hide:YES];
        [JGProgressHelper showError:@"该代理人已经关注过"];
        NSLog(@"==%@",self.isfollow);
        
    }
    else
    {
        [self.userService getsaveFollowWithUid:@"" agent_uid:@"" success:^{
            [hud hide: YES];
            [JGProgressHelper showSuccess:@"关注成功"];
           
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"关注失败"];
        }];
    }
    }
    else
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService followWithUid:@"" agent_uid:@"" success:^{
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注成功"];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注失败"];
        }];

    }
        
 
        
}

//分享
-(void)share:(UIButton *)sender
{
      NSLog(@"ss");
    
    self.url = [NSString stringWithFormat:@"%@/%@", BASE_REST_URL, self.agentID];
    
    [UMSocialData defaultData].extConfig.title = @"互联网+保险智能化云服务平台";
    
    
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"快保家", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"快保家"]
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrl]]]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToTencent]
                                       delegate:self];
    

}

//数据请求
-(void)setData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getintroduceWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        //self.dataArry = [NSMutableArray arrayWithArray:lists];
        for (WHgetintroduce * model in lists) {
            //  NSLog(@"====%@",model.introduce);
            self.strIntru = model.introduce;
            NSLog(@"aaaa%@",self.strIntru);
        }
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
    
    
}

// 请求数据
-(void)requestData1
{
    if ([self.selectDiffent isEqualToString:@"1"] ) {
        self.selAgentID = self.StrAgentId;
    }
    else
    {
    self.selAgentID = [JwUserCenter sharedCenter].uid;
    
    }
    
    
    id  hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getMicroWithAgent_uid:self.selAgentID  uid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
       // NSLog(@"%@",lists);
        
        self.mesArry = [NSMutableArray array];
        for (WHmin * model in lists) {
            NSLog(@"%@",model.agent_info);
            //留言列表
            
            self.messArry = [NSMutableArray arrayWithArray:model.message];
            //
            self.daraArry = [NSMutableArray arrayWithArray:model.pro];
            NSLog(@"oooo%ld",self.daraArry.count);
            //新闻咨询
            self.newsArry = [NSMutableArray arrayWithArray:model.news];
            NSLog(@"lllll%ld",self.newsArry.count);
            //个人荣誉
            self.ImgArry = [NSMutableArray array];
            for (WHgethonor * Img in model.honor) {
                [self.ImgArry addObject:Img.img1];
                NSLog(@"ppp%ld",self.ImgArry.count);
            }

            //基本信息
            for (WHagentinfo * info in model.agent_info) {
                NSLog(@"%@",info.name);
                self.agentID = info.id;
                self.nameLaber.text = info.name;
                self.yearLaber.text = info.age;
                //电话号码
                self.tel = info.mobile;
                //是否已经关注
                self.isfollow = info.is_follow;
                //
                self.sexUrl = info.sex;
                //
                NSInteger  a = [info.sex integerValue];
                if (a == 1) {
                    self.sexImage.image = [UIImage imageNamed:@"test_male"];
                    
                }else
                {
                    self.sexImage.image = [UIImage imageNamed:@"test_famale"];
                }
                if (info.avatar.length == 0) {
                    self.headImage.image = [UIImage imageNamed:@"Jw_user"];
                }
                else
                {
                    [self.headImage sd_setImageWithURL:[NSURL URLWithString:info.avatar]];
                }
                self.imgUrl = info.avatar;//头像图标
                NSString * s1 = info.cname;
                NSString * s2 =[s1 stringByAppendingString:info.profession];
                if (info.work_time == nil) {
                    info.work_time = @"  ";
                }
                NSString * s3 =[s2 stringByAppendingString:info.work_time];
                NSString * s4 = [s3 stringByAppendingString:info.service_area];
                self.companyLaber.text = s4;
                //
                self.areaLaber.text = info.service_area;
                self.area.text = info.area_info;
                self.address.text = info.job_address;
                self.exhibition_no.text = info.exhibition_no;
                self.certificate_no.text = info.certificate_no;
                self.oname.text = info.oname;
                self.company.text = info.cname;
                
                
            }
            //统计
            
            self.numchanpin.text = model.count.pro_count;
            self.numzixunLaber.text = model.count.news_count;
            self.numbaodanLaber.text = model.count.message_count;
            self.numkehuLaber.text = model.count.customer_count;

        }
        
        [self.tableV reloadData];
    
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper  showError:@""];
        
    }];

}
-(void)setupUI
{
    self.title = @"微站";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight* 0.32, kScreenWitdh, kScreenHeight*0.68 - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    self.tableV.tableHeaderView = self.headView ;
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight *0.3);
    [self.view addSubview:_headView];
    [self.tableV registerClass:[WHprevTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableV registerClass:[WHmessageListTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableV registerClass:[WHcounselTableViewCell class] forCellReuseIdentifier:@"cell3"];
    //
    
    self.headImage = [[UIImageView alloc]init];
    self.headImage.frame = CGRectMake(10, 10, kScreenWitdh * 0.15, kScreenWitdh *0.15);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kScreenWitdh *0.075;
    // self.headImage.image = [UIImage imageNamed:@"test_head"];
    [self.headView addSubview:_headImage];
    // self.headView.backgroundColor = [UIColor redColor];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame)+5, CGRectGetMinY(self.headImage.frame), kScreenWitdh* 0.15, kScreenWitdh * 0.08);
    //self.nameLaber.text = @"周星星";
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self.headView addSubview:_nameLaber];
    
    //
    self.sexImage = [[UIImageView alloc]init];
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+3, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
    //self.sexImage.image = [UIImage imageNamed:@"test_male"];
    [self.headView addSubview:_sexImage];
    
    //
    self.yearLaber = [[UILabel alloc]init];
    self.yearLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImage.frame)+3, CGRectGetMinY(self.sexImage.frame), kScreenWitdh * 0.1, 20);
    self.yearLaber.textColor = [UIColor grayColor];
    self.yearLaber.font = [UIFont systemFontOfSize:13.0];
    // self.yearLaber.text = @"36岁";
    [self.headView addSubview:_yearLaber];
    //
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame),CGRectGetMaxY(self.nameLaber.frame),  kScreenWitdh * 0.4, 20);
    // self.companyLaber.text = @"新华人寿 经理 从业5年 全国";
    self.companyLaber.font = [UIFont systemFontOfSize:11.0];
    self.companyLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_companyLaber];
    //
    self.messBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.messBut.frame = CGRectMake(kScreenWitdh * 0.75, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.messBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    self.messBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_messBut];
    [self.messBut addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(kScreenWitdh * 0.85, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    self.telBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_telBut];
    [self.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    self.lineView1 = [[UIView alloc]init];
    self.lineView1.frame = CGRectMake(0, CGRectGetMaxY(self.headImage.frame)+5, kScreenWitdh, 1);
    self.lineView1.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:_lineView1];
    //
    
    self.baojianImage = [[UIImageView alloc]init];
    self.baojianImage.frame = CGRectMake(CGRectGetMinX(self.headImage.frame), CGRectGetMaxY(self.lineView1.frame)+5, 20, 20);
    self.baojianImage.image = [UIImage imageNamed:@"baojian.png"];
    [self.headView addSubview:_baojianImage];
    //
    self.baojianLaber = [[UILabel alloc]init];
    self.baojianLaber.frame = CGRectMake(CGRectGetMaxX(self.baojianImage.frame)+2, CGRectGetMinY(self.baojianImage.frame), CGRectGetWidth(self.baojianImage.frame)*2.5, CGRectGetHeight(self.baojianImage.frame));
    self.baojianLaber.text = @"保监认证";
    //self.baojianLaber.textColor = [UIColor whiteColor];
    self.baojianLaber.font = [UIFont systemFontOfSize:11.0];
    [self.headView addSubview:_baojianLaber];
    //
    self.renzhengImage = [[UIImageView alloc]init];
    self.renzhengImage.frame = CGRectMake(CGRectGetMaxX(self.companyLaber.frame), CGRectGetMinY(self.baojianLaber.frame), CGRectGetWidth(self.baojianImage.frame), CGRectGetHeight(self.baojianImage.frame));
    self.renzhengImage.image = [UIImage imageNamed:@"renzheng.png"];
    [self.headView addSubview:_renzhengImage];
    //
    self.renzhengLaber = [[UILabel alloc]init];
    self.renzhengLaber.frame = CGRectMake(CGRectGetMaxX(self.renzhengImage.frame)+2, CGRectGetMinY(self.renzhengImage.frame), CGRectGetWidth(self.baojianLaber.frame)*1.2, CGRectGetHeight(self.baojianLaber.frame));
    //self.renzhengLaber.textColor = [UIColor whiteColor];
    self.renzhengLaber.text = @"快保家认证";
    self.renzhengLaber.font = [UIFont systemFontOfSize:11.0];
    [self.headView addSubview:_renzhengLaber];
    self.lineView2 = [[UIView alloc]init];
    self.lineView2.frame = CGRectMake(0, CGRectGetMaxY(self.baojianLaber.frame)+5, kScreenWitdh, 1);
    self.lineView2.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:_lineView2];
    
    //产品类型咨询等设计
    self.numchanpin = [[UILabel alloc]init];
    self.numchanpin.frame = CGRectMake(CGRectGetMinX(self.baojianLaber.frame), CGRectGetMaxY(self.lineView2.frame)+5, kScreenWitdh*0.2, 30);
    //self.numchanpin.text = @"152";
    self.numchanpin.textColor = [UIColor greenColor];
    [self.headView addSubview:_numchanpin];
    self.chanpinLaber = [[UILabel alloc]init];
    self.chanpinLaber.frame = CGRectMake(CGRectGetMinX(self.numchanpin.frame), CGRectGetMaxY(self.numchanpin.frame)+3, 60, 20);
    self.chanpinLaber.font = [UIFont systemFontOfSize:11.0];
    self.chanpinLaber.text = @"产品";
    self.chanpinLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_chanpinLaber];
    //
    self.numzixunLaber = [[UILabel alloc]init];
    self.numzixunLaber.frame = CGRectMake(CGRectGetMaxX(self.numchanpin.frame)+5, CGRectGetMinY(self.numchanpin.frame),CGRectGetWidth(self.numchanpin.frame), CGRectGetHeight(self.numchanpin.frame));
    self.numzixunLaber.textColor = [UIColor blueColor];
    // self.numzixunLaber.text = @"60";
    [self.headView addSubview:_numzixunLaber];
    //
    self.zixunLaber = [[UILabel alloc]init];
    self.zixunLaber.frame = CGRectMake(CGRectGetMinX(self.numzixunLaber.frame), CGRectGetMinY(self.chanpinLaber.frame), CGRectGetWidth(self.chanpinLaber.frame), CGRectGetHeight(self.chanpinLaber.frame));
    self.zixunLaber.textColor = [UIColor grayColor];
    self.zixunLaber.font = [UIFont systemFontOfSize:11.0];
    self.zixunLaber.text = @"咨询";
    [self.headView addSubview:_zixunLaber];
    
    //
    self.numbaodanLaber = [[UILabel alloc]init];
    self.numbaodanLaber.frame = CGRectMake(CGRectGetMaxX(self.numzixunLaber.frame)+15, CGRectGetMinY(self.numzixunLaber.frame), CGRectGetWidth(self.numzixunLaber.frame), CGRectGetHeight(self.numzixunLaber.frame));
    self.numbaodanLaber.textColor = [UIColor blueColor];
    // self.numbaodanLaber.text = @"250";
    [self.headView addSubview:_numbaodanLaber];
    
    //
    self.baodanLaber =[[UILabel alloc]init];
    self.baodanLaber.frame = CGRectMake(CGRectGetMinX(self.numbaodanLaber.frame)-10, CGRectGetMinY(self.zixunLaber.frame), CGRectGetWidth(self.zixunLaber.frame), CGRectGetHeight(self.zixunLaber.frame));
    self.baodanLaber.textColor = [UIColor grayColor];
    self.baodanLaber.font = [UIFont systemFontOfSize:11.0];
    self.baodanLaber.text = @"保单体检";
    [self.headView addSubview:_baodanLaber];
    
    //
    self.numkehuLaber = [[UILabel alloc]init];
    self.numkehuLaber.frame = CGRectMake(CGRectGetMaxX(self.numbaodanLaber.frame)+10, CGRectGetMinY(self.numbaodanLaber.frame), CGRectGetWidth(self.numbaodanLaber.frame), CGRectGetHeight(self.numbaodanLaber.frame));
    self.numkehuLaber.textColor = [UIColor blueColor];
    //  self.numkehuLaber.text = @"300";
    [self.headView addSubview:_numkehuLaber];
    
    //
    self.kehuLaber = [[UILabel alloc]init];
    self.kehuLaber.frame = CGRectMake(CGRectGetMinX(self.numkehuLaber.frame), CGRectGetMinY(self.baodanLaber.frame), CGRectGetWidth(self.baodanLaber.frame), CGRectGetHeight(self.baodanLaber.frame));
    self.kehuLaber.textColor = [UIColor grayColor];
    self.kehuLaber.font = [UIFont systemFontOfSize:11.0];
    self.kehuLaber.text = @"服务客户";
    [self.headView addSubview:_kehuLaber];
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     
     
     */
    
    
    return 24;
}
//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return 120;
    }
    if (indexPath.section == 2) {
        return 200;
    }
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 4) {
        return 80;
    }
    if (indexPath.section == 5) {
        return 120;
    }
    else
    {
        return kScreenHeight * 0.081;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        return 7;
    }
    if (section == 1) {
        return  1;
    }
    if (section == 4) {
        return self.messArry.count;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return self.daraArry.count;
    }
    if (section == 5) {
        return  self.newsArry.count;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = @"执行区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            // cell.detailTextLabel.text = self.service_area;
            self.areaLaber = [[UILabel alloc]init];
            self.areaLaber.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.areaLaber.font = [UIFont systemFontOfSize:13.0];
            self.areaLaber.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_areaLaber];
            //NSLog(@"%@",self.service_area);
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"所属区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.area;
            self.area = [[UILabel alloc]init];
            self.area.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.area.font = [UIFont systemFontOfSize:13.0];
            self.area.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_area];
            
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.textLabel.text = @"所属公司";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.company;
            self.company = [[UILabel alloc]init];
            self.company.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.company.font = [UIFont systemFontOfSize:13.0];
            self.company.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_company];
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.textLabel.text = @"所在机构";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.oname;
            self.oname = [[UILabel alloc]init];
            self.oname.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.oname.font = [UIFont systemFontOfSize:13.0];
            self.oname.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_oname];
        }
        if (indexPath.section == 0 && indexPath.row == 4) {
            cell.textLabel.text = @"机构地址";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.address;
            self.address = [[UILabel alloc]init];
            self.address.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.address.font = [UIFont systemFontOfSize:13.0];
            self.address.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_address];
        }
        
        if (indexPath.section == 0 && indexPath.row == 5) {
            cell.textLabel.text = @"资格证书号码";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.certificate_no;
            self.certificate_no = [[UILabel alloc]init];
            self.certificate_no.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.certificate_no.font = [UIFont systemFontOfSize:13.0];
            self.certificate_no.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_certificate_no];
        }
        
        if (indexPath.section == 0 && indexPath.row == 6) {
            cell.textLabel.text = @"执业证编号";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.exhibition_no;
            self.exhibition_no = [[UILabel alloc]init];
            self.exhibition_no.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.exhibition_no.font = [UIFont systemFontOfSize:13.0];
            self.exhibition_no.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_exhibition_no];
        }
        
    }
    
    if (indexPath.section == 3) {
        WHprevTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"forIndexPath:indexPath ];
        WHmicpro * model = self.daraArry[indexPath.row];
        [cell1.myImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell1.titLaber.text = model.name;
        cell1.ageLaber.text = model.limit_age;
        cell1.styLaber.text = model.ptype_name;
        
        
        //        cell1.titLaber.text = model.name;
    }
    if (indexPath.section == 2) {
        self.scolw = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), 200)];
        self.scolw.contentSize = CGSizeMake(CGRectGetWidth(self.scolw.frame)*self.ImgArry.count, 200);
        self.  page =[[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scolw.frame)-20,
                                                                    CGRectGetWidth(self.view.frame), 10)];
        self. page.backgroundColor =[UIColor grayColor];
        
        [cell.contentView addSubview:_scolw];
        self.scolw.pagingEnabled = YES;
        self.page.currentPage = 0;
        self.page.numberOfPages = self.ImgArry.count;
        self.page.currentPageIndicatorTintColor = [UIColor redColor];
        [cell.contentView addSubview:_page];
        //        UIImageView * myImg = [[UIImageView alloc]init];
        //        myImg.frame = CGRectMake(0, 20, kScreenWitdh, 180);
        //myImg.image = [UIImage imageNamed:@"test_head"];
        for (int i = 0; i< self.ImgArry.count; i++) {
            NSString *imageName =[NSString stringWithFormat:@"%@",self.ImgArry[i]];
            // UIImageView *imageview =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
            UIImageView * imageview = [[UIImageView alloc]init];
            [imageview sd_setImageWithURL:[NSURL URLWithString:imageName]];
            imageview.frame =CGRectMake(CGRectGetWidth(self.scolw.frame)*i , 10, CGRectGetWidth(self.scolw.frame), 180);
            [self.scolw addSubview:imageview];
            
        }
        
    }
    if (indexPath.section == 1) {
        self.Mytextview = [[UITextView alloc]init];
        self.Mytextview.frame = CGRectMake(CGRectGetMinX(cell.textLabel.frame), CGRectGetMinY(cell.textLabel.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 40);
        self.Mytextview.textColor = [UIColor grayColor];
        self.Mytextview.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
        
        self.Mytextview.delegate = self;//设置它的委托方法
        
        self.Mytextview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
        self.Mytextview.scrollEnabled = YES;//是否可以拖动
        self.Mytextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        self.Mytextview.text = self.strIntru;
       // NSLog(@"kkkkk%@",self.Mytextview.text);
        [cell.contentView addSubview:_Mytextview];
        
    }
    if (indexPath.section == 4) {
        WHmessageListTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        WHgetmessage * mes = self.messArry[indexPath.row];
        cell2.myTit.text = mes.message;
        cell2.addressLaber.text = mes.city_name;
        //NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:mes.create_time.doubleValue];
        
        NSString * s1  = [NSString stringWithFormat:@"%@",confromTimesp];
        cell2.timeLaber.text = [s1 substringToIndex:11];
    }
    
    if (indexPath.section == 5) {
        WHcounselTableViewCell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        WHnews * news = self.newsArry[indexPath.row];
        [cell3.myImg sd_setImageWithURL:[NSURL URLWithString:news.thumbnail]];
        cell3.myTit.text = news.title;
        NSString * s2 = @"阅读";
        cell3.readNum.text = [news.count stringByAppendingString:s2];
        NSString * s4 = @"类型:";
        if (news.soucre == nil) {
            news.soucre =@"行业新闻";
        }
        cell3.styLaber.text = [s4 stringByAppendingString:news.soucre];
        NSString * s5 = news.created_time;
        cell3.timeLaber.text = [s5 substringToIndex:11];
        
    }
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSString * s1 = @"基本信息";
        return s1;
    }
    if (section == 1) {
        NSString * s1 = @"个人介绍";
        return s1;
    }
    if (section == 2) {
        NSString * s1 = @"个人荣誉";
        return s1;
    }
    if (section == 3) {
        NSString * s1 = @"推荐险种";
        return s1;
    }
    if (section == 4) {
        NSString * s1 = @"我要留言";
        return s1;
    }
    if (section == 5) {
        NSString * s1 = @"保险咨询";
        return s1;
    }
    //    if (section == 6) {
    //        NSString * s1 = @"保险方案";
    //        return s1;
    //    }
    
    
    else
    {
        return @"";
    }
}
//信息事件
-(void)messageAction:(UIButton *)sender
{
    NSLog(@"mseeage");
    WHwantMessageViewController * wantMes = [[WHwantMessageViewController alloc]init];
    wantMes.res_uid = self.agentID;
    wantMes.name = self.nameLaber.text;
//    NSString * s1 = self.areaLaber.text ;
    //wantMes.cityName = [s1 substringToIndex:2];
    wantMes.cityName = self.areaLaber.text;
    
    [self.navigationController pushViewController:wantMes animated:YES];
}
//电话事件
-(void)telAction:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //  alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}
//图片减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.page.currentPage = self.scolw.contentOffset.x / self.scolw.frame.size.width;
    
}
//选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        WHnews * news = self.newsArry[indexPath.row];
        WHnewsdetailViewController * detal = [[WHnewsdetailViewController alloc]init];
        detal.newsID = news.id;
        detal.newsHeadimg = self.imgUrl;
        detal.newsName = self.nameLaber.text;
        detal.newsSeximg = self.sexUrl;
        detal.newsYear = self.yearLaber.text;
        detal.newsCompany = self.companyLaber.text;
        detal.tel = self.tel;
        detal.agentID = self.agentID;
        [self.navigationController pushViewController:detal animated:YES];
        
        
    }
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
