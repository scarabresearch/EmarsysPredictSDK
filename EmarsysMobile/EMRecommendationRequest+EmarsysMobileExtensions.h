//
//  EMRecommendationRequest+EmarsysMobileExtensions.h
//  EmarsysMobile
//

#import "EMFilter.h"
#import "EMRecommendationRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationRequest (EmarsysMobileExtensions)

- (NSArray<EMFilter *> *)filters;

@end

NS_ASSUME_NONNULL_END
