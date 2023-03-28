//
//  LocationsItemModel.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "LocationsItemModel.h"
#import "compareNullableValues.h"

@implementation LocationsItemModel

- (instancetype)initWithLocation:(CLLocation *)location {
    if (self = [super init]) {
        [self->_location release];
        self->_location = [location copy];
    }
    
    return self;
}

- (void)dealloc {
    [self->_location release];
    [super dealloc];
}

- (NSUInteger)hash {
    return self.location.hash;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:LocationsItemModel.class]) {
        return [super isEqual:object];
    }
    
    LocationsItemModel *other = (LocationsItemModel *)object;
    
    return compareNullableValues(self.location, other.location, @selector(isEqual:));
}

@end
