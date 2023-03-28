//
//  LocationsItemModel.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationsItemModel : NSObject
@property (readonly, copy, nonatomic) CLLocation *location;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithLocation:(CLLocation *)location;
@end

NS_ASSUME_NONNULL_END
