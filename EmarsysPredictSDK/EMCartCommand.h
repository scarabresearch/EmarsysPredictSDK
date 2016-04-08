//
//  EMCartCommand.h
//  EmarsysPredictSDK
//

#import "EMCommand.h"
#import "EMCartItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMCartCommand : EMCommand

- (instancetype)initWithItems:(NSArray<EMCartItem *> *)items;

@property(readwrite) NSArray<EMCartItem *> *items;

@end

NS_ASSUME_NONNULL_END
