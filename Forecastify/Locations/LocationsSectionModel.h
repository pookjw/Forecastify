//
//  LocationsSectionModel.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LocationsSectionModelType) {
    LocationsSectionModelTypeCurrentLocation,
    LocationsSectionModelTypeSavedLocations
};

@interface LocationsSectionModel : NSObject
@property (readonly) LocationsSectionModelType type;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithType:(LocationsSectionModelType)type;
@end

NS_ASSUME_NONNULL_END
