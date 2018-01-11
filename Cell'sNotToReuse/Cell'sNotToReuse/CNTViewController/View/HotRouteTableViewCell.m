//
//  HotRouteTableViewCell.m
//  CulturalTourism
//
//  Created by fangd@silviscene.com on 2017/4/28.
//  Copyright © 2017年 hj. All rights reserved.
//

#import "HotRouteTableViewCell.h"
#import "HotRouteAndClassicsModel.h"
@implementation HotRouteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setEachRoute:(NSMutableArray *)EachRoute
{
    if (_EachRoute != EachRoute) {
        _EachRoute = EachRoute;
        [self setupEachRouteCellWithEachRoute:EachRoute];
    }
}
- (void)setupEachRouteCellWithEachRoute:(NSMutableArray *)EachRoute
{
    CGFloat heightCount = 0.0;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (NSInteger i = 0; i < EachRoute.count; i++) {
        if (i != 0) {
            heightCount = heightCount+[EachRoute[i-1] heightCount];
        }
        [self eachDayRouteViewWithDay:i+1 withRoute:EachRoute[i] withBeforeDayHeight:heightCount*44];
    }
}
- (void)eachDayRouteViewWithDay:(NSInteger)day withRoute:(EachRouteModel *)route withBeforeDayHeight:(NSInteger)beforeHeight
{
    UIView *bgView = [[UIView alloc]init];
    [self.contentView addSubview:bgView];
    
    UILabel *dayLabel = [[UILabel alloc]init];
    dayLabel.text = [NSString stringWithFormat:@"第 %ld 天:",day];
    dayLabel.textColor = kColorWithHex(0x0090dc);
    [bgView addSubview:dayLabel];
    
    UILabel *routeLabel = [[UILabel alloc]init];
    routeLabel.text = route.DESTID;
    routeLabel.font = [UIFont systemFontOfSize:16];
    if (route.heightCount>1) {
        [self changeLineSpaceForLabel:routeLabel WithSpace:20];
    }
    
    routeLabel.numberOfLines = 0;
    //    routeLabel.tintColor = kColorWithHex(0xeba319);
    [bgView addSubview:routeLabel];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.top.mas_equalTo(self.contentView.mas_top).offset(beforeHeight);
        make.height.mas_equalTo(@(route.heightCount*44));
    }];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(8+8);
        make.top.mas_equalTo(self.contentView.mas_top).offset(beforeHeight+2);
        make.width.mas_equalTo(@(60));
        make.height.mas_equalTo(@(40));
    }];
    [routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
        make.top.mas_equalTo(self.contentView.mas_top).offset(beforeHeight+2);
        make.left.mas_equalTo(dayLabel.mas_right).offset(2);
        make.height.mas_equalTo(@(route.heightCount*40));
    }];
}
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(CGFloat)space
{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
