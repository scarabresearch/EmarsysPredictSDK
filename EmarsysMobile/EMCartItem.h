//
//  EMCartItem.h
//  EmarsysMobile
//

@import Foundation;

#pragma mark - Cart Item -

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief The cart item.
 */
@interface EMCartItem : NSObject

- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;

/*!
 * @brief Initializes a newly allocated item instance.
 */
- (instancetype)initWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity;
/*!
 * @brief Creates and returns an item instance.
 * @param itemID ID of cart item (consistent with the item column specified in
 * the catalog).
 * @param price Sum total payable for the item, taking into consideration the
 * quantity ordered, and any discounts.
 * @param quantity Quantity in cart.
 */
+ (instancetype)itemWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity;

/*!
 * @brief ID of cart item (consistent with the item column specified in the
 * catalog).
 */
@property(readonly) NSString *itemID;
/*!
 * @brief Sum total payable for the item, taking into consideration the quantity
 * ordered, and any discounts.
 */
@property(readonly) float price;
/*!
 * @brief Quantity in cart.
 */
@property(readonly) int quantity;

@end

NS_ASSUME_NONNULL_END
