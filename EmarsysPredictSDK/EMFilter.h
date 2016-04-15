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

#import "EMCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMFilter : EMCommand

- (instancetype)initWithValues:(NSArray<NSString *> *)values
                          rule:(NSString *)rule
                  catalogField:(NSString *)catalogField;

- (instancetype)initWithValue:(NSString *)value
                         rule:(NSString *)rule
                 catalogField:(NSString *)catalogField;

@property(readwrite) NSString *catalogField;
@property(readwrite) NSString *rule;
@property(readwrite) NSArray<NSString *> *values;

@end

NS_ASSUME_NONNULL_END
