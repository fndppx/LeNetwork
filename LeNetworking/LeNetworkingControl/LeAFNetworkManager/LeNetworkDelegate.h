//
//  LeNetworkDelegate.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LeNetworkItem;
/**
 *   AFN 请求封装的代理协议
 */
@protocol LeNetworkDelegate <NSObject>

@optional
/**
 *   请求结束
 *
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoading:(NSDictionary*)returnData;
/**
 *   请求失败
 *
 *   @param error 失败的 error
 */
- (void)requestdidFailWithError:(NSError*)error;

- (void)netWorkWillDealloc:(LeNetworkItem*)itme;

@end
