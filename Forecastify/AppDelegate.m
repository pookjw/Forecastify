//
//  AppDelegate.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "AppDelegate.h"
#import <objc/message.h>
#import "PurpleViewController.h"

@interface AppDelegate ()
@property (retain) id _Nullable window;
@property (retain) BaseViewController *rootViewController;
@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [_rootViewController release];
    [super dealloc];
}

- (BOOL)application:(id)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id window = [NSClassFromString(@"UIWindow") new];
    PurpleViewController *rootViewController = [PurpleViewController new];
    
    ((void (*)(id, SEL, id _Nullable))objc_msgSend)(window, NSSelectorFromString(@"setRootViewController:"), rootViewController.viewController);
    
    self.rootViewController = rootViewController;
    [rootViewController release];
    
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

- (void)applicationWillSuspend:(id)arg0 {
    
}

@end
