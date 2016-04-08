//
//  EMViewCommand.h
//  EmarsysPredictSDK
//

#import "EMCommand.h"
#import "EMRecommendationItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMViewCommand : EMCommand

- (instancetype)initWithItemID:(NSString *)itemID
                   trackedItem:(nullable EMRecommendationItem *)trackedItem;

@property(readwrite) NSString *itemID;
@property(readwrite, nullable) EMRecommendationItem *trackedItem;

@end

NS_ASSUME_NONNULL_END
