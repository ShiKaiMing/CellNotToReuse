//
//  HotRouteAndClassicsModel.m
//  CulturalTourism
//
//  Created by fangd@silviscene.com on 2017/4/19.
//  Copyright © 2017年 hj. All rights reserved.
//

#import "HotRouteAndClassicsModel.h"
@interface HotRouteAndClassicsModel()
@end
@class HotRouteModel;
@class ClassicsModel;
@implementation HotRouteAndClassicsModel


+(void)dealForHotRouteWithDay:(NSString *)day WithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock
{
    //热门
    __block HotRouteAndClassicsModel * hotRouteAndClassicsModel = [[HotRouteAndClassicsModel alloc]init];
    NSDictionary *dic = [hotRouteAndClassicsModel dictionaryForDay:day];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    HotRouteModel *model = [[HotRouteModel alloc]init];
    NSMutableArray *dataArray = [DataModelManager dataDealWithResponseObject:jsonData dataType:SkyDataTypeDictionary modelName:NSStringFromClass([model class]) modelKey:@"RouteList"];
    sucessBlock(dataArray);

}
- (NSDictionary *)dictionaryForDay:(NSString *)day
{
    if ([day isEqualToString:@"1"]) {
        NSDictionary *dic = @{@"RouteList":@[
                                      @{@"NAME":@"龙岩1日望路行程",@"EachRoute":@[@{@"DESTID":@"永定客家土楼（龙岩）-李氏大宗祠（龙岩）"}]},
                                      @{@"NAME":@"福州1日望路行程",@"EachRoute":@[@{@"DESTID":@"马尾船政文化景区（福州）-十八重溪（福州）"}]},
                                      @{@"NAME":@"厦门1日望路行程",@"EachRoute":@[@{@"DESTID":@"南普陀寺大雄宝殿（厦门）-胡里山炮台（厦门）"}]},
                                      @{@"NAME":@"福州1日望路行程",@"EachRoute":@[@{@"DESTID":@"上下杭商号建筑群（福州）-古田会馆（福州）-鼓岭（福州）-马尾船政文化景区（福州）"}]}
                                      ]};
        return dic;
    }
    if ([day isEqualToString:@"2"]) {
        NSDictionary *dic = @{@"RouteList":@[
                                      @{@"NAME":@"龙岩2日望路行程",@"EachRoute":@[@{@"DESTID":@"古田旅游（龙岩）"},@{@"DESTID":@"永定客家土楼（龙岩）"}]},
                                      @{@"NAME":@"厦门2日望路行程",@"EachRoute":@[@{@"DESTID":@"灌口凤山祖庙（厦门）"},@{@"DESTID":@"鼓浪屿（厦门）"}]},
                                      @{@"NAME":@"福州2日望路行程",@"EachRoute":@[@{@"DESTID":@"上下杭商号建筑群（福州）-涌泉寺（福州）-鼓岭（福州）"},@{@"DESTID":@"马尾船政文化景区（福州）"}]},
                                      @{@"NAME":@"福州2日望路行程",@"EachRoute":@[@{@"DESTID":@"鼓岭（福州）-涌泉寺（福州）-马尾船政文化景区（福州）"},@{@"DESTID":@"三坊七巷（福州）"}]}
                                      ]};

        return dic;
    }
    if ([day isEqualToString:@"3"]) {
        NSDictionary *dic = @{@"RouteList":@[
                                      @{@"NAME":@"福州-南平-景德镇-嘉兴3日望路行程",@"EachRoute":@[@{@"DESTID":@"永定客家土楼（龙岩）-李氏大宗祠（龙岩）"},@{@"DESTID":@"武夷山景区（南平）"},@{@"DESTID":@"古陶瓷博览区（景德镇）-南湖（嘉兴）"}]}
                                      ]};
        return dic;
    }
    return nil;
}
+(void)dealForClassicscWithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock
{
    //经典
    NSDictionary *dic = @{@"RouteList":@[
                                  @{@"NEWNAME":@"世遗探秘之旅",@"EachRoute":@[@{@"DESTID":@"三坊七巷（福州）"},@{@"DESTID":@"太姥山（宁德）-白水洋·鸳鸯溪（宁德）-白云山（宁德）"},@{@"DESTID":@"武夷山景区（南平）-下梅村（南平）"},@{@"DESTID":@"泰宁世界地质公园（三明）"},@{@"DESTID":@"永定客家土楼（龙岩）"},@{@"DESTID":@"南靖土楼（漳州）-云水谣古镇（漳州）-福建土楼（华安）旅游区（漳州）"},@{@"DESTID":@"鼓浪屿（厦门）"}]},
                                  @{@"NEWNAME":@"温馨厦门之旅",@"EachRoute":@[@{@"DESTID":@"鼓浪屿（厦门）-厦门大学（厦门）-南普陀寺大雄宝殿（厦门）"},@{@"DESTID":@"园林植物园（厦门）"},@{@"DESTID":@"胡里山炮台（厦门）"},@{@"DESTID":@"日月谷温泉主题公园（厦门）-陈嘉庚纪念胜地（厦门）"},@{@"DESTID":@"方特梦幻王国（厦门）"},@{@"DESTID":@"英雄三岛战地观光园（厦门）-大嶝小镇（厦门）"}]},
                                  @{@"NEWNAME":@"宗教朝觐之旅",@"EachRoute":@[@{@"DESTID":@"涌泉寺（福州）-开元寺铁佛（福州）"},@{@"DESTID":@"三平风景区（漳州）-白礁慈济宫（漳州）-关帝庙（漳州）"},@{@"DESTID":@"南普陀寺大雄宝殿（厦门）"},@{@"DESTID":@"开元寺（泉州）-伊斯兰教圣墓（泉州）-清源山（泉州）-泉州天后宫（泉州）"},@{@"DESTID":@"方湄洲岛（莆田）"}]},
                                  @{@"NEWNAME":@"红色经典之旅",@"EachRoute":@[@{@"DESTID":@"田会议会址（龙岩）-才溪乡调查纪念馆（龙岩）-临江楼（龙岩）"},@{@"DESTID":@"金砂红色旧址群（龙岩）"},@{@"DESTID":@"中复村（龙岩）-长汀红色旧址群旅游区（龙岩）-闽西革命历史博物馆（龙岩）"},@{@"DESTID":@"武平文博园（龙岩）"},@{@"DESTID":@"红一方面军领导机关旧址（三明）-诒燕第（三明）"},@{@"DESTID":@"红色首府旧址（南平）"}]},
                                  @{@"NEWNAME":@"世遗探秘之旅",@"EachRoute":@[@{@"DESTID":@"三坊七巷（福州）"},@{@"DESTID":@"太姥山（宁德）-白水洋·鸳鸯溪（宁德）-白云山（宁德）"},@{@"DESTID":@"武夷山景区（南平）-下梅村（南平）"},@{@"DESTID":@"泰宁世界地质公园（三明）"},@{@"DESTID":@"永定客家土楼（龙岩）"},@{@"DESTID":@"南靖土楼（漳州）-云水谣古镇（漳州）-福建土楼（华安）旅游区（漳州）"},@{@"DESTID":@"鼓浪屿（厦门）"}]},
                                  @{@"NEWNAME":@"温馨厦门之旅",@"EachRoute":@[@{@"DESTID":@"鼓浪屿（厦门）-厦门大学（厦门）-南普陀寺大雄宝殿（厦门）"},@{@"DESTID":@"园林植物园（厦门）"},@{@"DESTID":@"胡里山炮台（厦门）"},@{@"DESTID":@"日月谷温泉主题公园（厦门）-陈嘉庚纪念胜地（厦门）"},@{@"DESTID":@"方特梦幻王国（厦门）"},@{@"DESTID":@"英雄三岛战地观光园（厦门）-大嶝小镇（厦门）"}]},
                                  @{@"NEWNAME":@"宗教朝觐之旅",@"EachRoute":@[@{@"DESTID":@"涌泉寺（福州）-开元寺铁佛（福州）"},@{@"DESTID":@"三平风景区（漳州）-白礁慈济宫（漳州）-关帝庙（漳州）"},@{@"DESTID":@"南普陀寺大雄宝殿（厦门）"},@{@"DESTID":@"开元寺（泉州）-伊斯兰教圣墓（泉州）-清源山（泉州）-泉州天后宫（泉州）"},@{@"DESTID":@"方湄洲岛（莆田）"}]},
                                  @{@"NEWNAME":@"红色经典之旅",@"EachRoute":@[@{@"DESTID":@"田会议会址（龙岩）-才溪乡调查纪念馆（龙岩）-临江楼（龙岩）"},@{@"DESTID":@"金砂红色旧址群（龙岩）"},@{@"DESTID":@"中复村（龙岩）-长汀红色旧址群旅游区（龙岩）-闽西革命历史博物馆（龙岩）"},@{@"DESTID":@"武平文博园（龙岩）"},@{@"DESTID":@"红一方面军领导机关旧址（三明）-诒燕第（三明）"},@{@"DESTID":@"红色首府旧址（南平）"}]}
                                  ]};
    ClassicsModel *model = [[ClassicsModel alloc]init];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableArray *dataArray = [DataModelManager dataDealWithResponseObject:jsonData dataType:SkyDataTypeDictionary modelName:NSStringFromClass([model class]) modelKey:@"RouteList"];
    sucessBlock(dataArray);
    
}
@end

@implementation HotRouteModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"EachRoute": @"EachRouteModel"};
}
@end

@implementation ClassicsModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"EachRoute": @"EachRouteModel"};
}
@end

@implementation EachRouteModel
- (void)setDESTID:(NSString *)DESTID
{
    if (_DESTID != DESTID) {
        _DESTID = DESTID;
        [self eachRouteWithDESTID:DESTID];
    }
}
- (void)eachRouteWithDESTID:(NSString *)DESTID
{
    CGSize heightSize = CGSizeMake(WIDTH-90,MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:16.f ]};
    CGRect baseRect = [@"基准" boundingRectWithSize:heightSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect DESTIDRect = [DESTID boundingRectWithSize:heightSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGFloat heightCount = DESTIDRect.size.height/baseRect.size.height;
    self.heightCount = heightCount;
}

@end
