//
//  EMRecommendationRequest+EmarsysPredictSDKExtensions.h
//  EmarsysPredictSDK
//

#import "EMFilter.h"
#import "EMRecommendationRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationRequest (EmarsysPredictSDKExtensions)

- (NSArray<EMFilter *> *)filters;

@end

NS_ASSUME_NONNULL_END
