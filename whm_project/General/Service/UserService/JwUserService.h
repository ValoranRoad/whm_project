//
//  JwUserService.h
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"

@class JwUser;

@interface JwUserService : JwServiceBase

//登录接口
- (void)loginWithMobile:(NSString *)mobile
               password:(NSString *)password
                success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure;

//用户或代理人注册
- (void)registWithName:(NSString *)name
          mobile:(NSString *)mobile
         captcha:(NSString *)captcha
             pwd:(NSString *)pwd
            type:(NSString *)type
      company_id:(NSString *)company_id
          org_id:(NSString *)org_id
   exhibition_no:(NSString *)exhibition_no
        nickname:(NSString *)nickname
       work_time:(NSString *)work_time
       id_number:(NSString *)id_number
      profession:(NSString *)profession
   specialize_in:(NSString *)specialize_in
         address:(NSString *)address
         success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure;

//退出登录
- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;



//忘记密码
-(void)forgetwordWithMobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                        pwd:(NSString *)pwd
                    success:(void (^)())success failure:(void (^)(NSError *error))failure;
//发送短信

-(void)sendsmsWithMobile:(NSString *)mobile
                    type:(NSString *)type
               templates:(NSString *)templates
            check_mobile:(NSString *)check_mobile
                 user_id:(NSString *)user_id
success:(void (^)())success failure:(void (^)(NSError *error))failure;

//修改密码

-(void)updatepwdUid:(NSString *)uid
            old_pwd:(NSString *)old_pwd
                pwd:(NSString *)pwd

            success:(void (^)())success failure:(void (^)(NSError *error))failure;




@end
