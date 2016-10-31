//
//  WHgetrec.h
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHgetrec : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * short_name;
@property(nonatomic,strong)NSString <Optional>* img;
@property(nonatomic,strong)NSString * small_img;
@property(nonatomic,strong)NSString * limit_age;
@property(nonatomic,strong)NSString * prod_type_code;
@property(nonatomic,strong)NSString <Optional> *prod_type_code_name;
@property(nonatomic,strong)NSString * logo;


@end
