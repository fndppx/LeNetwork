//
//  NSObjectAdditions.m
//  Utility
//
//  Created by Tiger Xia on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObjectAdditions.h"
//#import "SHUtil+Macro.h"

@implementation NSObject (NSObjectAdditions)

//- (void)performSelectorInGCDThread:(SEL)aSelector withObject:(id)arg {
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0")) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [self performSelector:aSelector withObject:arg];
//        });
//    }else {
//        [self performSelectorInBackground:aSelector withObject:arg];
//    } 
//}
//
//- (void)performSelectorInGCDMainThread:(SEL)aSelector withObject:(id)arg {
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0")) {
//        dispatch_async(dispatch_get_main_queue(), ^(void)
//                       {
//                           assert([NSThread isMainThread]);
//                           [self performSelector:aSelector withObject:arg];
//                       });
//    }else {
//        [self performSelectorOnMainThread:aSelector withObject:arg waitUntilDone:[NSThread isMainThread]];
//    }
//}

//检查object对象是否为空，是否是字典
- (BOOL)isNSDictionary
{
    if (self && [self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    else {
        return NO;
    }
}
//检查object对象是否为空，是否是数组
- (BOOL)isNSArray
{
    if (self && [self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    else {
        return NO;
    }
}
@end
