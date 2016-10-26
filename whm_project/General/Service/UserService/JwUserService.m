//
//  JwUserService.m
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwUserService.h"
#import "JwUserCenter.h"
#import "JwUser.h"

@implementation JwUserService

//登录接口
- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"mobile": mobile,
                                    @"pwd": password} mutableCopy];
    param = [[self filterParam:param interface:@"kb/login"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/login" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:[infos firstObject] error:nil];
        
        [JwUserCenter sharedCenter].user = user;
        [JwUserCenter sharedCenter].isLogined = YES;
        [[JwUserCenter sharedCenter] save];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

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
         success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"name": name,
                                    @"mobile": mobile,
                                    @"captcha": captcha,
                                    @"pwd": pwd,
                                    @"type": type} mutableCopy];
    if ([type isEqualToString:@"1"]) {
        param[@"company_id"] = company_id;
        param[@"org_id"] = org_id;
        param[@"exhibition_no"] = exhibition_no;
        param[@"nickname"] = nickname;
        param[@"id_number"] = id_number;
        if (work_time) {
            param[@"work_time"] = work_time;
        }
        if (profession) {
            param[@"profession"] = profession;
        }
        if (specialize_in) {
            param[@"specialize_in"] = specialize_in;
        }
        if (address) {
            param[@"address"] = address;
        }
    }
    
    param = [[self filterParam:param interface:@"kb/regist"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/regist" success:^(id data) {
        
        NSDictionary *info = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:info error:nil];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//退出登录
- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"uid": [JwUserCenter sharedCenter].uid} mutableCopy];
    param = [[self filterParam:param interface:@"kb/logout"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/logout" success:^(id data) {
        
        [JwUserCenter sharedCenter].user = nil;
        [JwUserCenter sharedCenter].isLogined = NO;
        [[JwUserCenter sharedCenter] save];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//忘记密码
-(void)forgetwordWithMobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                        pwd:(NSString *)pwd
                    success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"mobile":mobile,
                                     @"captcha":captcha,
                                     @"pwd":pwd} mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/reset_pwd"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/reset_pwd" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//发送短信
-(void)sendsmsWithMobile:(NSString *)mobile
            check_mobile:(NSString *)check_mobile
                 success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"mobile":mobile,
                                     @"check_mobile":check_mobile
                                     } mutableCopy];
    param = [[self filterParam:param interface:@"kb/send_sms"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/send_sms" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

//修改密码
-(void)updatepwdUid:(NSString *)uid
            old_pwd:(NSString *)old_pwd
                pwd:(NSString *)pwd
            success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"old_pwd":old_pwd,
                                     @"pwd":pwd,
                                     @"token":[JwUserCenter sharedCenter].key
                                     } mutableCopy];
    param = [[self filterParam:param interface:@"kbj/update_pwd"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/update_pwd" success:^(id data) {

        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
//保存用户信息

-(void)save_userWithUid:(NSString *)uid
                 avatar:(NSString *)avatar
                   name:(NSString *)name
                    sex:(NSString *)sex
               birthday:(NSString *)birthday
              area_info:(NSString *)area_info
           area_info_id:(NSString *)area_info_id
                address:(NSString *)address
                success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid ,
                              @"avatar":avatar ,
                              @"name":name ,
                              @"sex":sex ,
                              @"birthday":birthday,
                              @"area_info":area_info ,
                              @"area_info_id":area_info_id,
                              @"address":address,
                              @"token":[JwUserCenter sharedCenter].key
                              }mutableCopy];
    
    param = [[self filterParam:param interface:@"kbj/save_user"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/save_user" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}

//保存认证信息
-(void)save_verifyWithUid:(NSString *)uid
                  company:(NSString *)company
                     name:(NSString *)name
               cardnumber:(NSString *)cardnumber
       organizationnumber:(NSString *)organizationnumber
                    point:(NSString *)point
                  address:(NSString *)address
                      job:(NSString *)job
                  success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid ,
                              @"company":company ,
                              @"name":name ,
                              @"cardnumber":cardnumber ,
                              @"organizationnumber":organizationnumber,
                              @"point":point ,
                              @"address":address,
                              @"job":job,
                              @"token":[JwUserCenter sharedCenter].key}
                            mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_verify"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/save_verify" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}

//修改手机号
-(void)update_mobileWithUid:(NSString *)uid
                     mobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                    success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"mobile":mobile,
                              @"captcha":captcha,
                              @"token":[JwUserCenter sharedCenter].key}
                            mutableCopy];
    param = [[self filterParam:param interface:@"kbj/update_mobile"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/update_mobile" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//保存用户关系成员接口
-(void)save_user_realtionWithUid:(NSString *)uid
                              id:(NSString *)ids
                            name:(NSString *)name
                             sex:(NSString *)sex
                        birthday:(NSString *)birthday
                        relation:(NSString *)relation
                   yearly_income:(NSString *)yearly_income
                      yearly_out:(NSString *)yearly_out
                            debt:(NSString *)debt
                         success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"id":ids,
                              @"name":name,
                              @"sex":sex,
                              @"birthday":birthday,
                              @"relation":relation,
                              @"yearly_income":yearly_income,
                              @"yearly_out":yearly_out,
                              @"debt":debt,
                              @"token":[JwUserCenter sharedCenter].key}
                            mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_user_realtion"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/save_user_realtion" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}

//删除联系人
-(void)del_relationWithId:(NSString *)ids
                  success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"id":ids,
                                     @"token":[JwUserCenter sharedCenter].key}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_relation"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/del_relation" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
//获取地区
-(void)get_all_areaWithsuccess:(void (^)())success failure:(void (^)(NSError *))failure
{
   
    NSMutableDictionary * param = [@{}mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/get_all_area"]mutableCopy];

    [self.httpManager POST:param withPoint:@"kb/get_all_area" success:^(id data) {
        
        if (success) {
            success();
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
