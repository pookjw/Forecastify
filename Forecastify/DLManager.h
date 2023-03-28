//
//  DLManager.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLManager : NSObject
@property (class, readonly, nonatomic) DLManager *sharedInstance;
@property (readonly, nonatomic) void *uiKit;
@property (readonly, nonatomic) void *watchKit;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
