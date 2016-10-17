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
#import "Md5.h"

@interface JwServiceBase ()

@end

@implementation JwServiceBase

- (NSDictionary *)filterParam:(NSDictionary *)param interface:(NSString *)interface {
    //加密和数据处理
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //NSArray *inters = [interface componentsSeparatedByString:@"/"];
    NSString *kbStr = [[Md5 md5:[NSString stringWithFormat:@"kuaibao%@%@%@api", @"kb", dateStr, interface]] lowercaseString];
    
    NSMutableDictionary *paramM = [NSMutableDictionary dictionaryWithDictionary:param];
    paramM[@"kb"] = kbStr;
    return paramM;
}


#pragma mark - HttpManagerDelegate

- (BOOL)httpManager:(id)hepler isSuccess:(NSDictionary *)response {
    NSDictionary *result = response[@"err"];
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
            case kErrorCodeRequestParam:
                [JGProgressHelper showError:error.domain];
                break;
                
            case kErrorCodeBackerData:
                [JGProgressHelper showError:error.domain];
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
