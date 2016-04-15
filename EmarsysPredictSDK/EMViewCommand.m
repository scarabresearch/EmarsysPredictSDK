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

#import "EMViewCommand.h"
#import "EMRecommendationItem+EmarsysPredictSDKExtensions.h"
#import "EMLogger.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMViewCommand

- (instancetype)initWithItemID:(NSString *)itemID
                   trackedItem:(nullable EMRecommendationItem *)trackedItem {
    self = [super init];
    if (self) {
        _itemID = itemID;
        _trackedItem = trackedItem;
    }
    return self;
}

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    if ([_itemID length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"view" field:@"itemID"]];
    }
    return ret;
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"i:"];
    [ret appendString:_itemID];

    EMRecommendationItem *trackedItem = _trackedItem;
    if (trackedItem) {
        [ret appendString:@",t:"];
        [ret appendString:trackedItem.result.featureID];
        [ret appendString:@",c:"];
        [ret appendString:trackedItem.result.cohort];
    }
    return ret;
}

@end

NS_ASSUME_NONNULL_END
