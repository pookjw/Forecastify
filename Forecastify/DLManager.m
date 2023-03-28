//
//  DLManager.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "DLManager.h"
#import <objc/objc-sync.h>
#import <dlfcn.h>

@implementation DLManager {
    void * _Nullable _uiKit;
    void * _Nullable _watchKit;
}

+ (DLManager *)sharedInstance {
    static DLManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [DLManager new];
    });
    
    return sharedInstance;
}

- (void *)uiKit {
    void *uiKit;
    
    objc_sync_enter(self);
    
    if (self->_uiKit) {
        uiKit = self->_uiKit;
    } else {
        uiKit = dlopen("/System/Library/Frameworks/UIKit.framework/UIKit", RTLD_NOW);
        self->_uiKit = uiKit;
        assert(uiKit);
    }
    
    objc_sync_exit(self);
    
    return uiKit;
}

- (void *)watchKit {
    void *watchKit;
    
    objc_sync_enter(self);
    
    if (self->_watchKit) {
        watchKit = self->_watchKit;
    } else {
        watchKit = dlopen("/System/Library/Frameworks/WatchKit.framework/WatchKit", RTLD_NOW);
        self->_watchKit = watchKit;
        assert(watchKit);
    }
    
    objc_sync_exit(self);
    
    return watchKit;
}

@end
