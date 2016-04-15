/*
 * Copyright 2016 Scarab Research Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
