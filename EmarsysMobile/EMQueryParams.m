//
//  QueryParams.m
//  EmarsysMobile
//

@import Foundation;

#import "EMQueryParams.h"
#import "NSArray+EmarsysMobileExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMQueryParams

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
    }
    return self;
}

- (void)add:(NSString *)key stringValue:(NSString *)value {
    [_data setValue:value forKey:key];
}

- (void)add:(NSString *)key intValue:(int)value {
    [_data setValue:[NSString stringWithFormat:@"%i", value] forKey:key];
}

- (NSString *)description {
    NSMutableArray<NSString *> *a = [[NSMutableArray<NSString *> alloc] init];
    [_data enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key,
                                               NSString *_Nonnull obj,
                                               BOOL *_Nonnull stop) {
      [a addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    return [a serializeWithSeparator:@"&"];
}

@end

NS_ASSUME_NONNULL_END
