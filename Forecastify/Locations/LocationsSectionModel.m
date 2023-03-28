//
//  LocationsSectionModel.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "LocationsSectionModel.h"

@implementation LocationsSectionModel

- (instancetype)initWithType:(LocationsSectionModelType)type {
    if (self = [super init]) {
        self->_type = type;
    }
    
    return self;
}

- (NSUInteger)hash {
    return self.type;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:LocationsSectionModel.class]) {
        return [super isEqual:object];
    }
    
    LocationsSectionModel *other = (LocationsSectionModel *)object;
    
    return self.type == other.type;
}

@end
