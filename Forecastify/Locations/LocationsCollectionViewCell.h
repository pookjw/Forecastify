//
//  LocationsCollectionViewCell.h
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationsCollectionViewCell : NSObject
@property (class, readonly, nonatomic) Class locationsCollectionViewCellClass;
@property (weak, nonatomic) id locationsCollectionViewCell;
@property (readonly, nonatomic) id contentView;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)prepareForReuse;
@end

NS_ASSUME_NONNULL_END
