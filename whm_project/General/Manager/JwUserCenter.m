//
//  JwUserCenter.m
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwUserCenter.h"

#define kKeyMobileUser @"MobileUser"

@implementation JwUserCenter

+ (instancetype)sharedCenter {
    static JwUserCenter *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self load];
        if (nil == shared) {
            shared = [JwUserCenter new];
        }
    });
    return shared;
}

+ (instancetype)load {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyMobileUser];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        return nil;
    }
}

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kKeyMobileUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - NSCoding

#define kKeyUser @"user"
#define kKeyIsLogined @"isLogined"

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSData *userData = [self.mobileUser toJSONData];
    [aCoder encodeObject:userData forKey:kKeyUser];
    
    [aCoder encodeBool:self.isLogined forKey:kKeyIsLogined];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self.isLogined = [aDecoder decodeBoolForKey:kKeyIsLogined];
    
    NSData *userData = [aDecoder decodeObjectForKey:kKeyUser];
    self.mobileUser = [[JwMobileUser alloc] initWithData:userData error:nil];
    return self;
}

#pragma mark - getter
- (NSString *)session {
    return self.mobileUser.session;
}


@end
