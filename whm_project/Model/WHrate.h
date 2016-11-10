//
//  WHrate.h
//  whm_project
//
//  Created by 王义国 on 16/11/10.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHrate  <NSObject>
@end

@interface WHrate : JwModelBase
@property(nonatomic,strong)NSString <Optional> * period;
@property(nonatomic,strong)NSString <Optional> * age;
@property(nonatomic,strong)NSString <Optional> * gender;
@property(nonatomic,strong)NSMutableArray * pay_period;


@end
