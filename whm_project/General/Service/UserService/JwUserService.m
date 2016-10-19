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
    param = [[self filterParam:param interface:@"login"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/login" success:^(id data) {
        
        NSDictionary *info = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:info error:nil];
        
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
    
    param = [[self filterParam:param interface:@"regist"] mutableCopy];
    
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
    
    NSMutableDictionary *param = [@{@"uid": [JwUserCenter sharedCenter].session} mutableCopy];
    param = [[self filterParam:param interface:@"logout"] mutableCopy];
    
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
    
    param = [[self filterParam:param interface:@"reset_pwd"]mutableCopy];
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
                    type:(NSString *)type
               templates:(NSString *)templates
            check_mobile:(NSString *)check_mobile
                 user_id:(NSString *)user_id
                 success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"modile":mobile,
                                     @"type":type,
                                     @"templates":templates,
                                     @"check_mobile":check_mobile,
                                     @"user_id":user_id} mutableCopy];
    param = [[self filterParam:param interface:@"send_sms"]mutableCopy];
    
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
    
    NSMutableDictionary * param = [@{@"uid":uid,
                                     @"old_pwd":old_pwd,
                                     @"pwd":pwd} mutableCopy];
    param = [[self filterParam:param interface:@"send_sms"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/update_pwd" success:^(id data) {
        
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
