//
//  BaseViewController.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "BaseViewController.h"
#import <objc/message.h>
#import <objc/objc-sync.h>

static BaseViewController * _baseViewController_managedObject(id self) {
    BaseViewController *managedObejct;
    object_getInstanceVariable(self, "managedObject", (void **)&managedObejct);
    return managedObejct;
}

static void _baseViewController_dealloc(id self, SEL cmd) {
    [_baseViewController_managedObject(self) release];
    struct objc_super superInfo = { self, [self superclass] };
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(dealloc));
}

static void _baseViewController_loadView(id self, SEL cmd) {
    [_baseViewController_managedObject(self) loadView];
}

static void _baseViewController_viewDidLoad(id self, SEL cmd) {
    [_baseViewController_managedObject(self) viewDidLoad];
}

static id _baseViewController_view(id self, SEL cmd) {
    return [_baseViewController_managedObject(self) view];
}

static void _baseViewController_setView(id self, SEL cmd, id view) {
    [_baseViewController_managedObject(self) setView:view];
}

@interface BaseViewController ()
@property (class, readonly, nonatomic) Class baseViewControllerClass;
@property (readonly, nonatomic) struct objc_super superInfo;
@end

@implementation BaseViewController {
    id _viewController;
}

+ (Class)baseViewControllerClass {
    static Class _Nullable baseViewControllerClass = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        baseViewControllerClass = objc_allocateClassPair(NSClassFromString(@"SPViewController"), "_BaseViewController", 0);
        
        class_addIvar(baseViewControllerClass, "managedObject", sizeof(id), rint(log2(sizeof(id))), @encode(id));
        
        class_addMethod(baseViewControllerClass, @selector(dealloc), (IMP)_baseViewController_dealloc, nil);
        
        class_addMethod(baseViewControllerClass, @selector(loadView), (IMP)_baseViewController_loadView, nil);
        
        class_addMethod(baseViewControllerClass, @selector(viewDidLoad), (IMP)_baseViewController_viewDidLoad, nil);
        
        class_addMethod(baseViewControllerClass, @selector(view), (IMP)_baseViewController_view, nil);
        
        class_addMethod(baseViewControllerClass, @selector(setView:), (IMP)_baseViewController_setView, nil);
    });
    
    return baseViewControllerClass;
}

- (id)viewController {
    objc_sync_enter(self);
    
    __weak id viewController = self->_viewController;
    
    if (viewController) {
        [viewController retain];
    } else {
        viewController = [BaseViewController.baseViewControllerClass new];
        object_setInstanceVariable(viewController, "managedObject", [self retain]);
        self->_viewController = viewController;
    }
    
    objc_sync_exit(self);
    
    return [viewController autorelease];
}

- (id)view {
    struct objc_super superInfo = self.superInfo;
    return ((id (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(view));
}

- (void)setView:(id)view {
    struct objc_super superInfo = self.superInfo;
    ((void (*)(struct objc_super *, SEL, id))objc_msgSendSuper)(&superInfo, @selector(setView:), view);
}

- (void)loadView {
    struct objc_super superInfo = self.superInfo;
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(loadView));
}

- (void)viewDidLoad {
    struct objc_super superInfo = self.superInfo;
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(viewDidLoad));
}

- (struct objc_super)superInfo {
    struct objc_super superInfo = { self.viewController, [self.viewController superclass] };
    return superInfo;
}

@end
