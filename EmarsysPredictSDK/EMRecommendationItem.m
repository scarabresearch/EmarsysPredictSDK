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

#import "EMRecommendationItem.h"
#import "EMRecommendationItem+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationItem ()

/// Recommendation result.
@property(weak, readonly) EMRecommendationResult *result;
@end

@implementation EMRecommendationItem {
    NSMutableDictionary<NSString *, id> *_data;
}
@synthesize data = _data;

- (instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initWithResult:(EMRecommendationResult *)result {
    self = [super init];
    if (self) {
        _result = result;
        _data = [[NSMutableDictionary<NSString *, id> alloc] init];
    }
    return self;
}

- (void)addField:(NSString *)key value:(id)value {
    [_data setObject:value forKey:key];
}

- (NSString *)description {
    NSString *_Nullable item = [_data valueForKey:@"item"];
    return item ? (NSString *)item : [super description];
}

@end

NS_ASSUME_NONNULL_END
