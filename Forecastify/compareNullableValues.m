//
//  compareNullableValues.m
//  Forecastify
//
//  Created by Jinwoo Kim on 3/28/23.
//

#import "compareNullableValues.h"
#import <objc/message.h>

BOOL compareNullableValues(id _Nullable lhs, id _Nullable rhs, SEL cmd) {
    if ((lhs == nil) && (rhs == nil)) {
        return YES;
    } else if ((lhs == nil) || (rhs == nil)) {
        return NO;
    } else {
        return ((BOOL (*)(id, SEL, id))objc_msgSend)(lhs, cmd, rhs);
    }
}

NSComparisonResult comparisonResultNullableValues(id _Nullable lhs, id _Nullable rhs, SEL cmd) {
    if ((lhs == nil) && (rhs == nil)) {
        return NSOrderedSame;
    } else if ((lhs == nil) && (rhs != nil)) {
        return NSOrderedAscending;
    } else if ((lhs != nil) && (rhs == nil)) {
        return NSOrderedDescending;
    } else {
        return ((NSComparisonResult (*)(id, SEL, id))objc_msgSend)(lhs, cmd, rhs);
    }
}
