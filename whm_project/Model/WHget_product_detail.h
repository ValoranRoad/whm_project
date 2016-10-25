//
//  WHget_product_detail.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHget_product_detail : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * short_name;
@property(nonatomic,strong)NSString<Optional> * company_logo;
@property(nonatomic,strong)NSString<Optional> * company_short_name;
@property(nonatomic,assign)NSArray * pay_period;
@property(nonatomic,assign)NSArray * insurance_period;
@property(nonatomic,assign)NSArray * limit_ago;
@property(nonatomic,strong)NSString * is_main;
@property(nonatomic,strong)NSString * ins_item_code;
@property(nonatomic,strong)NSString * sale_status;
@property(nonatomic,strong)NSString * sale_stop_date;
@property(nonatomic,strong)NSString * special_attri;
@property(nonatomic,strong)NSString * ins_type;
@property(nonatomic,strong)NSString * prod_desi_code;
@property(nonatomic,strong)NSString * prod_type_code;
@property(nonatomic,strong)NSString * ins_perd_type;
@property(nonatomic,strong)NSString * prod_pay_type;
@property(nonatomic,strong)NSString * is_has_rate;
@property(nonatomic,strong)NSString * is_hot;
@property(nonatomic,strong)NSString * limit_age_name;
@property(nonatomic,strong)NSString * special_attri_name;
@property(nonatomic,strong)NSString * sale_status_name;
@property(nonatomic,strong)NSString * ins_type_name;
@property(nonatomic,strong)NSString * prod_type_code_name;
@property(nonatomic,strong)NSString * prod_desi_code_name;
@property(nonatomic,strong)NSString <Optional>* is_must;
@property(nonatomic,assign)NSArray * not_is_must;
@property(nonatomic,strong)NSString <Optional> * characters;
@property(nonatomic,assign)NSArray * company;
@property(nonatomic,assign)NSArray * same;


@end
