//
//  LeDateCenter.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeDateCenter.h"
#import "LeAFNetworkManager/LeNetworkManager.h"
@interface LeDateCenter()
@property (nonatomic, strong) LeRequestItem * requestItem;
@end

@implementation LeDateCenter
- (void)sendSuccessResponseData:(LeResponseItem *)item
{
    LeRequestItem * requestItem = item.requestItem;
    
    if (item.returnCode == kRequestSuccess)
    {
        if (requestItem.delegateTarget && requestItem.requestSuccessSEL)
        {
            if ([requestItem.delegateTarget respondsToSelector:requestItem.requestSuccessSEL])
            {
                [requestItem.delegateTarget performSelectorOnMainThread:requestItem.requestSuccessSEL
                                                             withObject:item
                                                          waitUntilDone:NO];
            }
        }
    }
    
}
- (void)sendFailResponseData:(LeResponseItem *)item
{
    LeRequestItem * requestItem = item.requestItem;
    
    if (requestItem.delegateTarget && requestItem.requestFailSEL)
    {
        if ([requestItem.delegateTarget respondsToSelector:requestItem.requestFailSEL])
        {
            [requestItem.delegateTarget performSelectorOnMainThread:requestItem.requestFailSEL
                                                         withObject:item
                                                      waitUntilDone:NO];
        }
    }
}


- (int)sendRequestWithRequestItem:(LeRequestItem *)item
{
    
    _requestItem  = item;
    
    
    if (_requestItem.paramDict && [_requestItem.paramDict allKeys].count != 0)
    {
        _requestItem.finalRequestUrl = [NSString stringWithFormat:@"%@%@",_requestItem.requestUrl,[LeDateCenter converDictToString:item.paramDict]];
    }
    else
    {
        _requestItem.finalRequestUrl = [NSString stringWithFormat:@"%@",_requestItem.requestUrl];
    }
    
    //整合拼接请求url
    NSString * urlString = nil;
    if (item.needURLEncode)
    {
        urlString = [NSString stringWithFormat:@"%@",[_requestItem.finalRequestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        urlString = [NSString stringWithFormat:@"%@",_requestItem.finalRequestUrl];
    }
    if (_requestItem.httpMethodType==HttpMethodGet) {
        
        
        [LeNetworkManager getRequstWithURL:urlString params:nil target:self successSel:@selector(finishedRequest:didFaild:) failureSel:@selector(failedRequest:didFaild:)];
    }
    else if (_requestItem.httpMethodType==HttpMethodPost)
    {
        [LeNetworkManager postReqeustWithURL:urlString params:_requestItem.paramDict target:self successAction:@selector(finishedRequest:didFaild:) failedAction:@selector(failedRequest:didFaild:) showHUD:NO];
        
    }
    
    
    return 0;
}

- (void)finishedRequest:(id)returnData didFaild:(NSError*)error
{
    NSLog(@"-----%@",returnData);
    LeResponseItem * responseItem = [[LeResponseItem alloc] init];
    responseItem.requestItem = _requestItem;
    if ([returnData isKindOfClass:[NSArray class]])
    {
        responseItem.responseDict = [NSDictionary dictionaryWithObject:returnData
                                                                forKey:@"list"];
    }
    else if ([returnData isKindOfClass:[NSDictionary class]])
    {
        responseItem.responseDict = [NSDictionary dictionaryWithDictionary:returnData];
    }
    [self networkRequestExecuteFinishedWithItem:responseItem];
    
}
- (void)failedRequest:(id)returnData didFaild:(NSError*)error
{
    NSLog(@"-----%@",returnData);
    LeResponseItem * responseItem = [[LeResponseItem alloc] init];
    responseItem.requestItem = _requestItem;
    if ([returnData isKindOfClass:[NSArray class]])
    {
        responseItem.responseDict = [NSDictionary dictionaryWithObject:returnData
                                                                forKey:@"list"];
    }
    else if ([returnData isKindOfClass:[NSDictionary class]])
    {
        responseItem.responseDict = [NSDictionary dictionaryWithDictionary:returnData];
    }
    [self networkRequestExecuteFinishedWithItem:responseItem];
}

- (void)networkRequestExecuteFinishedWithItem:(LeResponseItem *)responseItem
{
    LeRequestItem * requestItem = responseItem.requestItem;
    
    //    responseItem.errorInfo = [self parseReturnCode:responseItem.code];
    
    //解析回调处理
    if (requestItem.targetCenter && requestItem.targetCenterParser)
    {
        if ([requestItem.targetCenter respondsToSelector:requestItem.targetCenterParser])
        {
            responseItem = [requestItem.targetCenter performSelector:requestItem.targetCenterParser
                                                          withObject:responseItem];
        }
    }
    
    if (requestItem.targetCenter &&requestItem.parseMethod) {
        if ([requestItem.targetCenter respondsToSelector:requestItem.parseMethod]) {
            responseItem = [requestItem.targetCenter performSelector:requestItem.parseMethod
                                                          withObject:responseItem];
            
        }
    }
}


- (void)requestdidFailWithError:(NSError *)error
{
    
}

+ (NSString *)converDictToString:(NSDictionary *)dict
{
    if (!dict)
    {
        return @"";
    }
    NSMutableString * converString = [NSMutableString string];
    NSArray * keyArray = [dict allKeys];
    for (id key in keyArray)
    {
        if (converString.length==0)
        {
            [converString appendFormat:@"?%@=%@",key,[dict objectForKey:key]];
        }
        else
        {
            [converString appendFormat:@"&%@=%@",key,[dict objectForKey:key]];
        }
    }
    return converString;
}


@end
