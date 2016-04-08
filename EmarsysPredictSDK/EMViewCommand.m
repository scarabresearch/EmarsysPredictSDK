//
//  EMViewCommand.m
//  EmarsysPredictSDK
//

@import Foundation;

#import "EMViewCommand.h"
#import "EMRecommendationItem+EmarsysPredictSDKExtensions.h"
#import "EMLogger.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMViewCommand

- (instancetype)initWithItemID:(NSString *)itemID
                   trackedItem:(nullable EMRecommendationItem *)trackedItem {
    self = [super init];
    if (self) {
        _itemID = itemID;
        _trackedItem = trackedItem;
    }
    return self;
}

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([_itemID length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"view" field:@"itemID"]];
    }
    return ret;
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"i:"];
    [ret appendString:_itemID];

    EMRecommendationItem *trackedItem = _trackedItem;
    if (trackedItem) {
        [ret appendString:@",t:"];
        [ret appendString:trackedItem.result.featureID];
        [ret appendString:@",c:"];
        [ret appendString:trackedItem.result.cohort];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
