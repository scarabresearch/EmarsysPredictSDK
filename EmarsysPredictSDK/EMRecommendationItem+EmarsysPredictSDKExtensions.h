//
//  EMRecommendationItem+EmarsysPredictSDKExtensions.h
//  EmarsysPredictSDK
//

#import "EMRecommendationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationItem (EmarsysPredictSDKExtensions)

- (instancetype)initWithResult:(EMRecommendationResult *)result;
- (void)addField:(NSString *)field value:(id)value;

@property(readonly) EMRecommendationResult *result;

@end

NS_ASSUME_NONNULL_END
