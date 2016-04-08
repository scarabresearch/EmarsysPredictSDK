//
//  EMRecommendationResult+EmarsysPredictSDKExtensions.h
//  EmarsysPredictSDK
//

#import "EMRecommendationResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationResult (EmarsysPredictSDKExtensions)

- (instancetype)initWithFields:(NSString *)cohort
                     featureID:(NSString *)featureID
                         topic:(nullable NSString *)topic;

- (void)addProduct:(EMRecommendationItem *)product;

@end

NS_ASSUME_NONNULL_END
