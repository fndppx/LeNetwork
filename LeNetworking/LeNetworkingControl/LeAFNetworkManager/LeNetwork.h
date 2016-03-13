//
//  LeNetwork.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#ifndef LeNetwork_h
#define LeNetwork_h
#ifdef DEBUG
#   define DTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DTLog(...)
#endif

#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];
#import "LeNetworkDefine.h"
#import "LeNetworkHandler.h"
#import "LeNetworkManager.h"
//#import "KYAsiNetworkUrl.h"
#endif /* LeNetwork_h */
