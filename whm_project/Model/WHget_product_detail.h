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
@property(nonatomic,strong)NSString<Optional> * id;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * short_name;
//@property(nonatomic,assign)NSArray * pay_period;
//@property(nonatomic,assign)NSArray * insurance_period;
//@property(nonatomic,assign)NSArray * limit_ago;
//@property(nonatomic,strong)NSString<Optional>* is_main;
//@property(nonatomic,strong)NSString<Optional> * ins_item_code;
//@property(nonatomic,strong)NSString<Optional> * sale_status;
//@property(nonatomic,strong)NSString<Optional> * sale_stop_date;
//@property(nonatomic,strong)NSString<Optional> * special_attri;
//@property(nonatomic,strong)NSString<Optional> * ins_type;
//@property(nonatomic,strong)NSString<Optional> * prod_desi_code;
//@property(nonatomic,strong)NSString<Optional> * prod_type_code;
//@property(nonatomic,strong)NSString<Optional> * ins_perd_type;
//@property(nonatomic,strong)NSString<Optional> * prod_pay_type;
//@property(nonatomic,strong)NSString<Optional> * is_has_rate;
//@property(nonatomic,strong)NSString<Optional> * is_hot;
//@property(nonatomic,strong)NSString<Optional> * limit_age_name;
//@property(nonatomic,strong)NSString<Optional> * special_attri_name;
//@property(nonatomic,strong)NSString<Optional> * sale_status_name;
//@property(nonatomic,strong)NSString<Optional> * prod_type_code_name;
//@property(nonatomic,strong)NSString<Optional> * prod_desi_code_name;
//@property(nonatomic,strong)NSString <Optional>* is_must;
//@property(nonatomic,assign)NSArray * not_is_must;
//@property(nonatomic,strong)NSString <Optional> * characters;
//@property(nonatomic,assign)NSArray * company;
//@property(nonatomic,assign)NSArray * same;
//其他信息
@property(nonatomic,strong)NSString <Optional> * clause;
@property(nonatomic,strong)NSString <Optional> * cases;
@property(nonatomic,strong)NSString <Optional> * rights;
@property(nonatomic,strong)NSString <Optional> * rule;
@property(nonatomic,strong)NSString <Optional> * pdf_path;
@property(nonatomic,strong)NSString <Optional> * company_logo;
@property(nonatomic,strong)NSString <Optional> * company_short_name;
@property(nonatomic,strong)NSString <Optional> * ins_type_name;
@property(nonatomic,strong)NSString <Optional> * sale_status_name;
@property(nonatomic,strong)NSString <Optional> * is_main;



@end
