//
//  JwDataService.h
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"
@class JwCompanys;
@class WHorganization;
@class WHhotcompany;
@class WHgetproduct;
@class WHgetuseinfo;
@class WHcompanyDetail;
@class WHhospital;
@class WHget_product_detail;
@class WHget_user_realtion;
@class WHget_relation_detail;
@class WHgetmessage;
@class WHgetrec;




@interface JwDataService : JwServiceBase



//获取公司列表
- (void)get_CompanysWithType:(NSString *)type
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//获取分支机构列表

-(void)get_OrganizationWithCom_id:(NSString *)com_id
                        city_name:(NSString *)city_name
                         province:(NSString *)province
                             city:(NSString *)city
                           county:(NSString *)county
                          success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//热门公司列表
-(void)get_hot_companyWithsuccess:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;


//找险种列表

-(void)get_productWithCompany_id:(NSString *)company_id
                         keyword:(NSString *)keyword
                   special_attri:(NSString *)special_attri
                  prod_type_code:(NSString *)prod_type_code
                       ins_type :(NSString *)ins_type
                          is_hot:(NSString *)is_hot
                        pagesize:(NSString *)pagesize
success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//获取用户信息
-(void)get_user_infoWithUid:(NSString *)uid
                    success:(void (^)(WHgetuseinfo *userInfo))success failure:(void (^)(NSError * error))failure;


//公司详情列表
-(void)get_company_detailWithCom_id:(NSString * )com_id
                                uid:(NSString *)uid
success:(void (^)(WHcompanyDetail * userInfo))success failure:(void (^)(NSError *error))failure;

//医院列表
-(void)get_hospitalWithCom_id:(NSString *)com_id
                    city_name:(NSString *)city_name
                     province:(NSString *)province
                         city:(NSString *)city
                       county:(NSString *)county
                          lat:(NSString *)lat
                          lng:(NSString *)lng
                     distance:(NSString *)distance
                      success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;


//险种详情
-(void)get_product_detailWithPro_id:(NSString * )pro_id
                                uid:(NSString * )uid
                            success:(void (^)(WHget_product_detail * userInfo))success failure:(void (^)(NSError *error))failure;



//获取用户关系成员接口列表
-(void)get_user_realtionWithUid:(NSString *)uid
                        success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;


//获取关系人详情
-(void)get_relation_detailWithId :(NSString *)ids

                          success:(void (^)(WHget_relation_detail * userInfo))success failure:(void (^)(NSError *error))failure;



//获取留言列表
-(void)getmessageWithRes_uid :(NSString *)res_uid
                            p:(NSString *)p
                    pagesize :(NSString *)pagesize
  success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;

//推荐险种列表
-(void)getrecWithAgent_uid:(NSString *)agent_uid
success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;


@end
