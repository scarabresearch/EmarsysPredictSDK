//
//  EMIncludeCommand.m
//  EmarsysPredictSDK
//

#import "EMIncludeCommand.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMIncludeCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    [self.values
        enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx,
                                     BOOL *_Nonnull stop) {
          if ([obj length] == 0) {
              [ret addObject:[self emptyStringEMErr:@"include"
                                              field:self.catalogField]];
          }
        }];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
