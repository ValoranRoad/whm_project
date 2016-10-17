//
//  JwUserService.h
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"

@interface JwUserService : JwServiceBase

//账号登出
- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
//验证码发送
- (void)dynamicCodeSuccess:(void (^)(NSString *token))success failure:(void (^)(NSError *error))failure;

- (void)change2Password:(NSString *)aNewPassword oldPwd:(NSString *)oldPwd success:(void (^)())success failure:(void (^)(NSError *error))failure;

- (void)updateCheck:(void (^)(BOOL shouldUpdate, id info))success failure:(void (^)(NSError *error))failure;
@end
