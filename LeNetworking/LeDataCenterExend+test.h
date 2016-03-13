//
//  LeDataCenterExend+test.h
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "LeDataCenterExend.h"

@interface LeDataCenterExend (test)
- (int)sendVideoBlockListWithTenant_id:(NSString*)tenant_id
                               page_id:(NSString*)page_id
                               user_id:(NSString*)user_id
                         RequestTarget:(id)delegateTarget
                            successSEL:(SEL)successSEL
                               failSEL:(SEL)failSEL
                      isReadLocalCache:(BOOL)isRead;
@end
