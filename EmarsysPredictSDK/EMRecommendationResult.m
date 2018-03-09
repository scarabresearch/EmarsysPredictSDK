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

#import "EMRecommendationResult.h"
#import "EMRecommendationResult+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMRecommendationResult {
    NSMutableArray<EMRecommendationItem *> *_products;
}
@synthesize products = _products;

- (instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initWithFields:(NSString *)cohort
                     featureID:(NSString *)featureID
                         topic:(nullable NSString *)topic {
    self = [super init];
    if (self) {
        _products = [[NSMutableArray<EMRecommendationItem *> alloc] init];
        _cohort = cohort;
        _featureID = featureID;
        _topic = topic;
    }
    return self;
}

- (void)addProduct:(EMRecommendationItem *)product {
    [_products addObject:product];
}

@end

NS_ASSUME_NONNULL_END
