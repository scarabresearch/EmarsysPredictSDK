//
//  EMStringCommand.m
//  EmarsysPredictSDK
//

#import "EMStringCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMStringCommand

- (instancetype)initWithValue:(NSString *)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSString *)description {
    return _value;
}

@end

NS_ASSUME_NONNULL_END
