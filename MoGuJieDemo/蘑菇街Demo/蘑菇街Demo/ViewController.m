//
//  ViewController.m
//  蘑菇街Demo
//
//  Created by ZhuDeQiang on 16/7/29.
//  Copyright © 2016年 ZDQ. All rights reserved.
//

#import "ViewController.h"
#import "SectionView.h"
#import "TheMainBaseTable.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    BOOL _canScroll;
    BOOL _scrollToTop;
    BOOL _scrollToBottom;
}

@property (nonatomic,strong) TheMainBaseTable * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.title = @"商品详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotify:) name:@"TheExternalScroll" object:nil];
    
}
-(TheMainBaseTable *)tableView
{
    if (!_tableView) {
        _tableView = [[TheMainBaseTable alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:0];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[SectionView class] forCellReuseIdentifier:@"section"];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1)
    {
        return 1;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIImageView * head  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350)];
            head.image = [UIImage imageNamed:@"1.jpg"];
            [cell.contentView addSubview:head];
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"商品名称";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"商品评价";
            cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
            cell.detailTextLabel.text = @"222222";
        }
    }else if (indexPath.section == 1)
    {
        cell = (SectionView *)[tableView dequeueReusableCellWithIdentifier:@"section"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return  350;

        }else{
            return 100;
        }
    }else if (indexPath.section == 1)
    {
        return ([UIScreen mainScreen].bounds.size.height-64);
    }
    return 0;
}
-(void)acceptNotify:(NSNotification * )notify
{
    NSString * canScroll =  notify.userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
//        内嵌scroll 通知 外部scroll可以滑动了
        _canScroll = YES;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat tabOffsetY = [self.tableView rectForSection:1].origin.y;
    NSLog(@"tabOffsetY = %lf",tabOffsetY);
    CGFloat offsetY = scrollView.contentOffset.y;
    _scrollToBottom = _scrollToTop;
    if (offsetY>=tabOffsetY) {
//       刚好第二部分的顶部接触到导航条的地步了， 外部的table 固定偏移量，
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _scrollToTop = YES;
    }else
    {
        _scrollToTop = NO;
    }
    if (_scrollToTop != _scrollToBottom) {
        if (!_scrollToBottom && _scrollToTop) {
//        滑到顶部了，通知内嵌table ，可以滑动了，
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TheInsideScroll" object:nil userInfo:@{@"canScroll":@"1"}];
//            自己不能滑动了
            _canScroll = NO;
        }
        if (_scrollToBottom && !_scrollToTop) {
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
//
    }
}
@end
