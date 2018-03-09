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

#import "EMCartItem.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMCartItem

- (instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

+ (instancetype)itemWithItemID:(NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity {
    return [[EMCartItem alloc] initWithItemID:itemID
                                        price:price
                                     quantity:quantity];
}

- (instancetype)initWithItemID:(nonnull NSString *)itemID
                         price:(float)price
                      quantity:(int)quantity {
    self = [super init];
    if (self) {
        _itemID = itemID;
        _price = price;
        _quantity = quantity;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
