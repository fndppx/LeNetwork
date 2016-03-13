//
//  LeNetworkHandler.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeNetwork.h"
#import "LeNetworkItem.h"
@interface LeNetworkHandler : NSObject
+ (LeNetworkHandler *)sharedInstance;
/**
 *  items
 */
@property(nonatomic,strong)NSMutableArray *items;

/**
 *   单个网络请求项
 */
@property(nonatomic,strong)LeNetworkItem *netWorkItem;
/**
 *  networkError
 */
@property(nonatomic,assign)BOOL networkError;

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */
- (LeNetworkItem*)conURL:(NSString *)url
                networkType:(LeAsiNetWorkType)networkType
                     params:(NSMutableDictionary *)params
                   delegate:(id)delegate
                     target:(id)target
              successAction:(SEL)successAction
               failedAction:(SEL)failedAction
               successBlock:(LeAsiSuccessBlock)successBlock
            failureBlock:(LeAsiFailureBlock)failureBlock;
//{
//    if (self.networkError == YES) {
//        SHOW_ALERT(@"网络连接断开,请检查网络!");
//        return nil;
//    }
//    /// 如果有一些公共处理，可以写在这里
//    NSUInteger hashValue = [delegate hash];
//    self.netWorkItem = [[KYAsiNetworkItem alloc]initWithtype:networkType url:url params:params delegate:delegate target:target successAction:successAction failedAction:failedAction  hashValue:hashValue showHUD:showHUD successBlock:successBlock failureBlock:failureBlock];
//    self.netWorkItem.delegate = self;
//    [self.items addObject:self.netWorkItem];
//    return self.netWorkItem;
//}
@end
