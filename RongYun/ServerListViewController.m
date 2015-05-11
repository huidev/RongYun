//
//  ServerListViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ServerListViewController.h"
#import "ServerListCell.h"
static NSString *SERVER_CELL = @"serverCell";

@implementation ServerListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self allocData];
    [self configSubviews];
    [self requestData];
}

#pragma mark -private method
- (void)requestData
{
    [self requestPostWithRelativeUrl:URL_SERVER_LIST parameters:@{@"otype":@"list",@"u_id":@"1"} prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)allocData;
{
    [super allocData];
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
}
- (void)configSubviews;
{
    [super configSubviews];
    [self setLeftBarButtonItemWithText:@"服务" imageName:nil respond:nil];
    [self setRightBarButtonItemWithText:nil imageName:nil];
    //在storyboard设cell 的identity
//    [self.m_tableView registerNib:[ServerListCell serverListCellNib] forCellReuseIdentifier:SERVER_CELL];
}
- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    if (barItem ==self.navigationItem.rightBarButtonItem) {
        UITableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchListViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self.view sendSubviewToBack:self.errorView];
    [self.view bringSubviewToFront:self.m_tableView];
}
#pragma network handler

#pragma mark - uitableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ServerListCell *cell = [tableView dequeueReusableCellWithIdentifier:SERVER_CELL];
    if (!cell) {
        cell = [[ServerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SERVER_CELL];
        
    }
    ServerListEntity *entity = [[ServerListEntity alloc]init];
    cell.model = entity;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -uitableView delegate

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
