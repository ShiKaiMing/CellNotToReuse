//
//  UseSubViewViewController.m
//  Cell'sNotToReuse
//
//  Created by fangd@silviscene.com on 2017/5/5.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "UseSubViewViewController.h"
#import "HotRouteAndClassicsModel.h"
#import "ClassicRouteTableViewCell.h"
#import "HotRouteTableViewCell.h"

@interface UseSubViewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView     *segementView;

@property (nonatomic,strong)UITableView *classicRouteTableView;
@property (nonatomic,strong)NSMutableArray *classicRouteDataArray;

@property (nonatomic,strong)UITableView *hotRouteTableView;
@property (nonatomic,strong)NSMutableArray *hotRouteDataArray;
@property(nonatomic,assign)NSInteger hotDayCount;

@end

@implementation UseSubViewViewController
static NSInteger const kHeightForFooter = 3;
static NSInteger const kHeightForHeader = 64;
static NSString * const hotRouteCell = @"hotRouteCell";
static NSString * const classicRouteCell = @"classicRouteCell";
#pragma mark ---懒加载

-(NSMutableArray *)classicRouteDataArray
{
    if (_classicRouteDataArray==nil) {
        _classicRouteDataArray = [NSMutableArray array];
    }
    return _classicRouteDataArray;
}

- (UITableView *)classicRouteTableView
{
    if (_classicRouteTableView==nil) {
        UITableView *classicRouteTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, WIDTH, HEIGHT-44-64) style:UITableViewStyleGrouped];
        classicRouteTableView.delegate = self;
        classicRouteTableView.dataSource = self;
        // 注册cell
        [classicRouteTableView registerClass:[ClassicRouteTableViewCell class] forCellReuseIdentifier:classicRouteCell];
        //
        classicRouteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _classicRouteTableView = classicRouteTableView;
    }
    return _classicRouteTableView;
}


-(NSMutableArray *)hotRouteDataArray
{
    if (_hotRouteDataArray==nil) {
        _hotRouteDataArray = [NSMutableArray array];
    }
    return _hotRouteDataArray;
}
- (UITableView *)hotRouteTableView
{
    if (_hotRouteTableView==nil) {
        UITableView *hotRouteTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, WIDTH, HEIGHT-44-64) style:UITableViewStyleGrouped];
        hotRouteTableView.delegate = self;
        hotRouteTableView.dataSource = self;
        // 注册cell
        [hotRouteTableView registerClass:[HotRouteTableViewCell class] forCellReuseIdentifier:hotRouteCell];
        //
        hotRouteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _hotRouteTableView = hotRouteTableView;
    }
    return _hotRouteTableView;
}

#pragma mark-----视图即将消失和出现
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.classicRouteTableView];
    [self.view addSubview:self.hotRouteTableView];
    [self createBack];
    [self createCustomHeaderView];
    [self loadTableViewBySelectedSegmentIndex:0];
    // Do any additional setup after loading the view.
}

#pragma mark-----创建返回
-(void)createBack
{
    UISegmentedControl *segaMnetControl = [[UISegmentedControl alloc]initWithItems:@[@"返回"]];
    segaMnetControl.frame = CGRectMake((WIDTH-200)/2, 26,200,32);
    segaMnetControl.tintColor = kRGBColor(16,123,214);
    [segaMnetControl addTarget:self action:@selector(SegmentControlChange11:) forControlEvents:UIControlEventValueChanged];
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:kRGBColor(16,123,214)} forState:UIControlStateNormal];
    segaMnetControl.layer.borderWidth = 1;
    segaMnetControl.layer.cornerRadius = 5;
    segaMnetControl.layer.masksToBounds = YES;
    segaMnetControl.layer.borderColor = kRGBColor(16,123,214).CGColor;
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.view addSubview:segaMnetControl];
}
#pragma mark-----返回上一个界面
-(void)SegmentControlChange11:(UISegmentedControl *)seg
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-----创建导航栏下头视图
-(void)createCustomHeaderView
{
    self.segementView = [[UIView alloc]init];
    self.segementView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segementView];
    
    UISegmentedControl *segaMnetControl = [[UISegmentedControl alloc]initWithItems:@[@"经典路线",@"热门路线"]];
    segaMnetControl.frame = CGRectMake((WIDTH-200)/2, 6,200,32);
    segaMnetControl.tintColor = kRGBColor(16,123,214);
    segaMnetControl.selectedSegmentIndex = 0;
    [segaMnetControl addTarget:self action:@selector(SegmentControlChange:) forControlEvents:UIControlEventValueChanged];
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:kRGBColor(16,123,214)} forState:UIControlStateNormal];
    segaMnetControl.layer.borderWidth = 1;
    segaMnetControl.layer.cornerRadius = 5;
    segaMnetControl.layer.masksToBounds = YES;
    segaMnetControl.layer.borderColor = kRGBColor(16,123,214).CGColor;
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segementView addSubview:segaMnetControl];
    [self.segementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@44);
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(@(64));
    }];
    
    [self loadTableViewBySelectedSegmentIndex:segaMnetControl.selectedSegmentIndex];
}
#pragma mark-----选择路线类型
-(void)SegmentControlChange:(UISegmentedControl *)seg
{
    [self loadTableViewBySelectedSegmentIndex:seg.selectedSegmentIndex];
}
#pragma mark-----根据路线类型请求数据 刷新表
- (void)loadTableViewBySelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (selectedSegmentIndex == 0) {
        [self loadClassicRouteData];
    }
    if (selectedSegmentIndex == 1) {
        self.hotRouteTableView.tableHeaderView = [self creatHotRouteHeaderView];
        [self loadHotRouteDataWithDay:@"1"];
    }
}
#pragma mark --- 经典路线数据处理
- (void)loadClassicRouteData
{
    //经典
    WS(weakSelf);
    [HotRouteAndClassicsModel dealForClassicscWithSucess:^(NSMutableDictionary *dataDictionary) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:dataDictionary[@"ClassicsModel"]];
        
        [weakSelf.classicRouteDataArray removeAllObjects];
        [weakSelf.classicRouteDataArray addObjectsFromArray:array];
        
        [weakSelf.view bringSubviewToFront:weakSelf.classicRouteTableView];
        [weakSelf.classicRouteTableView reloadData];
        
        
    } FailureBlock:^(NSError *error) {
        SLog(@"%@",error);
    }];
}
#pragma mark --- 热门路线数据处理
- (void)loadHotRouteDataWithDay:(NSString *)day
{
    //热门
    WS(weakSelf);
    [HotRouteAndClassicsModel dealForHotRouteWithDay:day WithSucess:^(NSMutableDictionary *dataDictionary) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:dataDictionary[@"HotRouteModel"]];
        
        [weakSelf.hotRouteDataArray removeAllObjects];
        [weakSelf.hotRouteDataArray addObjectsFromArray:array];
        weakSelf.hotDayCount = [day integerValue];
        [weakSelf.view bringSubviewToFront:weakSelf.hotRouteTableView];
        [weakSelf.hotRouteTableView reloadData];
        
    } FailureBlock:^(NSError *error) {
        SLog(@"%@",error);
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == self.classicRouteTableView) {
        return self.classicRouteDataArray.count;
    }
    if (tableView == self.hotRouteTableView) {
        return self.hotRouteDataArray.count;
    }
    return 0;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.classicRouteTableView) {
        ClassicsModel *classicsModel = [self.classicRouteDataArray objectAtIndex:section];
        if ([classicsModel isShow]) {
            return  1;
        }else{
            return  0;
        }
    }
    if (tableView == self.hotRouteTableView) {
        return 1;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.classicRouteTableView) {
        NSArray *EachRoutes = [self.classicRouteDataArray[indexPath.section] EachRoute];
        CGFloat heightCount = 0.0;
        for (EachRouteModel *eachRoute in EachRoutes) {
            heightCount = heightCount + eachRoute.heightCount;
        }
        return 44*heightCount;
    }
    if (tableView == self.hotRouteTableView) {
        NSArray *EachRoutes = [self.hotRouteDataArray[indexPath.section] EachRoute];
        CGFloat heightCount = 0.0;
        for (EachRouteModel *eachRoute in EachRoutes) {
            heightCount = heightCount + eachRoute.heightCount;
        }
        return 44*heightCount;
    }
    return 0;
}
//解决方案3:只要最后一个显示的cell内容不为空，将其子视图删除，成为一个空白的cell，再进行自定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.classicRouteTableView) {
        // 通过唯一标识符classicRouteCell创建cell实例
        ClassicRouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classicRouteCell forIndexPath:indexPath];
        //当cell存在且最后一个存在时 将最后的一个cell删除其子视图，成为一个空白的cell，再进行自定义cell
        //这里是使用while语句 或if语句
        if (cell) {
            while ([cell.contentView.subviews lastObject] != nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.classicRouteDataArray.count != 0) {
            NSMutableArray *EachRoute =[NSMutableArray arrayWithArray:[self.classicRouteDataArray[indexPath.section] EachRoute]];
            cell.EachRoute = EachRoute;
        }
        return cell;
    }
    
    if (tableView == self.hotRouteTableView) {
        // 通过唯一标识符hotRouteCell创建cell实例
        HotRouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotRouteCell forIndexPath:indexPath];
        //当cell存在且最后一个存在时 将最后的一个cell删除其子视图，成为一个空白的cell，再进行自定义cell
        //这里是使用while语句 或if语句
        if (cell) {
            if ([cell.contentView.subviews lastObject] != nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.hotRouteDataArray.count != 0) {
            NSMutableArray *EachRoute =[NSMutableArray arrayWithArray:[self.hotRouteDataArray[indexPath.section] EachRoute]];
            cell.EachRoute = EachRoute;
        }
        return cell;
    }
    return nil;
}
#pragma mark ---自定义hot的头视图
- (UIView *)creatHotRouteHeaderView
{
    UIView *segementView = [[UIView alloc]init];
    segementView.backgroundColor = [UIColor whiteColor];
    segementView.frame = CGRectMake(0, 0, WIDTH, 54);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 3)];
    lineView.backgroundColor = kRGBColor(234, 239, 240);
    [segementView addSubview:lineView];
    
    UISegmentedControl *segaMnetControl = [[UISegmentedControl alloc]initWithItems:@[@"1日游",@"2日游",@"3日游"]];
    segaMnetControl.frame = CGRectMake((WIDTH-240)/2, 8,240,32);
    segaMnetControl.selectedSegmentIndex = 0;
    [segaMnetControl addTarget:self action:@selector(HotSegmentControlChange:) forControlEvents:UIControlEventValueChanged];
    
    segaMnetControl.tintColor = [UIColor clearColor];
    segaMnetControl.selectedSegmentIndex = 0;
    segaMnetControl.layer.borderWidth = 1;
    segaMnetControl.layer.cornerRadius = 5;
    segaMnetControl.layer.masksToBounds = YES;
    segaMnetControl.layer.borderColor = [UIColor clearColor].CGColor;
    
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:kColorWithHex(0x0090dc)} forState:UIControlStateSelected];
    [segementView addSubview:segaMnetControl];
    
    UIView *lineSegementView = [[UIView alloc]initWithFrame:CGRectMake(0, 32-3, 240/3, 3)];
    lineSegementView.backgroundColor = kColorWithHex(0x0090dc);
    lineSegementView.tag = 123;
    [segaMnetControl addSubview:lineSegementView];
    
    return segementView;
}
#pragma mark ---选择几日游
-(void)HotSegmentControlChange:(UISegmentedControl *)seg
{
    UIView *lineSegementView = [seg viewWithTag:123];
    [UIView animateWithDuration:0.35 animations:^{
        lineSegementView.frame = CGRectMake(240/3*seg.selectedSegmentIndex, 32-3, 240/3, 3);
    } completion:^(BOOL finished) {
        [self loadHotRouteDataWithDay:[NSString stringWithFormat:@"%ld",seg.selectedSegmentIndex+1]];
    }];
}
#pragma mark ---自定义头标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.classicRouteTableView) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, kHeightForHeader)];
        bgView.backgroundColor = kRGBColor(237, 239, 240);
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        bgBtn.frame = CGRectMake(0, 0, WIDTH, kHeightForHeader);
        bgBtn.tag = section;
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:bgBtn];
        
        CGFloat imgWidth = 34;
        UIImageView *heardVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(8, (kHeightForHeader-imgWidth)/2, imgWidth, imgWidth)];
        heardVeiw.image = [UIImage imageNamed:@"location_red.png"];
        [bgView addSubview:heardVeiw];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+8, 0, WIDTH-imgWidth-16, kHeightForHeader)];
        titleLable.text = [self.classicRouteDataArray[section] NEWNAME];
        [bgView addSubview:titleLable];
        
        return bgView;
        
    }
    if (tableView == self.hotRouteTableView) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, kHeightForHeader)];
        bgView.backgroundColor = [UIColor whiteColor];
        CGFloat imgWidth = 25;
        UIImageView *heardVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(8, (kHeightForHeader-imgWidth)/2, imgWidth, imgWidth*4/3)];
        heardVeiw.image = [UIImage imageNamed:[NSString stringWithFormat:@"num_%ld.png",section+1]];
        [bgView addSubview:heardVeiw];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(imgWidth+8+8, 0, WIDTH-imgWidth-16-8, kHeightForHeader)];
        titleLable.text = [self.hotRouteDataArray[section] NAME];
        [bgView addSubview:titleLable];
        
        return bgView;
    }
    
    return nil;
}
#pragma mark ---展开和闭合
- (void)bgBtnClick:(UIButton *)btn
{
    ClassicsModel *data = self.classicRouteDataArray[btn.tag];
    // 改变组的显示状态
    if ([data isShow]) {
        [data setIsShow:NO];
    }else{
        [data setIsShow:YES];
    }
    // 刷新点击的组标题，动画使用卡片
    [self.classicRouteTableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.classicRouteTableView) {
        return kHeightForHeader;
    }
    if (tableView == self.hotRouteTableView) {
        return kHeightForHeader;
    }
    return 0;
}
#pragma mark ---尾部的灰线
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == self.classicRouteTableView) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, kHeightForFooter)];
        lineView.backgroundColor = [UIColor whiteColor];
        return lineView;
    }
    if (tableView == self.hotRouteTableView) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, kHeightForFooter)];
        lineView.backgroundColor = kRGBColor(237, 239, 240);
        return lineView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.classicRouteTableView) {
        return kHeightForFooter;
    }
    if (tableView == self.hotRouteTableView) {
        return kHeightForFooter;
    }
    return 0;
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.classicRouteTableView) {
        if (self.classicRouteDataArray.count != 0) {
            
        }
    }
    if (tableView == self.hotRouteTableView) {
        if (self.hotRouteDataArray.count != 0) {
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
