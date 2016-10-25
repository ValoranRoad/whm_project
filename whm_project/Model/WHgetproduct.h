//
//  WHgetproduct.h
//  whm_project
//
//  Created by 王义国 on 16/10/22.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHgetproduct : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * company_id;
@property(nonatomic,strong)NSString * limit_age;
@property(nonatomic,strong)NSString * prod_type_code;
@property(nonatomic,strong)NSString * ins_type;
@property(nonatomic,strong)NSString * is_has_rate;
@property(nonatomic,strong)NSString * is_main;
@property(nonatomic,strong)NSString * pro_type_code_name;
@property(nonatomic,strong)NSString * ins_type_name;

@end
