//
//  JwDataService.m
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwDataService.h"
#import "JwCompanys.h"
#import "WHorganization.h"
#import "WHhotcompany.h"
#import "WHgetproduct.h"
#import "WHgetuseinfo.h"
#import "WHcompanyDetail.h"
#import "WHhospital.h"
#import "WHget_product_detail.h"

#import "JwUserCenter.h"
#import "JwUser.h"


@implementation JwDataService

//获取公司列表
- (void)get_CompanysWithType:(NSString *)type
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"type": type} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_companys"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_companys" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *companys = [JwCompanys arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(companys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//获取分支机构列表
-(void)get_OrganizationWithCom_id:(NSString *)com_id
                        city_name:(NSString *)city_name
                         province:(NSString *)province
                             city:(NSString *)city
                           county:(NSString *)county
                          success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id,
                                    @"city_name":city_name,
                                    @"province":province,
                                    @"city":city,
                                    @"county":county}mutableCopy];
    param =[[self filterParam:param interface:@"kb/get_organization"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_organization" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *organs = [WHorganization arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (organs);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
  
    
}
//获取热门公司里边没有参数??
-(void)get_hot_companyWithsuccess:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [[self filterParam:param interface:@"kb/get_hot_company"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_hot_company" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *hotcompanys = [WHhotcompany arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (hotcompanys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
    
}
//获取险种列表
-(void)get_productWithCompany_id:(NSString *)company_id
                         keyword:(NSString *)keyword
                   special_attri:(NSString *)special_attri
                  prod_type_code:(NSString *)prod_type_code
                        ins_type:(NSString *)ins_type
                          is_hot:(NSString *)is_hot
                        pagesize:(NSString *)pagesize
                         success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"company_id":company_id,
                                     @"keyword":keyword ,
                                     @"special_attri":special_attri,
                                     @"prod_type_code":prod_type_code ,
                                     @"ins_type":ins_type ,
                                     @"is_hot":is_hot,
                                     @"pagesize":pagesize}mutableCopy];
     param = [[self filterParam:param interface:@"kb/get_product"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_product" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *products = [WHgetproduct arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(products);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//获取用户信息
-(void)get_user_infoWithUid:(NSString *)uid
                    success:(void (^)(NSArray *lists))success failure:(void (^)(NSError * error))failure
{
    NSMutableDictionary *param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                    @"token":[JwUserCenter sharedCenter].key}
                                  mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_user_info"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_user_info" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *userinfos = [WHgetuseinfo arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(userinfos);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//公司详情
-(void)get_company_detailWithCom_id:(NSString *)com_id
                                uid:(NSString *)uid
                            success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_company_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_company_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *companydetals = [WHcompanyDetail arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(companydetals);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//医院列表数据
-(void)get_hospitalWithCom_id:(NSString *)com_id
                    city_name:(NSString *)city_name
                     province:(NSString *)province
                         city:(NSString *)city
                       county:(NSString *)county
                          lat:(NSString *)lat
                          lng:(NSString *)lng
                     distance:(NSString *)distance
                      success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id ,
                                     @"city_name":city_name ,
                                     @"province":province , @"city":city ,
                                     @"county":county ,
                                     @"lat":lat ,
                                     @"lng":lng ,
                                     @"distance":distance}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_hospital"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_hospital" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *hospitals = [WHhospital arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(hospitals);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//险种详情
-(void)get_product_detailWithPro_id:(NSString *)pro_id
                                uid:(NSString *)uid
                            success:(void (^)(NSArray * ))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"pro_id":pro_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_product_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_product_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *productdetails = [WHget_product_detail arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(productdetails);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}



@end
