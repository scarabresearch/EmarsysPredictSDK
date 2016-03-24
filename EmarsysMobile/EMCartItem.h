//
//  EMCartItem.h
//  EmarsysMobile
//

@import Foundation;

#pragma mark - Cart Item -

NS_ASSUME_NONNULL_BEGIN

/// Cart item.
@interface EMCartItem : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/// Initializes a new EMCartItem instance.
- (instancetype)initWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity;
/// Initializes a new EMCartItem instance.
+ (instancetype)itemWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity;

/// Unique ID of cart item (consistent with the item column specified in
/// the catalog).
@property(readonly) NSString *itemID;
/// Sum total payable for the item, taking into consideration the quantity
/// ordered, and any discounts.
@property(readonly) float price;
/// Quantity in the purchase.
@property(readonly) int quantity;

@end

NS_ASSUME_NONNULL_END
