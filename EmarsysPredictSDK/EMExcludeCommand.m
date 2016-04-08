//
//  EMExcludeCommand.m
//  EmarsysPredictSDK
//

#import "EMExcludeCommand.h"
#import "EMErrorParameter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMExcludeCommand

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    [self.values
        enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx,
                                     BOOL *_Nonnull stop) {
          if ([obj length] == 0) {
              [ret addObject:[self emptyStringEMErr:@"exclude"
                                              field:self.catalogField]];
          }
        }];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
