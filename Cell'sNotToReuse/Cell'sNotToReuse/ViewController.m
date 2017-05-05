//
//  ViewController.m
//  Cell'sNotToReuse
//
//  Created by fangd@silviscene.com on 2017/5/5.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "UseSubViewViewController.h"
#import "UseIdentifierViewController.h"
#import "UseInitCellViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UISegmentedControl *segaMnetControl = [[UISegmentedControl alloc]initWithItems:@[@"初始化cell",@"使用标识符",@"删除子视图"]];
    segaMnetControl.frame = CGRectMake((WIDTH-280)/2, 120,280,32);
    segaMnetControl.tintColor = kRGBColor(16,123,214);
    [segaMnetControl addTarget:self action:@selector(SegmentControlChange:) forControlEvents:UIControlEventValueChanged];
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:kRGBColor(16,123,214)} forState:UIControlStateNormal];
    segaMnetControl.layer.borderWidth = 1;
    segaMnetControl.layer.cornerRadius = 5;
    segaMnetControl.layer.masksToBounds = YES;
    segaMnetControl.layer.borderColor = kRGBColor(16,123,214).CGColor;
    [segaMnetControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.view addSubview:segaMnetControl];
}

-(void)SegmentControlChange:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        UseInitCellViewController *VC = [[UseInitCellViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }
    if (seg.selectedSegmentIndex == 1) {
        UseIdentifierViewController *VC = [[UseIdentifierViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }
    if (seg.selectedSegmentIndex == 2) {
        UseSubViewViewController *VC = [[UseSubViewViewController alloc]init];
        [self presentViewController:VC animated:YES completion:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
