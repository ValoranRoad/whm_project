//
//  JwDataService.h
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
@class JwIssue;
@class JwCashier;
@class JwIssueAuthorization;
@class JwBusiness;

@interface JwDataService : JwServiceBase

- (void)issue:(NSInteger)accountId
receiverAccountNumber:(NSString *)receiverAccountNumber
         type:(NSString *)type
   billNumber:(NSString *)billNumber
      balance:(NSNumber *)balance
    issueDate:(NSString *)dateStr
      success:(void (^)(JwIssue *issue))success
      failure:(void (^)(NSError *error))failure;

- (void)deleteIssue:(NSInteger)issueId
            success:(void (^)())success
            failure:(void (^)(NSError *error))failure;

- (void)getAuthorizedAccountSuccess:(void (^)(NSArray *accounts))success
                            failure:(void (^)(NSError *error))failure;

- (void)getLiveProcessSuccess:(void (^)(NSArray *sections))success
                      failure:(void (^)(NSError *error))failure;

- (void)submitIssueWithId:(NSInteger)issueId
                issueDate:(NSString *)issueDate
                    token:(NSString *)token
                  success:(void (^)(JwIssue *issue))success
                  failure:(void (^)(NSError *error))failure;

- (void)getHistoryProcessOffset:(NSInteger)offset
                        success:(void (^)(NSArray *issueList))success
                        failure:(void (^)(NSError *error))failure;

// manager http request
- (void)mgrApproveProcessIssuseId:(NSInteger)issueId
                         approved:(BOOL)approved
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure;

- (void)mgrGetLiveProcessSuccess:(void (^)(NSArray *sections))success
                         failure:(void (^)(NSError *error))failure;

- (void)mgrGetCashierSuccess:(void (^)(NSArray *casherList))success
                     failure:(void (^)(NSError *error))failure;

- (void)mgrgetBusiness:(void (^)(JwBusiness *business))success
               failure:(void (^)(NSError *error))failure;

- (void)mgrDeleteCashier:(NSInteger)cashierId
                 success:(void (^)())success
                 failure:(void (^)(NSError *error))failure;

- (void)mgrAddCashierWithName:(NSString *)name
                        email:(NSString *)email
                       mobile:(NSString *)mobile
                      success:(void (^)(JwCashier *cashier))success
                      failure:(void (^)(NSError *error))failure;

- (void)mgrUpdateCashierWithId:(NSInteger)cashierId
                         email:(NSString *)email
                        mobile:(NSString *)mobile
                          name:(NSString *)name
                       success:(void (^)(JwCashier *cashier))success
                       failure:(void (^)(NSError *error))failure;

- (void)mgrResetCashierPassword:(NSInteger)cashierId
                        success:(void (^)())success
                        failure:(void (^)(NSError *error))failure;

- (void)mgrDisableCashier:(NSInteger)cashierId
                   enable:(BOOL)enable
                  success:(void (^)(JwCashier *cashier))success
                  failure:(void (^)(NSError *error))failure;

- (void)mgrGetAccountAuthorizationSuccess:(void (^)(NSArray *sections))success
                                  failure:(void (^)(NSError *error))failure;
- (void)mgrGetCheckSaveAuthorizationSuccess:(void (^)(NSArray *sections))success
                                    failure:(void (^)(NSError *error))failure;


- (void)mgrDeleteAuthorization:(NSInteger)authorizationId
                       success:(void (^)())success
                       failure:(void (^)(NSError *error))failure;

- (void)mgrNewIssueAuthorizationWithAccountId:(NSInteger)accountId
                                       userId:(NSInteger)userId
                                         type:(NSString *)type
                                        quota:(CGFloat)quota
                                      balance:(CGFloat)balance
                                      success:(void (^)(JwIssueAuthorization *authorization))success
                                      failure:(void (^)(NSError *error))failure;

- (void)mgrUpdateIssueAuthorizationnWithId:(NSInteger)authId
                                      type:(NSString *)type
                                     quota:(CGFloat)quota
                                   balance:(CGFloat)balance
                                   success:(void (^)(JwIssueAuthorization *authorization))success
                                   failure:(void (^)(NSError *error))failure;

- (void)mgrGetAccountsSuccess:(void (^)(NSArray *sections))success
                      failure:(void (^)(NSError *error))failure;

// issue history
- (void)generateSearchIssueHistory:(NSString *)accountID
             receiverAccountNumber:(NSString *)receiverAccountNumber
                              type:(NSString *)type
                         issueDate:(NSString *)issueDate
                        billNumber:(NSString *)billNumber
                           balance:(NSString *)balance
                            offset:(NSInteger)offset
                               max:(NSInteger)length
                           success:(void (^)(NSArray *issueLogs))success
                           failure:(void (^)(NSError *error))failure;

- (void)getAccountAuthorizationSuccess:(void (^)(NSArray *issueLogs))success
                               failure:(void (^)(NSError *error))failure;

@end
