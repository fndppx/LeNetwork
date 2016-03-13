//
//  LeNetworkHandler.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeNetworkHandler.h"

@implementation LeNetworkHandler


+ (LeNetworkHandler *)sharedInstance
{
    static LeNetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[LeNetworkHandler alloc] init];
    });
    
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkError = NO;
    }
    return self;
}
- (LeNetworkItem*)conURL:(NSString *)url
             networkType:(LeAsiNetWorkType)networkType
                  params:(NSMutableDictionary *)params
                delegate:(id)delegate
                  target:(id)target
           successAction:(SEL)successAction
            failedAction:(SEL)failedAction
            successBlock:(LeAsiSuccessBlock)successBlock
            failureBlock:(LeAsiFailureBlock)failureBlock;
{
    if (self.networkError == YES) {
//        SHOW_ALERT(@"网络连接断开,请检查网络!");
        return nil;
    }
    /// 如果有一些公共处理，可以写在这里
    NSUInteger hashValue = [delegate hash];
    self.netWorkItem = [[LeNetworkItem alloc]initWithtype:networkType url:url params:params delegate:nil target:target successAction:successAction failedAction:failedAction  hashValue:nil  successBlock:successBlock failureBlock:failureBlock];
    self.netWorkItem.delegate = self;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}

/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems
{
    LeNetworkHandler *handler = [LeNetworkHandler sharedInstance];
    [handler.items removeAllObjects];
    handler.netWorkItem = nil;
}

- (void)netWorkWillDealloc:(LeNetworkItem *)itme
{
    
    [self.items removeObject:itme];
    self.netWorkItem = nil;
    
    NSLog(@"-----%@",self.items);
    
}
@end
