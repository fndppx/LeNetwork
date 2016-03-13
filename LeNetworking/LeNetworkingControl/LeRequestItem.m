//
//  LeRequestItem.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeRequestItem.h"

@implementation LeRequestItem
- (id)init
{
    self = [super init];
    if (self) {
//        _maxTimeOut = kLCRequestTimeout;
        _httpMethodType = HttpMethodGet;
//        _requestHeader = [NSDictionary dictionaryWithDictionary:[[KYNetworkConfiguration shardConfiguration] requestHeader]];
    }
    return self;
}
@end
