//
//  EMPurchaseCommand.h
//  EmarsysMobile
//

#import "EMCartCommand.h"
#import "EMCartItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMPurchaseCommand : EMCartCommand

- (instancetype)initWithOrderID:(NSString *)orderID
                          items:(NSArray<EMCartItem *> *)items;

@property(readwrite) NSString *orderID;

@end

NS_ASSUME_NONNULL_END
