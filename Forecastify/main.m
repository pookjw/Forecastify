//
//  main.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import "DLManager.h"
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    void *uiKit = DLManager.sharedInstance.uiKit;
    int (*UIApplicationMain)(int, char * _Nullable *, NSString * _Nullable, NSString * _Nullable) = dlsym(uiKit, "UIApplicationMain");
    assert(UIApplicationMain);
    
    void *watchKit = DLManager.sharedInstance.watchKit;
    assert(watchKit);
    
    return UIApplicationMain(argc, argv, @"SPApplication", NSStringFromClass(AppDelegate.class));
}
