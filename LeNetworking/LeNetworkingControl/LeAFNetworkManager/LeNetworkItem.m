//
//  LeNetworkItem.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeNetworkItem.h"
#import "AFNetworking.h"
#import "LeNetwork.h"
@implementation LeNetworkItem
#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return MHAsiNetworkItem对象
 */
- (LeNetworkItem *)initWithtype:(LeAsiNetWorkType)networkType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                       delegate:(id)delegate
                         target:(id)target
                  successAction:(SEL)successAction
                   failedAction:(SEL)failedAction
                      hashValue:(NSUInteger)hashValue
                   successBlock:(LeAsiSuccessBlock)successBlock
                   failureBlock:(LeAsiFailureBlock)failureBlock;
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
//        self.delegate       = delegate;
        self.tagrget        = target;
        self.successSelect         = successAction;
        self.failedSelect         = failedAction;
        
       
        __weak typeof(self)weakSelf = self;
        DTLog(@"--请求url地址--%@\n",url);
        DTLog(@"----请求参数%@\n",params);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
        //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        //    NSMutableDictionary * httpHeader = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
        
//        NSDictionary * headerDictionary = [[KYNetworkConfiguration shardConfiguration] requestHeader];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
//        for (NSString * dicNSString  in [headerDictionary allKeys]) {
//            [manager.requestSerializer setValue:[headerDictionary objectForKey:dicNSString] forHTTPHeaderField:dicNSString];
//        }
        
        if (networkType==LeAsiNetWorkGET)
        {
            [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //                [MBProgressHUD dissmiss];
                int code = 0;
                NSString *msg = nil;
                if (responseObject) {
                    NSString *success   = responseObject[@"success"];
                    code                = success.intValue;
                    msg                 = responseObject[@"msg"];
                }
                DTLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject,code,msg);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //                [MBProgressHUD dissmiss];
                DTLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(failedRequest:didFaild:) withObject:nil withObject:error];
                
                [weakSelf removewItem];
            }];
        }else if (networkType==LeAsiNetWorkPOST){
            
            [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //                [MBProgressHUD dissmiss];
                int code = 0;
                NSString *msg = nil;
                if (responseObject) {
                    NSString *success   = responseObject[@"success"];
                    code                = success.intValue;
                    msg                 = responseObject[@"msg"];
                }
                DTLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject,code,msg);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestdidFailWithError:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 //                 [MBProgressHUD dissmiss];
                 DTLog(@"---error==%@\n",error.localizedDescription);
                 if (failureBlock) {
                     failureBlock(error);
                 }
                 if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                     [weakSelf.delegate requestdidFailWithError:error];
                 }
                 [weakSelf performSelector:@selector(failedRequest: didFaild:) withObject:nil withObject:error];
                 [weakSelf removewItem];
             }];
        }
    }
    return self;
}

/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.successSelect]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (void)failedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.failedSelect]) {
        [self.tagrget performSelector:@selector(failedRequest:didFaild:) withObject:data withObject:error];
    }
    
}

- (void)dealloc
{
    static int i = 0;
    
    NSLog(@"----%d",i);
    DTLog(@"网络请求项被移除了");
    
    i++;
}
@end
