//
//  ZDQ_ViewController.m
//  导航渐变DEMO
//
//  Created by yb on 16/1/19.
//  Copyright © 2016年 yb. All rights reserved.
//

#import "ZDQ_ViewController.h"
#import "ZDQ_TableViewHeader.h"
#import "ZDQ_NavigationBar.h"
@interface ZDQ_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet ZDQ_TableViewHeader *tableHeader;

/** <#label#> */
@property(nonatomic,strong) ZDQ_TableViewHeaderManager * manager;

@end

@implementation ZDQ_ViewController

-(void)awakeFromNib
{
  
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我是导航栏";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setNavbarBackgroundHidden:YES];
    
    
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.backgroundColor = [UIColor yellowColor];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;

    
    ZDQ_TableViewHeaderManager * manager = [[ZDQ_TableViewHeaderManager alloc] init];
    [manager creatTableHeaderManager:self.tableView];
    
    self.manager = manager;
}
-(void)setNavbarBackgroundHidden:(BOOL)hidden
{
    ZDQ_NavigationBar *navBar =(ZDQ_NavigationBar*)self.navigationController.navigationBar;
    if (!hidden) {
        [navBar show];
        //        navBar.
    }else{
        [navBar hidden];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%lf",scrollView.contentOffset.y);
    [self.manager scrollViewDidScroll:scrollView];
    if (scrollView.contentOffset.y<64) {
        [self setNavbarBackgroundHidden:YES];
    }else
    {
        [self setNavbarBackgroundHidden:NO];
    }
    
}
//-(void)viewDidLayoutSubviews
//{
//    [_headView resizeView];
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

@end
