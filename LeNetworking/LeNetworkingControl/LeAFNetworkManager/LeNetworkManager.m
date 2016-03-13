//
//  LeNetworkManager.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeNetworkManager.h"
#import "LeNetworkDefine.h"
#import "LeNetworkHandler.h"
@implementation LeNetworkManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static LeNetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
/// 返回单例
+(instancetype)sharedInstance
{
    return [[super alloc] init];
}

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
              failureSel:(SEL)failureSel


{

    [self getRequstWithURL:url params:params target:target successSel:successSel failureSel:failureSel delegate:self successBlock:nil failureBlock:nil];
}
/**
 *   GET请求的公共方法 一下三种方法都调用这个方法 根据传入的不同参数觉得回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
              successSel:(SEL)successSel
              failureSel:(SEL)failureSel
                delegate:(id)delegate
            successBlock:(LeAsiSuccessBlock)successBlock
            failureBlock:(LeAsiFailureBlock)failureBlock
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[LeNetworkHandler sharedInstance]conURL:url networkType:LeAsiNetWorkGET params:mutableDict delegate:nil target:target successAction:successSel failedAction:failureSel successBlock:nil failureBlock:nil];
}

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
                   showHUD:(BOOL)showHUD
{
    [self postReqeustWithURL:url params:params target:target successAction:successAction failedAction:failedAction delegate:nil successBlock:nil failureBlock:nil showHUD:showHUD];
}

#pragma mark - POST请求的三种回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
             successAction:(SEL)successAction
              failedAction:(SEL)failedAction
                  delegate:(id<LeNetworkDelegate>)delegate
              successBlock:(LeAsiSuccessBlock)successBlock
              failureBlock:(LeAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];

    [[LeNetworkHandler sharedInstance]conURL:url networkType:LeAsiNetWorkGET params:mutableDict delegate:delegate target:target successAction:successAction failedAction:failedAction successBlock:successBlock failureBlock:failureBlock];

}
@end
