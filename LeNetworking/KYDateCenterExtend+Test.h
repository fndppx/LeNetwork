//
//  KYDateCenterExtend+Test.h
//  KYNetworking
//
//  Created by keyan on 16/2/17.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeDateCenterExtend.h"

@interface LeDateCenterExtend (Test)
- (int)sendVideoBlockListWithTenant_id:(NSString*)tenant_id
                               page_id:(NSString*)page_id
                               user_id:(NSString*)user_id
                         RequestTarget:(id)delegateTarget
                            successSEL:(SEL)successSEL
                               failSEL:(SEL)failSEL
                      isReadLocalCache:(BOOL)isRead;
@end
