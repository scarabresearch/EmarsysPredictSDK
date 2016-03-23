//
//  EMQueryParams.h
//  EmarsysMobile
//

NS_ASSUME_NONNULL_BEGIN

@interface EMQueryParams : NSObject

- (void)add:(NSString *)key stringValue:(NSString *)value;
- (void)add:(NSString *)key intValue:(int)value;

@property(readwrite) NSMutableDictionary<NSString *, NSString *> *data;

@end

NS_ASSUME_NONNULL_END
