//
//  BBSViewController.m
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSListCell.h"
static NSString *CELLIdentifcation = @"BBSListCell";
@implementation BBSViewController

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
}

#pragma mark -private method
- (void)allocData;
{
    [super allocData];
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
}
- (void)configSubviews;
{
    [super configSubviews];
    //    [self.m_tableView registerNib:[ServerListCell serverListCellNib] forCellReuseIdentifier:SERVER_CELL];
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
    BBSListCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIdentifcation];
    if (!cell) {
        cell = [[BBSListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLIdentifcation];
        
    }
    BBSEntity *entity = [[BBSEntity alloc]init];
    cell.bbsModel = entity;
    return cell;
}
#pragma mark -uitableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
