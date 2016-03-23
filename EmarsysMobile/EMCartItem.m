//
//  EMCartItem.m
//  EmarsysMobile
//

#import "EMCartItem.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMCartItem

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

+ (instancetype)itemWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity {
    return [[EMCartItem alloc] initWithItemID:itemID
                                        price:price
                                     quantity:quantity];
}

- (instancetype)initWithItemID:(nonnull NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity {
    self = [super init];
    if (self) {
        _itemID = itemID;
        _price = price;
        _quantity = quantity;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
