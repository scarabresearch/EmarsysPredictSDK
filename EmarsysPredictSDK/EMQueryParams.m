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

#import "EMQueryParams.h"
#import "NSArray+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMQueryParams

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = [[NSMutableDictionary<NSString *, NSString *> alloc] init];
    }
    return self;
}

- (void)add:(NSString *)key stringValue:(NSString *)value {
    NSMutableCharacterSet *allowedCharacterSet = [[NSMutableCharacterSet alloc]init];
    [allowedCharacterSet formUnionWithCharacterSet:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [allowedCharacterSet removeCharactersInString:@"&"];
    
    NSString *encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacterSet];
    [_data setValue:encodedValue
             forKey:key];
}

- (void)add:(NSString *)key intValue:(int)value {
    [_data setValue:[NSString stringWithFormat:@"%i", value] forKey:key];
}

- (NSString *)description {
    NSMutableArray<NSString *> *a = [[NSMutableArray<NSString *> alloc] init];
    [_data enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key,
                                               NSString *_Nonnull obj,
                                               BOOL *_Nonnull stop) {
      [a addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
    }];
    return [a serializeWithSeparator:@"&"];
}

@end

NS_ASSUME_NONNULL_END
