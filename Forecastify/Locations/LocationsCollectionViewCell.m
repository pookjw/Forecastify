//
//  LocationsCollectionViewCell.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "LocationsCollectionViewCell.h"
#import <objc/message.h>
#import <objc/objc-sync.h>

OBJC_EXPORT id objc_msgSendSuper2(void);

static LocationsCollectionViewCell * _locationsCollectionViewCell_managedObject(id self) {
    LocationsCollectionViewCell *managedObject;
    object_getInstanceVariable(self, "managedObject", (void **)&managedObject);
    return managedObject;
}

static id _locationsCollectionViewCell_initWithFrame(id self, SEL cmd, CGRect frame) {
    struct objc_super superInfo = { self, [self superclass] };
    self = ((id (*)(struct objc_super *, SEL, CGRect))objc_msgSendSuper2)(&superInfo, @selector(initWithFrame:), frame);
    
    LocationsCollectionViewCell *managedObject = [[LocationsCollectionViewCell alloc] initWithFrame:frame];
    object_setInstanceVariable(self, "managedObject", [managedObject retain]);
    managedObject.locationsCollectionViewCell = self;
    
    return self;
}

static void _locationsCollectionViewCell_dealloc(id self, SEL cmd) {
    [_locationsCollectionViewCell_managedObject(self) release];
    struct objc_super superInfo = { self, [self superclass] };
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(dealloc));
}

static id _locationsCollectionViewCell_contentView(id self, SEL cmd) {
    return [_locationsCollectionViewCell_managedObject(self) contentView];
}

static void _locationsCollectionViewCell_prepareForReuse(id self, SEL cmd) {
    [_locationsCollectionViewCell_managedObject(self) prepareForReuse];
    struct objc_super superInfo = { self, [self superclass] };
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper)(&superInfo, @selector(prepareForReuse));
}

@interface LocationsCollectionViewCell ()
@property (readonly, nonatomic) struct objc_super superInfo;
@end

@implementation LocationsCollectionViewCell

+ (Class)locationsCollectionViewCellClass {
    static Class _Nullable locationsCollectionViewCellClass = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        locationsCollectionViewCellClass = objc_allocateClassPair(NSClassFromString(@"PUICListPlatterCell"), "_LocationsCollectionViewCell", 0);
        
        class_addIvar(locationsCollectionViewCellClass, "managedObject", sizeof(id), rint(log2(sizeof(id))), @encode(id));
        
        class_addMethod(locationsCollectionViewCellClass, @selector(initWithFrame:), (IMP)_locationsCollectionViewCell_initWithFrame, nil);
        class_addMethod(locationsCollectionViewCellClass, @selector(dealloc), (IMP)_locationsCollectionViewCell_dealloc, nil);
        class_addMethod(locationsCollectionViewCellClass, @selector(contentView), (IMP)_locationsCollectionViewCell_contentView, nil);
        class_addMethod(locationsCollectionViewCellClass, @selector(prepareForReuse), (IMP)_locationsCollectionViewCell_prepareForReuse, nil);
    });
    
    return locationsCollectionViewCellClass;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self init];
    return self;
}

- (id)locationsCollectionViewCell {
    objc_sync_enter(self);
    
    __weak id listPlatterCell = self->_locationsCollectionViewCell;
    
    if (listPlatterCell) {
        [listPlatterCell retain];
    } else {
        listPlatterCell = [LocationsCollectionViewCell.locationsCollectionViewCellClass new];
        object_setInstanceVariable(listPlatterCell, "managedObject", [self retain]);
        self->_locationsCollectionViewCell = listPlatterCell;
    }
    
    objc_sync_exit(self);
    
    return [listPlatterCell autorelease];
}

- (id)contentView {
    struct objc_super superInfo = { self.locationsCollectionViewCell, [self.locationsCollectionViewCell superclass] };
    return ((id (*)(struct objc_super *, SEL))objc_msgSendSuper2)(&superInfo, @selector(contentView));
}

- (void)prepareForReuse {
    struct objc_super superInfo = { self.locationsCollectionViewCell, [self.locationsCollectionViewCell superclass] };
    ((void (*)(struct objc_super *, SEL))objc_msgSendSuper2)(&superInfo, @selector(prepareForReuse));
}

@end
