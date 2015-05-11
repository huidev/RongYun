//
//  APIConfig.h
//  ZLYDoc
//  API信息
//  Created by Ryan on 14-4-14.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

/***************SERVER HOST***************/

#define SERVER_HOST @"123.57.41.74:80"

/***************SERVER API***************/
//登录
#define URL_USER_LOGIN        @"/rest/user/login.json"
#define API_VERSION @""
#define URL_SERVER_LIST       @"/justHomeApi/ServiceApi"
@interface APIConfig : NSObject

@end