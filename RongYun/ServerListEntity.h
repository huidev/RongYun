//
//  ServerListEntity.h
//  RongYun
//
//  Created by 乐米科技 on 5/9/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseEntity.h"

@interface ServerListEntity : BaseEntity

@property (nonatomic, strong)NSNumber* recordId;
@property (nonatomic, strong)NSNumber* s_id;
@property (nonatomic, strong)NSNumber* u_id;
@property (nonatomic, strong)NSString* s_ico;
@property (nonatomic, strong)NSDictionary *s_info;

@end
