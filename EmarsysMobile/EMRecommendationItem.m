//
//  EMRecommendationItem.m
//  EmarsysMobile
//

#import "EMRecommendationItem.h"
#import "EMRecommendationItem+EmarsysMobileExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationItem ()

/// Recommendation result.
@property(readonly) EMRecommendationResult *result;
@end

@implementation EMRecommendationItem {
    NSMutableDictionary<NSString *, id> *_data;
}
@synthesize data = _data;

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initWithResult:(EMRecommendationResult *)result {
    self = [super init];
    if (self) {
        _result = result;
        _data = [[NSMutableDictionary<NSString *, id> alloc] init];
    }
    return self;
}

- (void)addField:(NSString *)key value:(id)value {
    [_data setObject:value forKey:key];
}

- (NSString *)description {
    NSString *_Nullable item = [_data valueForKey:@"item"];
    return item ? (NSString *)item : [super description];
}

@end

NS_ASSUME_NONNULL_END
