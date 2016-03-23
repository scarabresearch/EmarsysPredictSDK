//
//  EMFilter.m
//  EmarsysMobile
//

#import "EMFilter.h"
#import "EMExcludeCommand.h"
#import "EMIncludeCommand.h"
#import "NSArray+EmarsysMobileExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMFilter

- (instancetype)initWithValues:(NSArray<NSString *> *)values
                          rule:(NSString *)rule
                  catalogField:(NSString *)catalogField {
    self = [super init];
    if (self) {
        _values = values;
        _rule = rule;
        _catalogField = catalogField;
    }
    return self;
}

- (instancetype)initWithValue:(NSString *)value
                         rule:(NSString *)rule
                 catalogField:(NSString *)catalogField {
    return [self initWithValues:[NSArray arrayWithObjects:value, nil]
                           rule:rule
                   catalogField:catalogField];
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"{\"f\":\""];
    [ret appendString:_catalogField];
    [ret appendString:@"\",\"r\":\""];
    [ret appendString:_rule];
    [ret appendString:@"\",\"v\":\""];
    [ret appendString:[_values serializeWithSeparator:@"|"]];
    [ret appendString:@"\",\"n\":"];
    [ret appendString:[self isKindOfClass:[EMExcludeCommand class]] ? @"false"
                                                                    : @"true"];
    [ret appendString:@"}"];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
