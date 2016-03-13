//
//  KYDateCenterExtend+Test.m
//  KYNetworking
//
//  Created by keyan on 16/2/17.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeDateCenterExtend+Test.h"

@implementation KYDateCenterExtend (Test)
- (int)sendVideoBlockListWithTenant_id:(NSString*)tenant_id
                               page_id:(NSString*)page_id
                               user_id:(NSString*)user_id
                         RequestTarget:(id)delegateTarget
                            successSEL:(SEL)successSEL
                               failSEL:(SEL)failSEL
                      isReadLocalCache:(BOOL)isRead
{
    KYRequestItem *requestItem = [[KYRequestItem alloc] init];
    requestItem.httpMethodType = HttpMethodGet;
    requestItem.delegateTarget = delegateTarget;
    requestItem.requestSuccessSEL = successSEL;
    requestItem.requestFailSEL = failSEL;
    requestItem.targetCenter = self;
    requestItem.targetCenterParser = @selector(parseReturnData:);
        requestItem.requestUrl = @"http://api.saas.lecloud.com/getRecommendList1?tenantId=818537&userId=49571";
    requestItem.parseMethod = @selector(parseVideoBlockListData:);
    
    return [self sendRequestWithRequestItem:requestItem];
}

-(void)parseVideoBlockListData:(KYResponseItem *)item
{
    

    
    
    if (item.returnCode!=kRequestSuccess)
    {
        [self sendFailResponseData:item];
        return;
    }
    if (item.responseDict)
    {
        //        NSArray * list = [item.responseDict objectForKey:@"list"];
        //        if ([list isKindOfClass:[NSArray class]])
        //        {
        //            for ( int i = 0; i < list.count; i++)
        //            {
        //                NSDictionary *contentDict = list[i];
        //                VideoBlockItem *videoBlockItem = [[VideoBlockItem alloc] initWithDict:contentDict];
        //                [item.returnDataArray addObject:videoBlockItem];
        //            }
        //        }
            
    }
    [self sendSuccessResponseData:item];
}
@end
