//
//  EMSearchTermCommand.m
//  EmarsysMobile
//

#import "EMSearchTermCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMSearchTermCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([self.value length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"searchTerm"
                                        field:@"searchTerm"]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
