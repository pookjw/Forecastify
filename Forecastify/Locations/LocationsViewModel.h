//
//  LocationsViewModel.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationsViewModel : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id)dataSource;
- (void)loadDataSource;
@end

NS_ASSUME_NONNULL_END
