//
//  WHmicro.h
//  whm_project
//
//  Created by 王义国 on 16/11/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHmicro <NSObject>
@end

@interface WHmicro : JwModelBase
@property(nonatomic,strong) NSArray <WHmicro,Optional> * agent_info;
@property(nonatomic,strong) NSDictionary <WHmicro,Optional> * count;
@property(nonatomic,strong) NSArray <WHmicro,Optional> * honor;
@property(nonatomic,strong) NSArray <WHmicro,Optional> * pro;
@property(nonatomic,strong) NSArray <WHmicro,Optional> * message;



@end
