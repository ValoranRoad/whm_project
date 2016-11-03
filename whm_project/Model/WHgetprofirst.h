//
//  WHgetprofirst.h
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHgetprofirst  <NSObject>
@end
@interface WHgetprofirst : JwModelBase
@property(nonatomic,strong)NSArray <WHgetprofirst ,Optional>* period;

@property(nonatomic,strong)NSArray <WHgetprofirst ,Optional>* pay_period;

@property(nonatomic,strong)NSArray <WHgetprofirst ,Optional>* rela;




@end
