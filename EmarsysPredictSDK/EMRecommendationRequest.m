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

#import "EMRecommendationRequest+EmarsysPredictSDKExtensions.h"
#import "NSString+EmarsysPredictSDKExtensions.h"
#import "EMFilter.h"
#import "EMExcludeCommand.h"
#import "EMIncludeCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMRecommendationRequest ()

@property(readwrite) NSMutableArray<EMFilter *> *filters;

@end

@implementation EMRecommendationRequest

- (instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initWithLogic:(NSString *)logic {
    self = [super init];
    if (self) {
        _logic = logic;
        _limit = 5;
        _filters = [[NSMutableArray<EMFilter *> alloc] init];
        _completionHandler = ^(EMRecommendationResult *result) {

        };
    }
    return self;
}

+ (instancetype)requestWithLogic:(NSString *)logic {
    return [[EMRecommendationRequest alloc] initWithLogic:logic];
}

- (void)excludeItemsWhere:(NSString *)catalogField is:(NSString *)value {
    EMFilter *f = [[EMExcludeCommand alloc] initWithValue:value
                                                     rule:@"IS"
                                             catalogField:catalogField];
    [_filters addObject:f];
}

- (void)excludeItemsWhere:(NSString *)catalogField
                     isIn:(NSArray<NSString *> *)values {
    EMFilter *f = [[EMExcludeCommand alloc] initWithValues:values
                                                      rule:@"IN"
                                              catalogField:catalogField];
    [_filters addObject:f];
}

- (void)excludeItemsWhere:(NSString *)catalogField has:(NSString *)value {
    EMFilter *f = [[EMExcludeCommand alloc] initWithValue:value
                                                     rule:@"HAS"
                                             catalogField:catalogField];
    [_filters addObject:f];
}

- (void)excludeItemsWhere:(NSString *)catalogField
                 overlaps:(NSArray<NSString *> *)values {
    EMFilter *f = [[EMExcludeCommand alloc] initWithValues:values
                                                      rule:@"OVERLAPS"
                                              catalogField:catalogField];
    [_filters addObject:f];
}

- (void)includeItemsWhere:(NSString *)catalogField is:(NSString *)value {
    EMFilter *f = [[EMIncludeCommand alloc] initWithValue:value
                                                     rule:@"IS"
                                             catalogField:catalogField];
    [_filters addObject:f];
}

- (void)includeItemsWhere:(NSString *)catalogField
                     isIn:(NSArray<NSString *> *)values {
    EMFilter *f = [[EMIncludeCommand alloc] initWithValues:values
                                                      rule:@"IN"
                                              catalogField:catalogField];
    [_filters addObject:f];
}

- (void)includeItemsWhere:(NSString *)catalogField has:(NSString *)value {
    EMFilter *f = [[EMIncludeCommand alloc] initWithValue:value
                                                     rule:@"HAS"
                                             catalogField:catalogField];
    [_filters addObject:f];
}

- (void)includeItemsWhere:(NSString *)catalogField
                 overlaps:(NSArray<NSString *> *)values {
    EMFilter *f = [[EMIncludeCommand alloc] initWithValues:values
                                                      rule:@"OVERLAPS"
                                              catalogField:catalogField];
    [_filters addObject:f];
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"f:"];
    [ret appendString:_logic];
    [ret appendString:@",l:"];
    [ret appendString:[NSString stringWithFormat:@"%i", _limit]];
    [ret appendString:@",o:"];
    [ret appendString:[NSString stringWithFormat:@"%i", 0]];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
