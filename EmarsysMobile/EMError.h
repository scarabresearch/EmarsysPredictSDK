//
//  EMError.h
//  EmarsysMobile
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const EMErrorDomain;

/*!
 * @typedef EMErrorCode
 * @brief These values are returned as the error code property of an NSError
 * object with the domain EMErrorDomain.
 * @constant EMErrorUnknown An unknown error has occurred.
 * @constant EMErrorMissingCDVCookie CDV cookie was not present in the HTTP
 * response.
 * @constant EMErrorBadHTTPStatus HTTP response returned other than code 200.
 * @constant EMErrorMissingJSONParameter HTTP response is missing an expected
 * JSON key.
 * @constant EMErrorMissingMerchantID Merchant ID was not set.
 * @constant EMErrorNonUniqueRecommendationLogic Non-unique recommendation logic
 * was used inside a transaction.
 */
typedef NS_ENUM(NSInteger, EMErrorCode) {
    EMErrorUnknown = -1,
    EMErrorMissingCDVCookie = -995,
    EMErrorBadHTTPStatus = -996,
    EMErrorMissingJSONParameter = -997,
    EMErrorMissingMerchantID = -998,
    EMErrorNonUniqueRecommendationLogic = -999
};

NS_ASSUME_NONNULL_END
