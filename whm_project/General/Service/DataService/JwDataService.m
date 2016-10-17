//
//  JwDataService.m
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwDataService.h"
#import "JwIssue.h"
#import "JwBusiness.h"
#import "JwCashier.h"
#import "JwAuthorizationGroup.h"
#import "JwIssueAuthorization.h"
#import "JwUserCenter.h"


@implementation JwDataService

- (void)issue:(NSInteger)accountId
receiverAccountNumber:(NSString *)receiverAccountNumber
         type:(NSString *)type
   billNumber:(NSString *)billNumber
      balance:(NSNumber *)balance
    issueDate:(NSString *)dateStr
      success:(void (^)(JwIssue *issue))success
      failure:(void (^)(NSError *error))failure{
    
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.newIssue.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSMutableDictionary *param = [@{@"sessionKey": [JwUserCenter sharedCenter].session,
                               @"account.id": @(accountId),
                               @"type": type,
                               @"billNumber": billNumber,
                               @"balance": balance,
                               @"issueDate": dateStr, } mutableCopy];
    if (receiverAccountNumber.length > 0) {
        param[@"receiverAccountNumber"] = receiverAccountNumber;
    }
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"newIssue" success:^(id data) {
        NSDictionary *info = data[@"issue"];
        JwIssue *issue = [[JwIssue alloc] initWithDictionary:info error:nil];
        if (success) {
            success(issue);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)deleteIssue:(NSInteger)issueId
            success:(void (^)())success
            failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.deleteProcess.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(issueId)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"deleteProcess" success:^(id data) {

        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)getAuthorizedAccountSuccess:(void (^)(NSArray *accounts))success
                            failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.getAuthorizedAccount.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue"};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"getAuthorizedAccount" success:^(id data) {
        
        NSArray *infos = data[@"list"];
        NSArray *accounts = [JwAccount arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(accounts);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)getLiveProcessSuccess:(void (^)(NSArray *sections))success
                      failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.getLiveProcess.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue"};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"getLiveProcess" success:^(id data) {
        
        NSArray *approvedInfoList = data[@"approvedList"];
        NSArray *pendingInfoList = data[@"pendingList"];
        NSArray *rejectedInfoList = data[@"rejectedList"];
        
        NSArray *approveds = [JwIssue arrayOfModelsFromDictionaries:approvedInfoList];
        NSArray *pendings = [JwIssue arrayOfModelsFromDictionaries:pendingInfoList];
        NSArray *rejecteds = [JwIssue arrayOfModelsFromDictionaries:rejectedInfoList];
        
        if (success) {
            success(@[approveds, pendings, rejecteds]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)submitIssueWithId:(NSInteger)issueId
                issueDate:(NSString *)issueDate
                    token:(NSString *)token
                  success:(void (^)(JwIssue *issue))success
                  failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.submitIssue.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    if (nil == issueDate) {
        NSError *error = [NSError errorWithDomain:@"http.service.issueDate.invalidateIssueDate" code:-1 userInfo:nil];
        failure(error);
        return;
    }

    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(issueId),
                            @"issueDate": issueDate,
                            @"token": token};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"submitIssue" success:^(id data) {
        
        NSDictionary *info = data[@"issue"];
        JwIssue *issue = [[JwIssue alloc] initWithDictionary:info error:nil];
        if (success) {
            success(issue);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)getHistoryProcessOffset:(NSInteger)offset
                        success:(void (^)(NSArray *issueList))success
                        failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.getHistoryProcess.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSMutableDictionary *param = [@{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue"} mutableCopy];
    if (offset > 0) {
        param[@"offset"] = @(offset);
    }
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"getHistoryProcess" success:^(id data) {
        
        NSArray *infos = data[@"list"];
        NSArray *issues = [JwIssue arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(issues);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// manager http request
- (void)mgrApproveProcessIssuseId:(NSInteger)issueId
                         approved:(BOOL)approved
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrApproveProcess.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSString *approvedStr = @"true";
    if (!approved) {
        approvedStr = @"false";
    }
    NSMutableDictionary *param = [@{@"sessionKey": [JwUserCenter sharedCenter].session,
                                    @"id": @(issueId),
                                    @"approved": approvedStr, } mutableCopy];
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrApproveProcess" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrGetLiveProcessSuccess:(void (^)(NSArray *sections))success
                         failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrGetLiveProcess.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue", };

    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrGetLiveProcess" success:^(id data) {
        
        NSArray *approvedInfoList = data[@"approvedList"];
        NSArray *pendingInfoList = data[@"pendingList"];
        NSArray *rejectedInfoList = data[@"rejectedList"];
        
        NSArray *approveds = [JwIssue arrayOfModelsFromDictionaries:approvedInfoList];
        NSArray *pendings = [JwIssue arrayOfModelsFromDictionaries:pendingInfoList];
        NSArray *rejecteds = [JwIssue arrayOfModelsFromDictionaries:rejectedInfoList];
        
        if (success) {
            success(@[approveds, pendings, rejecteds]);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrGetCashierSuccess:(void (^)(NSArray *casherList))success
                     failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrGetCashier.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrGetCashier" success:^(id data) {
        
        NSArray *infos = data[@"list"];
        NSArray *cashiers = [JwCashier arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(cashiers);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrgetBusiness:(void (^)(JwBusiness *business))success
               failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.getBusiness.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"getBusiness" success:^(id data) {
        
        NSDictionary *info = data[@"business"];
        JwBusiness *business = [[JwBusiness alloc] initWithDictionary:info error:nil];
        if (success) {
            success(business);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrDeleteCashier:(NSInteger)cashierId
                 success:(void (^)())success
                 failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrDeleteCashier.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(cashierId)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrDeleteCashier" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)mgrAddCashierWithName:(NSString *)name
                        email:(NSString *)email
                       mobile:(NSString *)mobile
                      success:(void (^)(JwCashier *cashier))success
                      failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrAddCashier.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"name": name,
                            @"email": email,
                            @"mobile": mobile};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrAddCashier" success:^(id data) {
        
        NSDictionary *info = data[@"cashier"];
        JwCashier *cashier = [[JwCashier alloc] initWithDictionary:info error:nil];
        if (success) {
            success(cashier);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrUpdateCashierWithId:(NSInteger)cashierId
                         email:(NSString *)email
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                       success:(void (^)(JwCashier *cashier))success
                       failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrUpdateCashier.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"name": name,
                            @"email": email,
                            @"mobile": mobile,
                            @"id": @(cashierId)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrUpdateCashier" success:^(id data) {
        
        NSDictionary *info = data[@"cashier"];
        JwCashier *cashier = [[JwCashier alloc] initWithDictionary:info error:nil];
        if (success) {
            success(cashier);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrResetCashierPassword:(NSInteger)cashierId
                        success:(void (^)())success
                        failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrResetCashierPassword.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(cashierId)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrResetCashierPassword" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrDisableCashier:(NSInteger)cashierId
                   enable:(BOOL)enable
                  success:(void (^)(JwCashier *cashier))success
                  failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrDisableCashier.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    NSString *enableStr = @"true";
    if (!enable) {
        enableStr = @"false";
    }
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(cashierId),
                            @"enable": enableStr};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrDisableCashier" success:^(id data) {
        NSDictionary *info = data[@"cashier"];
        JwCashier *cashier = [[JwCashier alloc] initWithDictionary:info error:nil];
        if (success) {
            success(cashier);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

- (void)mgrGetAccountAuthorizationSuccess:(void (^)(NSArray *sections))success
                                  failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrGetAccountAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }

    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue",};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrGetAccountAuthorization" success:^(id data) {
        
        NSArray *infos = data[@"list"];
        NSArray *auths = [JwAuthorizationGroup arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(auths);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrGetCheckSaveAuthorizationSuccess:(void (^)(NSArray *sections))success
                                    failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrGetCreditLoadAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"type": @"Issue",};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrGetCreditLoadAuthorization" success:^(id data) {
        NSArray *infos = data[@"list"];
        NSArray *auths = [JwAuthorizationGroup arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(auths);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)mgrDeleteAuthorization:(NSInteger)authorizationId
                       success:(void (^)())success
                       failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrDeleteAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(authorizationId)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrDeleteAuthorization" success:^(id data) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrNewIssueAuthorizationWithAccountId:(NSInteger)accountId
                                       userId:(NSInteger)userId
                                         type:(NSString *)type
                                        quota:(CGFloat)quota
                                      balance:(CGFloat)balance
                                      success:(void (^)(JwIssueAuthorization *authorization))success
                                      failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrNewIssueAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"account.id": @(accountId),
                            @"mobileUser.id": @(userId),
                            @"type": type,
                            @"quota": @(quota),
                            @"totalQuota": @(balance)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrNewIssueAuthorization" success:^(id data) {
        NSDictionary *info = data[@"auth"];
        JwIssueAuthorization *auth = [[JwIssueAuthorization alloc] initWithDictionary:info error:nil];
        if (success) {
            success(auth);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrUpdateIssueAuthorizationnWithId:(NSInteger)authId
                                      type:(NSString *)type
                                     quota:(CGFloat)quota
                                   balance:(CGFloat)balance
                                   success:(void (^)(JwIssueAuthorization *authorization))success
                                   failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrUpdateIssueAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session,
                            @"id": @(authId),
                            @"type": type,
                            @"quota": @(quota),
                            @"totalQuota": @(balance)};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrUpdateIssueAuthorization" success:^(id data) {
        NSDictionary *info = data[@"auth"];
        JwIssueAuthorization *auth = [[JwIssueAuthorization alloc] initWithDictionary:info error:nil];
        if (success) {
            success(auth);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)mgrGetAccountsSuccess:(void (^)(NSArray *sections))success
                      failure:(void (^)(NSError *error))failure{
    
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrGetAccount.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSDictionary *param = @{@"sessionKey": [JwUserCenter sharedCenter].session};
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"mgrGetAccount" success:^(id data) {
        NSArray *infos = data[@"list"];
        NSArray *accounts = [JwAccount arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(accounts);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// issue history

- (void)searchIssueHistory:(NSString *)accountID
     receiverAccountNumber:(NSString *)receiverAccountNumber
                      type:(NSString *)type
                 issueDate:(NSString *)issueDate
                billNumber:(NSString *)billNumber
                   balance:(NSString *)balance
                    offset:(NSInteger)offset
                       max:(NSInteger)length
                   success:(void (^)(NSArray *issueLogs))success
                   failure:(void (^)(NSError *error))failure {
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.searchIssueHistory.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sessionKey"] = [JwUserCenter sharedCenter].session;
    if (accountID) {
        param[@"id"] = accountID;
    }
    if (receiverAccountNumber) {
        param[@"receiverAccountNumber"] = receiverAccountNumber;
    }
    if (type) {
        param[@"type"] = type;
    }
    if (issueDate) {
        param[@"issueDate"] = issueDate;
    }
    if (billNumber) {
        param[@"billNumber"] = billNumber;
    }
    if (balance) {
        param[@"balance"] = balance;
    }
    param[@"offset"] = @(offset);
    param[@"max"] = @(length);
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"searchIssueHistory" success:^(id data) {
        NSArray *infos = data[@"list"];
        NSArray *issues = [JwIssue arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(issues);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


- (void)mgrSearchIssueHistory:(NSString *)accountID
        receiverAccountNumber:(NSString *)receiverAccountNumber
                         type:(NSString *)type
                    issueDate:(NSString *)issueDate
                   billNumber:(NSString *)billNumber
                      balance:(NSString *)balance
                       offset:(NSInteger)offset
                          max:(NSInteger)length
                      success:(void (^)(NSArray *issueLogs))success
                      failure:(void (^)(NSError *error))failure {
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.mgrSearchIssueHistory.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"sessionKey"] = [JwUserCenter sharedCenter].session;
    if (accountID) {
        param[@"id"] = accountID;
    }
    if (receiverAccountNumber) {
        param[@"receiverAccountNumber"] = receiverAccountNumber;
    }
    if (type) {
        param[@"type"] = type;
    }
    if (issueDate) {
        param[@"issueDate"] = issueDate;
    }
    if (billNumber) {
        param[@"billNumber"] = billNumber;
    }
    if (balance) {
        param[@"balance"] = balance;
    }
    param[@"offset"] = @(offset);
    param[@"max"] = @(length);
    
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    [self.httpManager GET:param withPoint:@"mgrSearchIssueHistory" success:^(id data) {
        
        NSArray *infos = data[@"list"];
        NSArray *issues = [JwIssue arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(issues);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


- (void)generateSearchIssueHistory:(NSString *)accountID
             receiverAccountNumber:(NSString *)receiverAccountNumber
                              type:(NSString *)type
                         issueDate:(NSString *)issueDate
                        billNumber:(NSString *)billNumber
                           balance:(NSString *)balance
                            offset:(NSInteger)offset
                               max:(NSInteger)length
                           success:(void (^)(NSArray *issueLogs))success
                           failure:(void (^)(NSError *error))failure{
    if ([[JwUserCenter sharedCenter].mobileUser.type isEqualToString:@"MANAGER"]) {
        [self mgrSearchIssueHistory:accountID receiverAccountNumber:receiverAccountNumber type:type issueDate:issueDate billNumber:billNumber balance:balance offset:offset max:length success:success failure:failure];
    }else{
        [self searchIssueHistory:accountID receiverAccountNumber:receiverAccountNumber type:type issueDate:issueDate billNumber:billNumber balance:balance offset:offset max:length success:success failure:failure];
    }

}

- (void)getAccountAuthorizationSuccess:(void (^)(NSArray *issueLogs))success
                               failure:(void (^)(NSError *error))failure{
    if ([JwUserCenter sharedCenter].session == nil) {
        NSError *error = [NSError errorWithDomain:@"http.service.getAccountAuthorization.invalidateSession" code:-1 userInfo:nil];
        failure(error);
        return;
    }
    
    id param = @{@"sessionKey": [JwUserCenter sharedCenter].session};
    param = [[self filterParam:param] mutableCopy];
    param = [[self signaturedParam:param] mutableCopy];
    
    [self.httpManager GET:param withPoint:@"getAccountAuthorization" success:^(id data) {
        NSArray *infos = data[@"list"];
        NSArray *auths = [JwAuthorizationGroup arrayOfModelsFromDictionaries:infos];
        if (success) {
            success(auths);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}


@end
