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

#import "EMSession.h"

#define DLOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelDebug) {               \
        NSLog(__VA_ARGS__);                                                    \
    }
#define ILOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelInfo) {                \
        NSLog(__VA_ARGS__);                                                    \
    }
#define WLOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelWarning) {             \
        NSLog(__VA_ARGS__);                                                    \
    }
#define ELOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelError) {               \
        NSLog(__VA_ARGS__);                                                    \
    }
