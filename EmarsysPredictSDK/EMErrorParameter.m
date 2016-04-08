//
//  EMErrorParameter.m
//  EmarsysPredictSDK
//

#import "EMErrorParameter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMErrorParameter

- (instancetype)initWithType:(NSString *)type
                     command:(NSString *)command
                     message:(NSString *)message {
    self = [super init];
    if (self) {
        _type = type;
        _command = command;
        _message = message;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"{\"t\":\""];
    [ret appendString:_type];
    [ret appendString:@"\",\"c\":\""];
    [ret appendString:_command];
    [ret appendString:@"\",\"m\":\""];
    [ret appendString:_message];
    [ret appendString:@"\"}"];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
