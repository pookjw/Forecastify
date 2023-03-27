//
//  BaseViewController.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "BaseViewController.h"
#import <objc/objc-sync.h>
#import <objc/runtime.h>
#import <objc/message.h>

static BaseViewController * _baseViewController_managedObject(id self) {
    BaseViewController *managedObejct;
    object_getInstanceVariable(self, "managedObject", (void **)&managedObejct);
    return managedObejct;
}

static void (*_baseViewController_original_dealloc)(id, SEL);
static void _baseViewController_new_dealloc(id self, SEL cmd) {
    _baseViewController_original_dealloc(self, cmd);
}

static void (*_baseViewController_original_viewDidLoad)(id, SEL);
static void _baseViewController_new_viewDidLoad(id self, SEL cmd) {
    [_baseViewController_managedObject(self) viewDidLoad];
}

static id (*_baseViewController_original_view)(id, SEL);
static id _baseViewController_new_view(id self, SEL cmd) {
    return [_baseViewController_managedObject(self) view];
}

static void (*_baseViewController_original_setView)(id self, SEL cmd, id view);
static void _baseViewController_new_setView(id self, SEL cmd, id view) {
    [_baseViewController_managedObject(self) setView:view];
}

@interface BaseViewController ()
@property (class, readonly) Class baseViewControllerClass;
@end

@implementation BaseViewController

+ (Class)baseViewControllerClass {
    objc_sync_enter(self);
    
    static Class _Nullable baseViewControllerClass = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        baseViewControllerClass = objc_allocateClassPair(NSClassFromString(@"SPViewController"), "_BaseViewController", 0);
        
        class_addIvar(baseViewControllerClass, "managedObject", sizeof(id), rint(log2(sizeof(id))), @encode(id));
        
        _baseViewController_original_dealloc = (void (*)(id, SEL))class_getMethodImplementation(baseViewControllerClass, @selector(dealloc));
        class_replaceMethod(baseViewControllerClass, @selector(dealloc), (IMP)_baseViewController_new_dealloc, nil);
        
        _baseViewController_original_viewDidLoad = (void (*)(id, SEL))class_getMethodImplementation(baseViewControllerClass, @selector(viewDidLoad));
        class_replaceMethod(baseViewControllerClass, @selector(viewDidLoad), (IMP)_baseViewController_new_viewDidLoad, nil);
        
        _baseViewController_original_view = (id (*)(id, SEL))class_getMethodImplementation(baseViewControllerClass, @selector(view));
        class_replaceMethod(baseViewControllerClass, @selector(view), (IMP)_baseViewController_new_view, nil);
        
        _baseViewController_original_setView = (void (*)(id, SEL, id))class_getMethodImplementation(baseViewControllerClass, @selector(setView:));
        class_replaceMethod(baseViewControllerClass, @selector(setView:), (IMP)_baseViewController_new_setView, nil);
    });
    
    objc_sync_exit(self);
    
    return baseViewControllerClass;
}

- (instancetype)init {
    if (self = [super init]) {
        id viewController = [BaseViewController.baseViewControllerClass new];
        object_setInstanceVariable(viewController, "managedObject", self); // assign, for avoiding retain cycle.
        
        [self->_viewController release];
        self->_viewController = [viewController retain];
        [viewController release];
    }
    
    return self;
}

- (void)dealloc {
    [_viewController release];
    [super dealloc];
}

- (id)view {
    return _baseViewController_original_view(self.viewController, @selector(view));
}

- (void)setView:(id)view {
    _baseViewController_original_setView(self.viewController, @selector(setView:), view);
}

- (void)viewDidLoad {
    _baseViewController_original_viewDidLoad(self.viewController, @selector(viewDidLoad));
}

@end
