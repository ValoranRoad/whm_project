//
//  WHorganization.h
//  whm_project
//
//  Created by 王义国 on 16/10/22.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@interface WHorganization : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString <Optional> *province_name;
@property(nonatomic,strong)NSString <Optional> *city_name;
@property(nonatomic,strong)NSString * province;
@property(nonatomic,strong)NSString * city;
@property(nonatomic,strong)NSString * longitude;
@property(nonatomic,strong)NSString * latitude;
@property(nonatomic,strong)NSString * distance;


@end
