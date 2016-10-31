//
//  WHgetmessageDetall.h
//  whm_project
//
//  Created by 王义国 on 16/10/31.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
//@protocol WHgetmessageDetall<NSObject>
//@end

@interface WHgetmessageDetall : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * req_uid;
@property(nonatomic,strong)NSString * res_uid;
@property(nonatomic,strong)NSString * message_id;
@property(nonatomic,strong)NSString<Optional> * read;
@property(nonatomic,strong)NSString * replay_status;
@property(nonatomic,strong)NSString * create_time;
@property(nonatomic,strong)NSString<Optional> *ip;
@property(nonatomic,strong)NSString * city_name;
@property(nonatomic,strong)NSString * req_name;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,assign)NSArray <Optional>*reply ;

@end
