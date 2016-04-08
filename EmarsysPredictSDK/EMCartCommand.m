//
//  EMCartCommand.m
//  EmarsysPredictSDK
//

@import Foundation;

#import "EMCartCommand.h"
#import "NSArray+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMCartCommand

- (instancetype)initWithItems:(NSArray<EMCartItem *> *)items {
    self = [super init];
    if (self) {
        _items = items;
    }
    return self;
}

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    [_items enumerateObjectsUsingBlock:^(EMCartItem *_Nonnull obj,
                                         NSUInteger idx, BOOL *_Nonnull stop) {
      if ([obj.itemID length] == 0) {
          [ret addObject:[self emptyStringEMErr:@"cart" field:@"itemID"]];
      }
    }];
    return ret;
}

- (NSString *)description {
    NSMutableArray<NSString *> *a = [[NSMutableArray<NSString *> alloc] init];
    [_items enumerateObjectsUsingBlock:^(EMCartItem *_Nonnull obj,
                                         NSUInteger idx, BOOL *_Nonnull stop) {
      NSMutableString *s = [[NSMutableString alloc] init];
      [s appendString:@"i:"];
      [s appendString:obj.itemID];
      [s appendString:@",p:"];
      [s appendString:[NSString stringWithFormat:@"%f", obj.price]];
      [s appendString:@",q:"];
      [s appendString:[NSString stringWithFormat:@"%i", obj.quantity]];
      [a addObject:s];
    }];
    return [a serializeWithSeparator:@"|"];
}

@end

NS_ASSUME_NONNULL_END
