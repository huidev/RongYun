//
//  ServerListViewController.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "ServerListEntity.h"
@interface ServerListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak)IBOutlet PullTableView *m_tableView;

@end
