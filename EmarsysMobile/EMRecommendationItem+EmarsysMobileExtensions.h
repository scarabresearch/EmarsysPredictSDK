//
//  EMRecommendationItem+EmarsysMobileExtensions.h
//  EmarsysMobile
//

#import "EMRecommendationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationItem (EmarsysMobileExtensions)

- (instancetype)initWithResult:(EMRecommendationResult *)result;
- (void)addField:(NSString *)field value:(id)value;

@property(readonly) EMRecommendationResult *result;

@end

NS_ASSUME_NONNULL_END
