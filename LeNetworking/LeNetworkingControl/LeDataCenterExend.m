//
//  LeDataCenterExend.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeDataCenterExend.h"
#import "NSStringExtend.h"
#import "NSObjectAdditions.h"
static LeDataCenterExend*_shardManager;

@implementation LeDataCenterExend

+ (LeDataCenterExend *)sharedDataCenterExtend
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shardManager = [[LeDataCenterExend alloc]init];
    });
    return _shardManager;

}
- (LeResponseItem *)parseReturnData:(LeResponseItem *)item
{
    if (item.responseDict)
    {
        NSString * state = [NSString stringWithObject:[item.responseDict objectForKey:@"state"]];
        NSDictionary * dict = item.responseDict;
        item.state = [state intValue];
        item.debugMessage = [NSString stringWithObject:[item.responseDict objectForKey:@"message"]];
        item.alertMessage = [NSString stringWithObject:[item.responseDict objectForKey:@"alertMessage"]];
        if ([state isEqualToString:@"0"]||[state isEqualToString:@"000000"])
        {
            item.returnCode = kRequestSuccess;
        }
        else
        {
            //请求失败清除当前缓存
            //            [self clearCacheWithUrl:item.requestItem.requestUrl];
            //            [self clearCacheWithUrl:item.requestItem.finalRequestUrl];
            item.returnCode = kRequestServerReturnError;
        }
        id content = [dict objectForKey:@"content"];
        if ([content isNSDictionary])
        {   //page:{“current_page”: 2, “total_page”:20}
            item.responseDict = [NSDictionary dictionaryWithDictionary:content];
            
            id page = [content objectForKey:@"page"];
            if ([page isNSDictionary])
            {
                NSString * pageStr = [NSString stringWithObject:[page objectForKey:@"currentPage"]];
                NSString * totalPageStr = [NSString stringWithObject:[page objectForKey:@"totalPage"]];
                if([content objectForKey:@"hasNext"]){
                    if([[content objectForKey:@"hasNext"] integerValue]){
                        totalPageStr = [NSString stringWithFormat:@"%d",[[page objectForKey:@"totalPage"] intValue] + 1];
                    }
                }
                NSString * totalCount = [NSString stringWithObject:[page objectForKey:@"totalCount"]];
                if (pageStr&&pageStr.length!=0)
                {
                    item.requestItem.page = [[NSString stringWithFormat:@"%@",pageStr] intValue];
                }
                if (totalPageStr&&totalPageStr.length!=0)
                {
                    item.requestItem.totalPage = [[NSString stringWithFormat:@"%@",totalPageStr] intValue];
                }
                if (totalCount&&totalCount.length!=0)
                {
                    item.requestItem.totalCount = [[NSString stringWithFormat:@"%@",totalCount] intValue];
                }
            }
            
        }
    }
    else
    {
        if (item.requestItem.isReadingCache)//本次是读取缓存数据
        {
            item.returnCode = kRequestSuccess;
            return item;
        }
        item.debugMessage = @"服务器连接失败,请稍候重试";
        item.alertMessage = @"服务器连接失败,请稍候重试";
        //        [self clearCacheWithUrl:item.requestItem.requestUrl];
        //        [self clearCacheWithUrl:item.requestItem.finalRequestUrl];
        item.returnCode = kRequestServerReturnError;
    }
    return item;
}


@end
