//
//  HotRouteAndClassicsModel.h
//  CulturalTourism
//
//  Created by fangd@silviscene.com on 2017/4/19.
//  Copyright © 2017年 hj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
typedef void (^SucessBlock) (NSMutableArray *dataArray);
typedef void (^FailureBlock) (NSError *error);
@interface HotRouteAndClassicsModel : NSObject
//请求
@property (nonatomic,strong)SucessBlock sucessBlock;
@property (nonatomic,strong)FailureBlock failureBlock;

+(void)dealForHotRouteWithDay:(NSString *)day WithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock;

+(void)dealForClassicscWithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock;

@end
//热门
@interface HotRouteModel : NSObject
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *NAME;
@property (nonatomic,strong)NSArray *EachRoute;
@end
//经典
@interface ClassicsModel : NSObject
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *NEWNAME;
@property (nonatomic,strong)NSArray *EachRoute;
@property (nonatomic,assign)BOOL isShow;
@end

//路线的公共的EachRoute
@interface EachRouteModel : NSObject
@property (nonatomic,strong)NSString *DESTID;
@property (nonatomic,assign)CGFloat heightCount;
@end
