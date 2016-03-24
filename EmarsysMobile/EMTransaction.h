//
//  EMTransaction.h
//  EmarsysMobile
//

#import <EmarsysMobile/EMCartItem.h>
#import <EmarsysMobile/EMRecommendationRequest.h>

#pragma mark - EmarsysMobile Transaction -

NS_ASSUME_NONNULL_BEGIN

@interface EMTransaction : NSObject

/// Initialize a new EMTransaction instance.
- (instancetype)init;
/// Initialize a new EMTransaction instance.
- (instancetype)initWithItem:(nullable EMRecommendationItem *)item;
/// Initialize a new EMTransaction instance.
+ (instancetype)transactionWithItem:(nullable EMRecommendationItem *)item;

/// Availability zone. If you run localized versions of your website, you
/// should use this property.
- (void)setAvailabilityZone:(NSString *)availabilityZone;
/// Report a purchase event. This command should be called on the order
/// confirmation page to report successful purchases. Also make sure all
/// purchased items are passed to the command.
- (void)setPurchase:(NSString *)orderID ofItems:(NSArray<EMCartItem *> *)items;
/// Report a search terms entered by visitor. This call should be placed in the
/// search results page.
- (void)setSearchTerm:(NSString *)searchTerm;
/// Report a product browsed by visitor. This command should be
/// placed in all product pages – i.e. pages showing a single item in detail.
/// Recommender features RELATED and ALSO_BOUGHT depend on this call.
- (void)setView:(NSString *)itemID;
/// Report the list of items in the visitor's shopping cart. This command should
/// be
/// called on every page. Make sure all cart items are passed to the command. If
/// the visitor's cart is empty, send the empty array [].
- (void)setCart:(NSArray<EMCartItem *> *)items;
/// Report the category currently browsed by visitor. Should be called on all
/// category pages. Pass a valid category path.
- (void)setCategory:(NSString *)category;
/// Report the keyword used by visitors to refine their searches. Brands,
/// locations,
/// price ranges are good examples of such keywords. If your site offers such
/// features, you can pass keywords to the recommender system with this command.
- (void)setKeyword:(NSString *)keyword;
/// Request recommendations.
- (void)recommend:(EMRecommendationRequest *)request;

@end

NS_ASSUME_NONNULL_END
