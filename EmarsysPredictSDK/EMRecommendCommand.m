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

#import "EMRecommendCommand.h"
#import "EMLogger.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMRecommendCommand

- (instancetype)initWithEMRecommendationRequest:
    (EMRecommendationRequest *)recommendationRequest {
    self = [super init];
    if (self) {
        _recommendationRequest = recommendationRequest;
    }
    return self;
}

- (NSArray<EMErrorParameter *> *)validate {
    NSMutableArray<EMErrorParameter *> *ret =
        [NSMutableArray<EMErrorParameter *> array];
    // Validate logic
    if ([_recommendationRequest.logic length] == 0) {
        [ret addObject:[self emptyStringEMErr:@"recommend" field:@"logic"]];
    }
    // Validate all baselines
    [_recommendationRequest.baseline
        enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx,
                                     BOOL *_Nonnull stop) {
          if ([obj length] == 0) {
              [ret addObject:[self emptyStringEMErr:@"recommend"
                                              field:@"baseline"]];
          }
        }];
    // Validate all filters
    [_recommendationRequest.filters
        enumerateObjectsUsingBlock:^(EMFilter *_Nonnull obj, NSUInteger idx,
                                     BOOL *_Nonnull stop) {
          [ret addObjectsFromArray:[obj validate]];
        }];
    return ret;
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"f:"];
    [ret appendString:_recommendationRequest.logic];
    [ret appendString:@",l:"];
    [ret appendString:[NSString stringWithFormat:@"%i",
                                                 _recommendationRequest.limit]];
    [ret appendString:@",o:"];
    [ret appendString:[NSString stringWithFormat:@"%i", 0]];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
