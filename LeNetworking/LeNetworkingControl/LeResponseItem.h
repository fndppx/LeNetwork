//
//  LeResponseItem.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeRequestItem.h"
#import "StaticValues.h"
@interface LeResponseItem : NSObject
@property(nonatomic,strong)NSString * oriResponseString;
@property(nonatomic,strong)NSDictionary * responseDict;
@property(nonatomic,strong)LeRequestItem * requestItem;
@property(nonatomic,strong)NSMutableArray * returnDataArray;
@property(nonatomic,assign)kReturnCode returnCode;
@property(nonatomic,strong)NSString * httpMessage;
@property(nonatomic,strong)NSString * debugMessage;
@property(nonatomic,strong)NSString * alertMessage;
@property(nonatomic,assign)BOOL hasUpdate;//数据是否更新，根据http304判断
@property(nonatomic,assign)NSInteger state;//移动代理返回的状态码
@end
