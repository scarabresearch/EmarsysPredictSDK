//
//  EMTransaction+EmarsysPredictSDKExtensions.h
//  EmarsysPredictSDK
//

#import "EMTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMTransaction (EmarsysPredictSDKExtensions)

- (nullable NSString *)serialize:(NSError *_Nullable *_Nonnull)error;
- (void)handleResults:(NSArray<EMRecommendationResult *> *)results;

@end

NS_ASSUME_NONNULL_END
