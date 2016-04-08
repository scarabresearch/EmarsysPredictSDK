//
//  EMAvailabilityZoneCommand.m
//  EmarsysPredictSDK
//

#import "EMAvailabilityZoneCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMAvailabilityZoneCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([self.value length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"availabilityZone"
                                        field:@"availabilityZone"]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
