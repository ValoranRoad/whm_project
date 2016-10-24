//
//  WHcompanyDetail.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@interface WHcompanyDetail : JwModelBase
@property(nonatomic,strong)NSString * id ;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * initial;
@property(nonatomic,strong)NSString * pinyin;
@property(nonatomic,strong)NSString <Optional> * description;
@property(nonatomic,strong)NSString * logo;
@property(nonatomic,strong)NSString * add;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * ctype;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * area;
@property(nonatomic,strong)NSString * website;
@property(nonatomic,strong)NSString * is_quoted;
@property(nonatomic,strong)NSString * is_beadhouse;
@property(nonatomic,strong)NSString * specialtoes;
@property(nonatomic,strong)NSString * short_name ;
@property(nonatomic,strong)NSString * shortest;
@property(nonatomic,strong)NSString <Optional> * honor;
@property(nonatomic,strong)NSString <Optional> *history;
@property(nonatomic,strong)NSString * type_name;
@property(nonatomic,assign)NSArray * hot_pro;
@property(nonatomic,strong)NSDictionary * count;
@property(nonatomic,assign)NSArray * ins_type;
@property(nonatomic,assign)NSArray * sale_status;
@property(nonatomic,assign)NSArray * year_app;
@property(nonatomic,assign)NSArray * prod_type_code_app;



@end
