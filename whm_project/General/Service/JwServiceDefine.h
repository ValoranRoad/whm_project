//
//  JwServiceDefine.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#ifndef JwServiceDefine_h
#define JwServiceDefine_h

typedef enum : NSUInteger {
    kErrorCodeSuccess = 0,
    kErrorCodeFail,
    kErrorCodeInvalidateParam,
    
    kErrorCodeNeedFirstTimeLogin = 201,
    
    kErrorCodeInvalidateSignature      = -101,
    kErrorCodeInvalidateSession        = -102,
    kErrorCodeWrongUserOrPassword      = -103,
    kErrorCodeAccountLocked            = -104,
    kErrorCodeAccountDisable           = -105,
    kErrorCodeNoPermission             = -106,
    kErrorCodeInvalidId                = -107,
    kErrorCodeInvalidToken             = -108,
    kErrorCodeWrongCurrentPassword     = -109,
    kErrorCodeDuplicateEmail           = -110,
    kErrorCodePayCodeFail              = -111,
    kErrorCodeDuplicateMobile          = -112,
    kErrorCodeAlreadyAuthorizedAccount = -113,
    kErrorCodeOperationTimeout         = -116,
    
} ErrorCode;


//测试环境访问的接口根路径是 http://ebank.allinpalm.cn/v3，正式环境待定
//#define kServiceBaseURL @"http://ebank.allinpalm.cn/v3/"
#define kServiceBaseURL @"http://ebank.allinpalm.cn/v2/mobileApi"

#endif /* JwServiceDefine_h */
