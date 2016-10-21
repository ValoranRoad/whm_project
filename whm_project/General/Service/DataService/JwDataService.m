//
//  JwDataService.m
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwDataService.h"
#import "JwCompanys.h"

@implementation JwDataService

//获取公司列表
- (void)get_CompanysWithType:(NSString *)type
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"type": type} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_companys"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_companys" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *companys = [JwCompanys arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(companys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
