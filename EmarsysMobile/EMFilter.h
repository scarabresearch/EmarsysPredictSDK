//
//  EMFilter.h
//  EmarsysMobile
//

@import Foundation;

#import "EMCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMFilter : EMCommand

- (instancetype)initWithValues:(NSArray<NSString *> *)values
                          rule:(NSString *)rule
                  catalogField:(NSString *)catalogField;

- (instancetype)initWithValue:(NSString *)value
                         rule:(NSString *)rule
                 catalogField:(NSString *)catalogField;

@property(readwrite) NSString *catalogField;
@property(readwrite) NSString *rule;
@property(readwrite) NSArray<NSString *> *values;

@end

NS_ASSUME_NONNULL_END
