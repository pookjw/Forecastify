//
//  ClassAllocator.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "ClassAllocator.h"
#import <objc/objc-sync.h>
#import <objc/runtime.h>

@implementation ClassAllocator

+ (Class)PurpleViewController {
    objc_sync_enter(self);
    
    static Class _Nullable PurpleViewController = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        PurpleViewController = objc_allocateClassPair(NSClassFromString(@"SPViewController"), "PurpleViewController", 0);
    });
    
    objc_sync_exit(self);
    
    return PurpleViewController;
}

@end
