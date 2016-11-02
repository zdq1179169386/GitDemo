//
//  ZDQ_NavigationController.m
//  导航渐变DEMO
//
//  Created by yb on 16/1/18.
//  Copyright © 2016年 yb. All rights reserved.
//

#import "ZDQ_NavigationController.h"
#import "ZDQ_NavigationBar.h"
@interface ZDQ_NavigationController ()


@end

@implementation ZDQ_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    ZDQ_NavigationBar * bar = [[ZDQ_NavigationBar alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44)];
    [self setValue:bar forKey:@"navigationBar"];
    
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
