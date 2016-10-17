//
//  JwServiceBase.m
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwHttpManager.h"
#import "JGProgressHelper.h"
#import "JwServiceDefine.h"
#import "AppDelegate.h"
#import <NSString+Hashes.h>

@interface JwServiceBase ()

@end

@implementation JwServiceBase

- (NSDictionary *)filterParam:(NSDictionary *)param {
    NSMutableDictionary *paramM = [NSMutableDictionary dictionaryWithDictionary:param];
    paramM[@"deviceId"] = [[UIDevice currentDevice].identifierForVendor UUIDString];
    paramM[@"deviceType"] = @"iOS";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    paramM[@"ver"] = appVersion;
    paramM[@"timestamp"] = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 1000)];
    return paramM;
}

- (NSDictionary *)signaturedParam:(NSDictionary *)param {
    NSString *signature = [self signature:param];
    NSMutableDictionary *paramM = [NSMutableDictionary dictionaryWithDictionary:param];
    paramM[@"signature"] = signature;
    return paramM;
}

- (NSString *)signature:(NSDictionary *)param {
    NSMutableString *toSignatureString = [NSMutableString stringWithString:@""];
    NSMutableArray *params = [NSMutableArray arrayWithCapacity:2];
    
    NSString *deviceId = param[@"deviceId"];
    NSString *timestamp = param[@"timestamp"];
    if (deviceId) {
        [params addObject:deviceId];
    }
    if (timestamp) {
        [params addObject:timestamp];
    }
    //sort arguments
    NSArray *sortedArguments = [params sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    for (NSString *item in sortedArguments) {
        [toSignatureString appendString:item];
    }
    
    return [toSignatureString sha1];
}

#pragma mark - HttpManagerDelegate

- (BOOL)httpManager:(id)hepler isSuccess:(NSDictionary *)response {
    NSDictionary *result = response[@"ret"];
    if ([result[@"status"] intValue] == kErrorCodeSuccess ) {
        return YES;
    }else {
        return NO;
    }
}

- (void)httpManager:(id)helper response:(id)response error:(NSError *)error {
    if (error && response == nil) {
        [JGProgressHelper showError:[NSString stringWithFormat:@"请求出错了 ~>_<~ \n%@", error.localizedDescription] ];
    }else if(error) {
        switch (error.code) {
            case kErrorCodeOperationTimeout:
            case kErrorCodeInvalidateSession:
                // 上次登录超过有效期，请重新登录。
                //[(id)[UIApplication sharedApplication].delegate showLoginController];
                [JGProgressHelper showError:@"上次登录超过有效期，请重新登录"];
                break;
                
            case kErrorCodeAccountDisable:
                // 用户已被停用，请联系主管。
                //[(id)[UIApplication sharedApplication].delegate showLoginController];
                [JGProgressHelper showError:@"用户已被停用，请联系主管。"];
                break;
                
            case kErrorCodeAccountLocked:
                //[(id)[UIApplication sharedApplication].delegate showLoginController];
                [JGProgressHelper showError:@"用户超过登录限制，已被锁死，请联系主管解锁。"];
                break;
            default:
                break;
        }
    }
}

#pragma mark -- GET
- (JwHttpManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [JwHttpManager sharedManager];
        _httpManager.delegate = self;
    }
    return _httpManager;
}

@end
