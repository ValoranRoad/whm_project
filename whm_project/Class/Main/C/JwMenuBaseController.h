//
//  JwMenuBaseController.h
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwDataService.h"

typedef void(^MenuBaseAction)(void);

@interface JwMenuBaseController : UIViewController

@property (nonatomic, copy) MenuBaseAction menuBaseAction;

@property (nonatomic, strong) JwDataService *managerService;

@end
