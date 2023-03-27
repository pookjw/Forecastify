//
//  PurpleViewController.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/27/23.
//

#import "PurpleViewController.h"
#import <objc/message.h>

@implementation PurpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id systemPurpleColor = ((id (*)(id, SEL))objc_msgSend)(NSClassFromString(@"UIColor"), NSSelectorFromString(@"systemPurpleColor"));
    
    ((void (*)(id, SEL, id))objc_msgSend)(self.view, NSSelectorFromString(@"setBackgroundColor:"), systemPurpleColor);
}

@end
