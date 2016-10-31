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
#import "WHget_user_realtion.h"
#import "WHget_relation_detail.h"
#import "WHgetmessage.h"
#import "WHgetrec.h"
#import "WHgetmessageDetall.h"


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
//获取热门公司
-(void)get_hot_companyWithsuccess:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_hot_company"] mutableCopy];
    
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
                    success:(void (^)(WHgetuseinfo *userInfo))success failure:(void (^)(NSError * error))failure
{
    NSMutableDictionary *param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                    @"token":[JwUserCenter sharedCenter].key}
                                  mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_user_info"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_user_info" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        WHgetuseinfo *userinfos = [[WHgetuseinfo alloc] initWithDictionary:[infos firstObject] error:nil];
        
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
                            success:(void (^)(WHcompanyDetail * userInfo))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_company_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_company_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        WHcompanyDetail *companydetals = [[WHcompanyDetail  alloc]initWithDictionary:[infos firstObject] error:nil];
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
                            success:(void (^)(WHget_product_detail * userInfo ))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"pro_id":pro_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_product_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_product_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        WHget_product_detail *productdetails = [[WHget_product_detail  alloc]initWithDictionary:[infos firstObject] error:nil];
        
        if (success) {
            success(productdetails);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//获取用户关系成员接口列表
-(void)get_user_realtionWithUid:(NSString *)uid
                        success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_user_realtion"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_user_realtion" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *user_realtions = [WHget_user_realtion arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(user_realtions);
            NSLog(@"%@",user_realtions);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}

//获取关系人详情
-(void)get_relation_detailWithId:(NSString *)ids
                         success:(void (^)(WHget_relation_detail * userInfo))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param =[@{@"id":ids,
                                    @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_relation_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_relation_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
       WHget_relation_detail *relation_detail = [[WHget_relation_detail alloc]initWithDictionary:[infos firstObject] error:nil];
        if (success) {
            success(relation_detail);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}
//获取留言列表
-(void)getmessageWithRes_uid:(NSString *)res_uid
                         uid:(NSString *)uid
                           p:(NSString *)p
                    pagesize:(NSString *)pagesize
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"res_uid":[JwUserCenter sharedCenter].uid,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"p":p,
                              @"pagesize":pagesize,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_messages"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_messages" success:^(id data) {
        NSArray * infos = data[@"data"];
        NSArray * getmessages = [WHgetmessage arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(getmessages);
            //NSLog(@"%@",getmessages);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    

}

//获取推荐险种列表
-(void)getrecWithAgent_uid:(NSString *)agent_uid
                       uid:(NSString *)uid
                   success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
      NSMutableDictionary *param = [@{@"agent_uid": [JwUserCenter sharedCenter].uid,
                                      @"uid":[JwUserCenter sharedCenter].uid,
                                      @"token":[JwUserCenter sharedCenter].key} mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_rec"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_rec" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *getrecs = [WHgetrec arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(getrecs);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
//留言详情接口
//-(void)get_all_areaWithsuccess:(void (^)(NSArray *areas))success failure:(void (^)(NSError *error))failure
//{
//    
//    
//    
//    
//    NSMutableDictionary * param = [@{} mutableCopy];
//    
//    param = [[self filterParam:param interface:@"kb/get_all_area"] mutableCopy];
//    
//    [self.httpManager POST:param withPoint:@"kb/get_all_area" success:^(id data) {
//        
//        NSArray *infos = data[@"data"];
//        NSArray *areas = [JwAreass arrayOfModelsFromDictionaries:infos error:nil];
//        if (success) {
//            success(areas);
//        }
//        
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//    
//}

-(void)getmessagedetailWithId:(NSString *)ids uid:(NSString *)uid success:(void (^)(NSArray *mesdetals ))success failure:(void (^)(NSError *error))failure
{
    NSDictionary * param = [@{@"id":ids,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_message_detail"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_message_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *mesdetals = [WHgetmessageDetall  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(mesdetals);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];


    
    
}




@end
