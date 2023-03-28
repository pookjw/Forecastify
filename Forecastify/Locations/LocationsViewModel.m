//
//  LocationsViewModel.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "LocationsViewModel.h"
#import "LocationsSectionModel.h"
#import "LocationsItemModel.h"
#import <objc/message.h>

#define LOCATIONS_VIEW_MODEL_SERIAL_QUEUE_LABEL "com.pookjw.Focastify"

@interface LocationsViewModel ()
@property (retain) id dataSource;
@property (retain) dispatch_queue_t queue;
@end

@implementation LocationsViewModel

- (instancetype)initWithDataSource:(id)dataSource {
    if (self = [super init]) {
        self.dataSource = dataSource;
        [self setupQueue];
    }
    
    return self;
}

- (void)dealloc {
    [self->_dataSource release];
    dispatch_release(self->_queue);
    [super dealloc];
}

- (void)loadDataSource {
    id dataSource = self.dataSource;
    
    dispatch_async(self.queue, ^{
        id snapshot = [NSClassFromString(@"NSDiffableDataSourceSnapshot") new];
        
        LocationsSectionModel *currentLocationSectionModel = [[LocationsSectionModel alloc] initWithType:LocationsSectionModelTypeCurrentLocation];
        LocationsSectionModel *savedLocationsSectionModel = [[LocationsSectionModel alloc] initWithType:LocationsSectionModelTypeSavedLocations];
        
        ((void (*)(id, SEL, NSArray *))objc_msgSend)(snapshot, NSSelectorFromString(@"appendSectionsWithIdentifiers:"), @[currentLocationSectionModel, savedLocationsSectionModel]);
        
        CLLocation *seoulLocation = [[CLLocation alloc] initWithLatitude:37.56 longitude:126.99];
        CLLocation *shanghaiLocation = [[CLLocation alloc] initWithLatitude:31.1667 longitude:121.4667];
        CLLocation *osakaLocation = [[CLLocation alloc] initWithLatitude:34.752 longitude:135.4582];
        
        LocationsItemModel *seoulItemModel = [[LocationsItemModel alloc] initWithLocation:seoulLocation];
        LocationsItemModel *shanghaiItemModel = [[LocationsItemModel alloc] initWithLocation:shanghaiLocation];
        LocationsItemModel *osakaItemModel = [[LocationsItemModel alloc] initWithLocation:osakaLocation];
        
        [seoulLocation release];
        [shanghaiLocation release];
        [osakaLocation release];
        
        ((void (*)(id, SEL, NSArray *, id))objc_msgSend)(snapshot, NSSelectorFromString(@"appendItemsWithIdentifiers:intoSectionWithIdentifier:"), @[seoulItemModel], currentLocationSectionModel);
        ((void (*)(id, SEL, NSArray *, id))objc_msgSend)(snapshot, NSSelectorFromString(@"appendItemsWithIdentifiers:intoSectionWithIdentifier:"), @[shanghaiItemModel, osakaItemModel], savedLocationsSectionModel);
        
        [currentLocationSectionModel release];
        [savedLocationsSectionModel release];
        
        [seoulItemModel release];
        [shanghaiItemModel release];
        [osakaItemModel release];
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        ((void (*)(id, SEL, id, BOOL, void (^)(void)))objc_msgSend)(dataSource, NSSelectorFromString(@"applySnapshot:animatingDifferences:completion:"), snapshot, YES, ^{
            dispatch_semaphore_signal(semaphore);
        });
        
        [snapshot release];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_release(semaphore);
    });
}

- (void)setupQueue {
    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
    dispatch_queue_t queue = dispatch_queue_create(LOCATIONS_VIEW_MODEL_SERIAL_QUEUE_LABEL, attribute);
    dispatch_release(attribute);
    self.queue = queue;
    dispatch_release(queue);
}

@end
