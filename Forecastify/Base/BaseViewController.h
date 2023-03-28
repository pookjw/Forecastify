//
//  BaseViewController.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : NSObject
@property (readonly, nonatomic) id viewController;
@property (null_resettable, nonatomic, retain) id view;
- (void)loadView;
- (void)viewDidLoad;
@end

NS_ASSUME_NONNULL_END
