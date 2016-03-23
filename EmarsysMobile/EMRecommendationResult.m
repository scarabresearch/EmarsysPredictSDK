//
//  EMRecommendationResult.m
//  EmarsysMobile
//

#import "EMRecommendationResult.h"
#import "EMRecommendationResult+EmarsysMobileExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMRecommendationResult {
    NSMutableArray<EMRecommendationItem *> *_products;
}
@synthesize products = _products;

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initWithFields:(NSString *)cohort
                     featureID:(NSString *)featureID
                         topic:(nullable NSString *)topic {
    self = [super init];
    if (self) {
        _products = [[NSMutableArray<EMRecommendationItem *> alloc] init];
        _cohort = cohort;
        _featureID = featureID;
        _topic = topic;
    }
    return self;
}

- (void)addProduct:(EMRecommendationItem *)product {
    [_products addObject:product];
}

@end

NS_ASSUME_NONNULL_END
