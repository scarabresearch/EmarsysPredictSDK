//
//  EMCommand.m
//  EmarsysMobile
//

#import "EMCommand.h"
#import "EMLogger.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMCommand

- (NSArray<EMErrorParameter *> *)validate {
    return [NSArray<EMErrorParameter *> array];
}

- (EMErrorParameter *)emptyStringEMErr:(NSString *)command
                                 field:(NSString *)field {
    NSString *message = [NSString
        stringWithFormat:
            @"Invalid argument in %@ command: %@ should not be an empty string",
            command, field];
    DLOG(@"%@", message);
    return [[EMErrorParameter alloc] initWithType:@"INVALID_ARG"
                                          command:command
                                          message:message];
}

@end

NS_ASSUME_NONNULL_END
