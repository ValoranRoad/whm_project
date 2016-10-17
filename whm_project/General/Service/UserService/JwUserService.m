//
//  JwUserService.m
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwUserService.h"
#import "JwUserCenter.h"

@implementation JwUserService

- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    NSString *session = [JwUserCenter sharedCenter].session;
    if (session.length == 0) {
        failure(nil);
        return;
    }
    NSDictionary *param = @{@"sessionKey": session};
    param = [self filterParam:param];
    
    [self.httpManager GET:param withPoint:@"logout" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)dynamicCodeSuccess:(void (^)(NSString *token))success failure:(void (^)(NSError *error))failure {
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.dynamicCode.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session};
    param = [self filterParam:param];
    [self.httpManager GET:param withPoint:@"getToken" success:^(id data) {
        
        success(data[@"token"]);
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

- (void)change2Password:(NSString *)aNewPassword oldPwd:(NSString *)oldPwd success:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.changePassword.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"newPassword": aNewPassword,
                            @"currentPassword": oldPwd,
                            @"sessionKey": [JwUserCenter sharedCenter].session};
    
    param = [self filterParam:param];
    param = [self signaturedParam:param];
    [self.httpManager GET:param withPoint:@"changePassword" success:^(id data) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)updateCheck:(void (^)(BOOL shouldUpdate, id info))success failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{};
    param = [self filterParam:param];
    param = [self signaturedParam:param];
    
    [self.httpManager GET:param withPoint:@"checkUpdate" success:^(id data) {
        if (success) {
            BOOL shouldUpdate = NO;
            id appVersion = data[@"appVersion"];
            if (appVersion == nil || [appVersion isKindOfClass: [NSNull class]]) {
                success(NO, nil);
                
                return;
            }
            
            id version = data[@"appVersion"][@"versionNumber"];
            NSString *localVer= param[@"ver"];
            NSArray *versionComponents = [version componentsSeparatedByString:@"."];
            NSArray *localComponents = [localVer componentsSeparatedByString:@"."];
            
            for (int i=0; i < versionComponents.count; i++) {
                id s = versionComponents[i];
                id l = nil;
                if (i < localComponents.count) {
                    l = localComponents[i];
                    
                    if ([l compare:s] == NSOrderedAscending) {
                        shouldUpdate = YES;
                        break;
                    }
                }else {
                    shouldUpdate = YES;
                    break;
                }
            }
            
            success(shouldUpdate, data);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
