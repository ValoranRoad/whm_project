//
//  HmHotCompanyCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HmCompanyCollectionCell.h"

@interface HmHotCompanyCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *hotCompanyArr;

@end
