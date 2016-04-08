//
//  EMKeywordCommand.m
//  EmarsysPredictSDK
//

#import "EMKeywordCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMKeywordCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([self.value length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"keyword" field:@"keyword"]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
