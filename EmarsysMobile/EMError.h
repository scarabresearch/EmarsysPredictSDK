//
//  EMError.h
//  EmarsysMobile
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const EMErrorDomain;

typedef NS_ENUM(NSInteger, EMErrorCode) {
    EMErrorUnknown = -1,
    EMErrorBadHTTPStatus = -996,
    EMErrorMissingJSONParameter = -997,
    EMErrorMissingMerchantID = -998,
    EMErrorNonUniqueRecommendationLogic = -999
};

NS_ASSUME_NONNULL_END
