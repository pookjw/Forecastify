//
//  LocationsViewController.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "LocationsViewController.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "LocationsViewModel.h"
#import "LocationsCollectionViewCell.h"

@interface LocationsViewController ()
@property (readonly, nonatomic) id collectionView;
@property (retain) LocationsViewModel *viewModel;
@end

@implementation LocationsViewController

- (void)dealloc {
    [self->_viewModel release];
    [super dealloc];
}

- (void)loadView {
    id layout = [NSClassFromString(@"PUICListCollectionViewLayout") new];
    id collectionView = ((id (*)(id, SEL, CGRect, id))objc_msgSend)([NSClassFromString(@"PUICListCollectionView") alloc], NSSelectorFromString(@"initWithFrame:collectionViewLayout:"), CGRectNull, layout);
    
    [layout release];
    self.view = collectionView;
    [collectionView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel];
    [self.viewModel loadDataSource];
}

- (id)collectionView {
    return self.view;
}

- (void)setupViewModel {
    id dataSource = [self makeDataSource];
    LocationsViewModel *viewModel = [[LocationsViewModel alloc] initWithDataSource:dataSource];
    self.viewModel = viewModel;
    [viewModel release];
}

- (id)makeDataSource {
    id cellRegistration = [self makeCellRegistration];
    
    id dataSource = ((id (*)(id, SEL, id, id _Nullable (^)(id, NSIndexPath *, id)))objc_msgSend)([NSClassFromString(@"UICollectionViewDiffableDataSource") alloc], NSSelectorFromString(@"initWithCollectionView:cellProvider:"), self.collectionView, ^id _Nullable(id collectionView, NSIndexPath *indexPath, id itemIdentifier) {
        id cell = ((id (*)(id, SEL, id, NSIndexPath *, id))objc_msgSend)(collectionView, NSSelectorFromString(@"dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:"), cellRegistration, indexPath, itemIdentifier);
        return cell;
    });
    
    return [dataSource autorelease];
}

- (id)makeCellRegistration {
    void (^handler)(id, NSIndexPath *, id) = ^(id cell, NSIndexPath *indexPath, id item) {
        
    };
    
    id cellRegistration = ((id (*)(id, SEL, Class, void (^)(id, NSIndexPath *, id)))objc_msgSend)(NSClassFromString(@"UICollectionViewCellRegistration"), NSSelectorFromString(@"registrationWithCellClass:configurationHandler:"), LocationsCollectionViewCell.locationsCollectionViewCellClass, handler);
    
    return cellRegistration;
}

@end
