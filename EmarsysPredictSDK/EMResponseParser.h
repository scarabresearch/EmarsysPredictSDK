//
//  EMResponseParser.h
//  EmarsysPredictSDK
//

#import "EMRecommendationResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMResponseParser : NSObject

- (nullable instancetype)initWithJSON:(NSDictionary *)json
                                error:(NSError *_Nullable *_Nullable)error;

@property(readwrite) NSString *cohort;
@property(readwrite) NSString *visitor;
@property(readwrite) NSString *session;
@property(readonly) NSMutableArray<EMRecommendationResult *> *results;

@end

NS_ASSUME_NONNULL_END
