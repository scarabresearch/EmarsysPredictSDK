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

#import <CommonCrypto/CommonDigest.h>

#import "NSArray+EmarsysPredictSDKExtensions.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSArray (EmarsysPredictSDKExtensions)

- (NSString *)serializeWithSeparator:(NSString *)separator {
    NSMutableString *ret = [[NSMutableString alloc] init];
    const NSUInteger lastIndex = self.count - 1;
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                       BOOL *_Nonnull stop) {
      [ret appendString:[obj description]];
      if (lastIndex != idx) {
          [ret appendString:separator];
      }
    }];
    return ret;
}

@end

NS_ASSUME_NONNULL_END
