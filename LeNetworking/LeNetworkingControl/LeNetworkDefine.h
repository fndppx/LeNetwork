//
//  LeNetworkDefine.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#ifndef LeNetworkDefine_h
#define LeNetworkDefine_h

/**
 *  请求类型
 */
typedef enum {
    LeAsiNetWorkGET = 1,   /**< GET请求 */
    LeAsiNetWorkPOST       /**< POST请求 */
} LeAsiNetWorkType;

/**
 *  网络请求超时的时间
 */
#define MHAsi_API_TIME_OUT 20


#if NS_BLOCKS_AVAILABLE
/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^LeAsiStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^LeAsiSuccessBlock)(id returnData,int code,NSString *msg);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^LeAsiFailureBlock)(NSError *error);
#endif /* LeNetworkDefine_h */

#endif /* LeNetworkDefine_h */
