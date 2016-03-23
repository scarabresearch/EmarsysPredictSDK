//
//  EMRecommendCommand.h
//  EmarsysMobile
//

#import "EMCommand.h"
#import "EMRecommendationRequest+EmarsysMobileExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendCommand : EMCommand

- (instancetype)initWithEMRecommendationRequest:
    (EMRecommendationRequest *)recommendationRequest;

@property(readwrite) EMRecommendationRequest *recommendationRequest;

@end

NS_ASSUME_NONNULL_END
