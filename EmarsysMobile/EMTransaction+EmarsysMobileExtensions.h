//
//  EMTransaction+EmarsysMobileExtensions.h
//  EmarsysMobile
//

#import "EMTransaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMTransaction (EmarsysMobileExtensions)

- (nullable NSString *)serialize:(NSError *_Nullable *_Nonnull)error;
- (void)handleResults:(NSArray<EMRecommendationResult *> *)results;

@end

NS_ASSUME_NONNULL_END
