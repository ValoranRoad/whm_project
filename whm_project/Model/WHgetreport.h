//
//  WHgetreport.h
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHrela.h"
#import "WHpros.h"
#import "WHtotalrate.h"
#import "WHscore.h"
#import "WHcov.h"

@protocol  WHgetreport <NSObject>

@end

@interface WHgetreport : JwModelBase
@property(nonatomic,strong)NSArray <WHrela,Optional> * rela;

@property(nonatomic,strong)WHtotalrate<Optional>* total_rate;

@property(nonatomic,strong)NSArray <WHpros,Optional> * pros;

@property(nonatomic,strong)WHscore <Optional>* score;

@property(nonatomic,strong)WHcov <Optional>* cov;


@end
