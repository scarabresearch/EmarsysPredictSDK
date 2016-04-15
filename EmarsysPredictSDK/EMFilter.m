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

#import "EMFilter.h"
#import "EMExcludeCommand.h"
#import "EMIncludeCommand.h"
#import "NSArray+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMFilter

- (instancetype)initWithValues:(NSArray<NSString *> *)values
                          rule:(NSString *)rule
                  catalogField:(NSString *)catalogField {
    self = [super init];
    if (self) {
        _values = values;
        _rule = rule;
        _catalogField = catalogField;
    }
    return self;
}

- (instancetype)initWithValue:(NSString *)value
                         rule:(NSString *)rule
                 catalogField:(NSString *)catalogField {
    return [self initWithValues:[NSArray arrayWithObjects:value, nil]
                           rule:rule
                   catalogField:catalogField];
}

- (NSString *)description {
    NSMutableString *ret = [[NSMutableString alloc] init];
    [ret appendString:@"{\"f\":\""];
    [ret appendString:_catalogField];
    [ret appendString:@"\",\"r\":\""];
    [ret appendString:_rule];
    [ret appendString:@"\",\"v\":\""];
    [ret appendString:[_values serializeWithSeparator:@"|"]];
    [ret appendString:@"\",\"n\":"];
    [ret appendString:[self isKindOfClass:[EMExcludeCommand class]] ? @"false"
                                                                    : @"true"];
    [ret appendString:@"}"];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
