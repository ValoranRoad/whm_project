//
//  WHproductSearchTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/11/9.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

@interface WHproductSearchTableViewController : JwBackBaseController

@property(nonatomic,strong)NSString * company_id;
@property (nonatomic, strong) NSMutableArray *groupsArr;
@property (nonatomic, assign) BOOL isSelectP;

@property (nonatomic, strong) NSMutableDictionary *contentDic;
@property (nonatomic, strong) NSMutableDictionary *fuzhiDic;

@end
