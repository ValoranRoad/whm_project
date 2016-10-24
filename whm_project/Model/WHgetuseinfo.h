//
//  WHgetuseinfo.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHgetuseinfo : JwModelBase
@property(nonatomic,strong)NSString * id ;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString<Optional> * email;
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString * mobile ;
@property(nonatomic,strong)NSString<Optional> * contact_way;
@property(nonatomic,strong)NSString<Optional> * reg_ip;
@property(nonatomic,strong)NSString<Optional> * reg_time;
@property(nonatomic,strong)NSString<Optional> * last_login;
@property(nonatomic,strong)NSString<Optional> * last_ip;
@property(nonatomic,strong)NSString * avatar;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * id_number;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,strong)NSString * birthday;
@property(nonatomic,strong)NSString<Optional> *star_signs;
@property(nonatomic,strong)NSString * city;
@property(nonatomic,strong)NSString * province ;
@property(nonatomic,strong)NSString * country;
@property(nonatomic,strong)NSString * area_info;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * openid;
@property(nonatomic,strong)NSString * unionid;
@property(nonatomic,strong)NSString * headimgurl;
@property(nonatomic,strong)NSString * introduce;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * age;
@property(nonatomic,strong)NSString * status;
@property(nonatomic,strong)NSString * status_name;
@property(nonatomic,strong)NSString * company;






@end
