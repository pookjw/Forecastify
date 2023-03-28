//
//  BaseListPlatterCell.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "BaseListPlatterCell.h"
#import <objc/message.h>

static BaseListPlatterCell * _baseListPlatterCell_managedObject(id self) {
    BaseListPlatterCell *managedObject;
    object_getInstanceVariable(self, "managedObject", (void **)&managedObject);
    return managedObject;
}

static id _baseListPlatterCell_contentView(id self, SEL cmd) {
    return [_baseListPlatterCell_managedObject(self) contentView];
}

@interface BaseListPlatterCell ()
@property (class, readonly, nonatomic) Class baseListPlatterCell;
@property (readonly, nonatomic) struct objc_super superInfo;
@end

@implementation BaseListPlatterCell

+ (Class)baseListPlatterCell {
    static Class _Nullable baseListPlatterCell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        baseListPlatterCell = objc_allocateClassPair(NSClassFromString(@"PUICListPlatterCell"), "_BaseListPlatterCell", 0);
        
        class_addIvar(baseListPlatterCell, "managedObject", sizeof(id), rint(log2(sizeof(id))), @encode(id));
        
        class_addMethod(baseListPlatterCell, @selector(contentView), (IMP)_baseListPlatterCell_contentView, nil);
    });
    
    return baseListPlatterCell;
}

//- (id)contentView {
//    
//}
//
//- (struct objc_super)superInfo {
//    struct objc_super superInfo = { self.viewController, [self.viewController superclass] };
//    return superInfo;
//}

@end
