//
//  AppDelegate.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "AppDelegate.h"
#import <objc/message.h>
#import "ClassAllocator.h"

@interface AppDelegate ()
@property (retain) id _Nullable window;
@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(id)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id window = [NSClassFromString(@"UIWindow") new];
    id viewController = [ClassAllocator.PurpleViewController new];
    id view = ((id (*)(id, SEL))objc_msgSend)(viewController, NSSelectorFromString(@"view"));
    id systemPurpleColor = ((id (*)(id, SEL))objc_msgSend)(NSClassFromString(@"UIColor"), NSSelectorFromString(@"systemPurpleColor"));
    ((void (*)(id, SEL, id _Nullable))objc_msgSend)(view, NSSelectorFromString(@"setBackgroundColor:"), systemPurpleColor);
    
    ((void (*)(id, SEL, id _Nullable))objc_msgSend)(window, NSSelectorFromString(@"setRootViewController:"), viewController);
    [viewController release];
    
    ((void (*)(id, SEL))objc_msgSend)(window, NSSelectorFromString(@"makeKeyAndVisible"));
    
    self.window = window;
    [window release];
    
    return YES;
}

- (void)didReceiveNonClockKitEvent {
    
}

- (id)extendLaunchTest {
    return nil;
}

@end
