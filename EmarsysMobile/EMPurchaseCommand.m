//
//  EMPurchaseCommand.m
//  EmarsysMobile
//

@import Foundation;

#import "EMPurchaseCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMPurchaseCommand

- (instancetype)initWithOrderID:(NSString *)orderID
                          items:(NSArray<EMCartItem *> *)items {
    self = [super initWithItems:items];
    if (self) {
        _orderID = orderID;
    }
    return self;
}

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([_orderID length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"purchase" field:@"orderID"]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
