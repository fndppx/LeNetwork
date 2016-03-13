//
//  LeDateCenter.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeRequestItem.h"
#import "LeResponseItem.h"
@interface LeDateCenter : NSObject
- (LeResponseItem *)parseReturnData:(LeResponseItem *)item;
#pragma mark 统一请求事件
- (int)sendRequestWithRequestItem:(LeRequestItem *)item;
#pragma mark 向上层发送返回结果
- (void)sendSuccessResponseData:(LeResponseItem *)item;
- (void)sendFailResponseData:(LeResponseItem *)item;
@end
