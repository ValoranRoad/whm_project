//
//  JwUserCenter.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
//#import "JwMobileUser.h"

@interface JwUserCenter : JwModelBase<NSCoding>

//@property (nonatomic, strong) JwMobileUser *mobileUser;
@property (nonatomic, strong) NSString *session;
@property (nonatomic, assign) BOOL isLogined;


+ (instancetype)load;
+ (instancetype)sharedCenter;

- (void)save;

@end
