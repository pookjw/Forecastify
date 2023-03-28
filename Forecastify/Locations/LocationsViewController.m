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
    id dataSource = ((id (*)(id, SEL, id, id _Nullable (^)(id, NSIndexPath *, id)))objc_msgSend)([NSClassFromString(@"UICollectionViewDiffableDataSource") alloc], NSSelectorFromString(@"initWithCollectionView:cellProvider:"), self.collectionView, ^id _Nullable(id collectionView, NSIndexPath *indexPath, id itemIdentifier){
        return nil;
    });
    
    return [dataSource autorelease];
}

@end
