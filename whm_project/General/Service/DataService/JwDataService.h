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
@class WHgetmessageDetall;
@class WHgetintroduce;
@class WHgethonor;
@class WHmicro;
@class WHgetprofirst;
@class WHgetappcate;
@class WHgetproperiod;
@class WHgetcharacters;
@class WHget_pro_rate;
@class WHgetreport;
@class WHgetpolicys;

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
                             sex:(NSString *)sex
            characters_insurance:(NSString *)characters_insurance
                          period:(NSString *)period
                         cate_id:(NSString *)cate_id
                      pay_period:(NSString *)pay_period
                            rate:(NSString *)rate
                         insured:(NSString *)insured
                        birthday:(NSString *)birthday
                   yearly_income:(NSString *)yearly_income
                            debt:(NSString *)debt
                         rela_id:(NSString *)rela_id
                               p:(NSString *)p
                        pagesize:(NSString *)pagesize
success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//获取用户信息
-(void)get_user_infoWithUid:(NSString *)uid
                    success:(void (^)(NSArray * lists))success failure:(void (^)(NSError * error))failure;


//公司详情列表
-(void)get_company_detailWithCom_id:(NSString * )com_id
                                uid:(NSString *)uid
success:(void (^)(NSArray * list))success failure:(void (^)(NSError *error))failure;

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
                          uid:(NSString *)uid
                            p:(NSString *)p
                    pagesize :(NSString *)pagesize
  success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;

//推荐险种列表
-(void)getrecWithAgent_uid:(NSString *)agent_uid
                       uid:(NSString *)uid
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;

//留言详情接口
-(void)getmessagedetailWithId:(NSString *)ids
                        uid:(NSString * )uid
  success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//获取个人介绍
-(void)getintroduceWithUid:(NSString *)uid

 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//荣誉列表
-(void)gethonorWithUid:(NSString * )uid
               success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;



//代理人个人微站
-(void)getMicroWithAgent_uid:(NSString *)agent_uid uid:(NSString *)uid
                     success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//找险种搜索首页数据
-(void)getprofirstWithUid:(NSString * )uid
                   success:(void (^)(WHgetprofirst *profirst))success failure:(void (^)(NSError *error))failure;

//找险种高级搜索分类

-(void)getappcateWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//保障期间
-(void)getproperiodWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;



//险种特色保障
-(void)getcharactersWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//体检险种费率数据结构
-(void)getprorateWithPid:(NSString *)pid
                     uid:(NSString *)uid
                  gender:(NSString *)gender
 success:(void (^)(NSArray * lists, NSArray *pay_periodArr, NSArray *payoutArr))success failure:(void (^)(NSError *error))failure;


//体检保存
-(void)getsavepolictWithUid:(NSString *)uid
                    rela_id:(NSString *)rela_id
                       pros:(NSString *)pros
success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//保单列表
-(void)getpolicysWithUid:(NSString * )uid
                 rela_id:(NSString *)rela_id
                 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;



@end
