//
//  LeNetworkManager.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeNetworkManager : NSObject
+(instancetype)sharedInstance;
/**
 *   get 请求通过 taget 回调方法
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param action      action
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
              successSel:(SEL)successSel
              failureSel:(SEL)failureSel;
/**
 *   post 请求通过 target 回调结果
 *
 *   @param url         url
 *   @param paramsDict  请求参数的字典
 *   @param target      target
 *   @param showHUD     是否显示圈圈
 */



+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
             successAction:(SEL)successAction
              failedAction:(SEL)failedAction
                   showHUD:(BOOL)showHUD;
    
@end
