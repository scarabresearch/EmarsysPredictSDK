//
//  EMCategoryCommand.m
//  EmarsysMobile
//

#import "EMCategoryCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMCategoryCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([self.value length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"category" field:@"category"]];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
